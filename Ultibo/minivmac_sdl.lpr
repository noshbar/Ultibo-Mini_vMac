program minivmac_sdl;

{$mode objfpc}{$H+}

{$IFNDEF PLATFORM_PI3}
  {$IFNDEF PLATFORM_PI2}
    {$DEFINE PLATFORM_QEMU}
  {$ENDIF}
{$ENDIF}

uses
{$IFDEF PLATFORM_PI2}
  RaspberryPi2,
{$ENDIF}
{$IFDEF PLATFORM_PI3}
  RaspberryPi3,
{$ENDIF}
{$IFDEF PLATFORM_QEMU}
  QEMUVersatilePB,
{$ENDIF}
  GlobalConfig,
  GlobalConst,
  GlobalTypes,
  Platform,
  Threads,
  SysUtils,
  Classes,
  Ultibo,
  Syscalls,
  Console,
  FileSystem,
  FATFS,
  MMC,
  Framebuffer,
  keyboard,
  Mouse,
  mackeymap;

{$linklib minivmac}

var
  FramebufferDevice     : PFramebufferDevice;
  FramebufferProperties : TFramebufferProperties;
  BufferStart           : Pointer;
  PageSize              : Integer;
  CurrentPage           : Integer;

  GfxWidth, GfxHeight   : Integer;

  currentKeyDown        : Integer;
  previousMouseX        : Integer;
  previousMouseY        : Integer;

{$IFDEF PLATFORM_QEMU}
const RUNDELAY = 100;
{$ELSE}
const RUNDELAY = 500;
{$ENDIF}

// Imports from the library:

procedure MAC_LOOP(rom : pchar; disk : pchar); cdecl; external 'libminivmac' name 'LOOP';

// Exports to the library:

procedure Pal_getMousePosition(var x : integer; var y : integer); export; cdecl;
var
  data : TMouseData;
  count : LongWord;
begin
  if (MousePeek() = ERROR_SUCCESS) then
  begin
    MouseRead(@data, sizeof(data), count);
    x := data.OffsetX;
    y := data.OffsetY;
  end;
end;

function Pal_getBytesPerPixel() : integer; export; cdecl;
begin
  Result := 4;
end;

function Pal_getScreenPitch() : integer; export; cdecl;
begin
  Result := FramebufferProperties.Pitch;
end;

function Pal_getFrameBuffer() : pointer; export; cdecl;
begin
  Result := BufferStart + (CurrentPage * PageSize);
end;

procedure Pal_drawBuffer(); export; cdecl;
var
  OffsetX, OffsetY : integer;
begin
  if (FramebufferProperties.Flags and FRAMEBUFFER_FLAG_CACHED) <> 0 then
  begin
    CleanDataCacheRange(PtrUInt(BufferStart) + (CurrentPage * PageSize), PageSize);
  end;

  OffsetX := 0;
  OffsetY := CurrentPage * FramebufferProperties.PhysicalHeight;
  FramebufferDeviceSetOffset(FramebufferDevice, OffsetX, OffsetY, True);

  if (FramebufferProperties.Flags and FRAMEBUFFER_FLAG_SYNC) <> 0 then
  begin
    FramebufferDeviceWaitSync(FramebufferDevice);
  end
end;

function Pal_getTicks() : ULONG; export; cdecl;
begin
  Result := GetTickCount();
end;

function Pal_init() : integer; export; cdecl;
begin
  Result := 1;
end;

procedure Pal_createFrameBuffer(width, height, bpp : integer); export; cdecl;
begin
  // We know we'll always need to be graphical, so initialise the framebuffer at startup

  // TODO: Use these to center screen later
  GfxWidth := width;
  GfxHeight := height;
end;

procedure Pal_reset(); export; cdecl;
begin
  RestartComputer(0);
end;

procedure Pal_delay(amount : integer); export; cdecl;
begin
  Sleep(amount);
end;

procedure Pal_getKey(var value : integer; var down : integer); export; cdecl;
var
 Count:LongWord;
 Data:TKeyboardData;
begin
  down := 0;

  if (currentKeyDown <> -1) then
  begin
    value := currentKeyDown;
    currentKeyDown := -1;
    exit;
  end;

  if KeyboardReadEx(@Data, SizeOf(TKeyboardData), KEYBOARD_FLAG_NONE, Count) = ERROR_SUCCESS then
  begin
    if (Data.KeyCode = KEY_CODE_F12) then SystemRestart(0);

    if (Data.Modifiers and (KEYBOARD_KEYUP or KEYBOARD_DEADKEY)) = 0 then
    begin
      value := ScancodeToMac(Data.ScanCode);
      down := 1;
    end;
  end;
end;

function Pal_peekKey() : integer; export; cdecl;
begin
  Result := 0;

  if (currentKeyDown <> -1) then
  begin
    Result := 1;
    exit;
  end;

  if (KeyboardPeek() = ERROR_SUCCESS) then
    Result := 1;
end;

function Pal_peekMouse() : integer; export; cdecl;
var
  data : TMouseData;
  count : LongWord;
begin
  Result := 0;
  if (MousePeek() = ERROR_SUCCESS) then
    Result := 1;
end;

// This bit of hackery is due to the trackpad on my Motorola Dock not working as expected.
// The X axis seems to affect the Y axis, and I can't make the X move at all.
// It's not like any of this code fixes it, but I did end up learning that movements might
// come through as deltas instead of absolutes.
{$IF 0}
procedure Pal_getMouse(var x : integer; var y : integer; var down : integer); export; cdecl;
var
  data : TMouseData;
  count : LongWord;
begin
  MouseRead(@data, sizeof(data), count);
  x := data.OffsetX;
  y := data.OffsetY;
  if (data.Buttons AND MOUSE_LEFT_BUTTON) <> 0 then
    down := 1
  else
    down := 0;
end;
{$ELSE}
procedure Pal_getMouse(var x : integer; var y : integer; var down : integer); export; cdecl;
var
  data : TMouseData;
  count : LongWord;
begin
  MouseRead(@data, sizeof(data), count);

  if (data.Buttons AND MOUSE_ABSOLUTE_X) <> 0 then
  begin
    if (previousMouseX = -1) then
      x := 0
    else
      x := data.OffsetX - previousMouseX;

    previousMouseX := data.OffsetX;
  end else
  begin
    x := data.OffsetX;
  end;

  if (data.Buttons AND MOUSE_ABSOLUTE_Y) <> 0 then
  begin
    if (previousMouseY = -1) then
      y := 0
    else
      y := data.OffsetY - previousMouseY;

    previousMouseY := data.OffsetY;
  end else
  begin
    y := data.OffsetY;
  end;

  if (data.Buttons AND MOUSE_LEFT_BUTTON) <> 0 then
    down := 1
  else
    down := 0;
end;
{$ENDIF}

// Entry point:

begin
  ThreadSetCPU(ThreadGetCurrent, CPU_ID_3);
  Sleep(0);

  // This breaks framebuffer ininitialisation into two parts because it's suggested that
  // you sleep between allocating the buffer and getting its properties, but seeing as
  // we need to wait for the disk to be available, we can effectively cut out a wait
  // and use one alone the way.
  FramebufferDevice := FramebufferDeviceGetDefault;
  FramebufferDeviceGetProperties(FramebufferDevice, @FramebufferProperties);
  FramebufferDeviceRelease(FramebufferDevice);
  Sleep(RUNDELAY);
  FramebufferProperties.Depth := 32; // should be set by emu though
  FramebufferProperties.VirtualWidth:= FramebufferProperties.PhysicalWidth;
  FramebufferProperties.VirtualHeight := FramebufferProperties.PhysicalHeight*2;

  FRAMEBUFFER_CONSOLE_AUTOCREATE := False;
  FramebufferDeviceAllocate(FramebufferDevice, @FramebufferProperties);

  while not DirectoryExists('C:\') do
  begin
    Sleep(100);
  end;

  FramebufferDeviceGetProperties(FramebufferDevice, @FramebufferProperties);
  BufferStart := Pointer(FramebufferProperties.Address);
  PageSize := FramebufferProperties.Pitch * FramebufferProperties.PhysicalHeight;
  CurrentPage := 0; // Toggling this between 0 and 1 seems to create artefacts

  currentKeyDown := -1;
  previousMouseX := -1;
  previousMouseY := -1;
  try
    MAC_LOOP('C:\vMac.ROM', 'C:\224M.dsk');
  except
    on E:exception do
    begin
      ConsoleWriteLn(E.Message);
    end;
  end;
end.

