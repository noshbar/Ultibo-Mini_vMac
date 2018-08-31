unit mackeymap;

{$mode objfpc}{$H+}

interface

function ScancodeToMac(scanCode : LongWord) : integer;

implementation

uses globalconst;

const MKC_A = $00;
const MKC_B = $0B;
const MKC_C = $08;
const MKC_D = $02;
const MKC_E = $0E;
const MKC_F = $03;
const MKC_G = $05;
const MKC_H = $04;
const MKC_I = $22;
const MKC_J = $26;
const MKC_K = $28;
const MKC_L = $25;
const MKC_M = $2E;
const MKC_N = $2D;
const MKC_O = $1F;
const MKC_P = $23;
const MKC_Q = $0C;
const MKC_R = $0F;
const MKC_S = $01;
const MKC_T = $11;
const MKC_U = $20;
const MKC_V = $09;
const MKC_W = $0D;
const MKC_X = $07;
const MKC_Y = $10;
const MKC_Z = $06;

const MKC_1 = $12;
const MKC_2 = $13;
const MKC_3 = $14;
const MKC_4 = $15;
const MKC_5 = $17;
const MKC_6 = $16;
const MKC_7 = $1A;
const MKC_8 = $1C;
const MKC_9 = $19;
const MKC_0 = $1D;

const MKC_Command = $37;
const MKC_Shift = $38;
const MKC_CapsLock = $39;
const MKC_Option = $3A;

const MKC_Space = $31;
const MKC_Return = $24;
const MKC_BackSpace = $33;
const MKC_Tab = $30;

const MKC_Left = $7B;
const MKC_Right = $7C;
const MKC_Down = $7D;
const MKC_Up = $7E;

const MKC_Minus = $1B;
const MKC_Equal = $18;
const MKC_BackSlash = $2A;
const MKC_Comma = $2B;
const MKC_Period = $2F;
const MKC_Slash = $2C;
const MKC_SemiColon = $29;
const MKC_SingleQuote = $27;
const MKC_LeftBracket = $21;
const MKC_RightBracket = $1E;
const MKC_Grave = $32;
const MKC_Clear = $47;
const MKC_KPEqual = $51;
const MKC_KPDevide = $4B;
const MKC_KPMultiply = $43;
const MKC_KPSubtract = $4E;
const MKC_KPAdd = $45;
const MKC_Enter = $4C;

const MKC_KP1 = $53;
const MKC_KP2 = $54;
const MKC_KP3 = $55;
const MKC_KP4 = $56;
const MKC_KP5 = $57;
const MKC_KP6 = $58;
const MKC_KP7 = $59;
const MKC_KP8 = $5B;
const MKC_KP9 = $5C;
const MKC_KP0 = $52;
const MKC_Decimal = $41;

///* these aren't on the Mac Plus keyboard */

const MKC_Control = $3B;
const MKC_Escape = $35;
const MKC_F1 = $7a;
const MKC_F2 = $78;
const MKC_F3 = $63;
const MKC_F4 = $76;
const MKC_F5 = $60;
const MKC_F6 = $61;
const MKC_F7 = $62;
const MKC_F8 = $64;
const MKC_F9 = $65;
const MKC_F10 = $6d;
const MKC_F11 = $67;
const MKC_F12 = $6f;

const MKC_Home = $73;
const MKC_End = $77;
const MKC_PageUp = $74;
const MKC_PageDown = $79;
const MKC_Help = $72;
const MKC_ForwardDel = $75;
const MKC_Print = $69;
const MKC_ScrollLock = $6B;
const MKC_Pause = $71;

function ScancodeToMac(scanCode : LongWord) : integer;
begin
      result := -1;

      case Scancode of
  	      SCAN_CODE_BACKSPACE: Result := MKC_BackSpace;
  	      SCAN_CODE_TAB: Result := MKC_Tab;
  	      SCAN_CODE_CLEAR: Result := MKC_Clear;
  	      SCAN_CODE_ENTER: Result := MKC_Return;
  	      SCAN_CODE_PAUSE: Result := MKC_Pause;
  	      SCAN_CODE_ESCAPE: Result := MKC_Escape;
  	      SCAN_CODE_SPACE: Result := MKC_Space;
  	      SCAN_CODE_APOSTROPHE: Result := MKC_SingleQuote;
  	      SCAN_CODE_COMMA: Result := MKC_Comma;
  	      SCAN_CODE_MINUS: Result := MKC_Minus;
  	      SCAN_CODE_PERIOD: Result := MKC_Period;
  	      SCAN_CODE_SLASH: Result := MKC_Slash;
  	      SCAN_CODE_0: Result := MKC_0;
  	      SCAN_CODE_1: Result := MKC_1;
  	      SCAN_CODE_2: Result := MKC_2;
  	      SCAN_CODE_3: Result := MKC_3;
  	      SCAN_CODE_4: Result := MKC_4;
  	      SCAN_CODE_5: Result := MKC_5;
  	      SCAN_CODE_6: Result := MKC_6;
  	      SCAN_CODE_7: Result := MKC_7;
  	      SCAN_CODE_8: Result := MKC_8;
  	      SCAN_CODE_9: Result := MKC_9;
  	      SCAN_CODE_SEMICOLON: Result := MKC_SemiColon;
  	      SCAN_CODE_EQUALS: Result := MKC_Equal;

  	      SCAN_CODE_LEFT_BRACE: Result := MKC_LeftBracket;
  	      SCAN_CODE_BACKSLASH: Result := MKC_BackSlash;
  	      SCAN_CODE_RIGHT_BRACE: Result := MKC_RightBracket;
  	      SCAN_CODE_GRAVE: Result := MKC_Grave;

  	      SCAN_CODE_a: Result := MKC_A;
  	      SCAN_CODE_b: Result := MKC_B;
  	      SCAN_CODE_c: Result := MKC_C;
  	      SCAN_CODE_d: Result := MKC_D;
  	      SCAN_CODE_e: Result := MKC_E;
  	      SCAN_CODE_f: Result := MKC_F;
  	      SCAN_CODE_g: Result := MKC_G;
  	      SCAN_CODE_h: Result := MKC_H;
  	      SCAN_CODE_i: Result := MKC_I;
  	      SCAN_CODE_j: Result := MKC_J;
  	      SCAN_CODE_k: Result := MKC_K;
  	      SCAN_CODE_l: Result := MKC_L;
  	      SCAN_CODE_m: Result := MKC_M;
  	      SCAN_CODE_n: Result := MKC_N;
  	      SCAN_CODE_o: Result := MKC_O;
  	      SCAN_CODE_p: Result := MKC_P;
  	      SCAN_CODE_q: Result := MKC_Q;
  	      SCAN_CODE_r: Result := MKC_R;
  	      SCAN_CODE_s: Result := MKC_S;
  	      SCAN_CODE_t: Result := MKC_T;
  	      SCAN_CODE_u: Result := MKC_U;
  	      SCAN_CODE_v: Result := MKC_V;
  	      SCAN_CODE_w: Result := MKC_W;
  	      SCAN_CODE_x: Result := MKC_X;
  	      SCAN_CODE_y: Result := MKC_Y;
  	      SCAN_CODE_z: Result := MKC_Z;

  	      SCAN_CODE_KEYPAD_0: Result := MKC_KP0;
  	      SCAN_CODE_KEYPAD_1: Result := MKC_KP1;
  	      SCAN_CODE_KEYPAD_2: Result := MKC_KP2;
  	      SCAN_CODE_KEYPAD_3: Result := MKC_KP3;
  	      SCAN_CODE_KEYPAD_4: Result := MKC_KP4;
  	      SCAN_CODE_KEYPAD_5: Result := MKC_KP5;
  	      SCAN_CODE_KEYPAD_6: Result := MKC_KP6;
  	      SCAN_CODE_KEYPAD_7: Result := MKC_KP7;
  	      SCAN_CODE_KEYPAD_8: Result := MKC_KP8;
  	      SCAN_CODE_KEYPAD_9: Result := MKC_KP9;

  	      SCAN_CODE_KEYPAD_PERIOD: Result := MKC_Decimal;
  	      SCAN_CODE_KEYPAD_SLASH: Result := MKC_KPDevide;
  	      SCAN_CODE_KEYPAD_ASTERISK: Result := MKC_KPMultiply;
  	      SCAN_CODE_KEYPAD_MINUS: Result := MKC_KPSubtract;
  	      SCAN_CODE_KEYPAD_PLUS: Result := MKC_KPAdd;
  	      SCAN_CODE_KEYPAD_ENTER: Result := MKC_Enter;
  	      SCAN_CODE_KEYPAD_EQUALS: Result := MKC_KPEqual;

  	      SCAN_CODE_UP_ARROW: Result := MKC_Up;
  	      SCAN_CODE_DOWN_ARROW: Result := MKC_Down;
  	      SCAN_CODE_RIGHT_ARROW: Result := MKC_Right;
  	      SCAN_CODE_LEFT_ARROW: Result := MKC_Left;
  	      SCAN_CODE_INSERT: Result := MKC_Help;
  	      SCAN_CODE_HOME: Result := MKC_Home;
  	      SCAN_CODE_END: Result := MKC_End;
  	      SCAN_CODE_PAGEUP: Result := MKC_PageUp;
  	      SCAN_CODE_PAGEDN: Result := MKC_PageDown;

  	      SCAN_CODE_F1: Result := MKC_F1;
  	      SCAN_CODE_F2: Result := MKC_F2;
  	      SCAN_CODE_F3: Result := MKC_F3;
  	      SCAN_CODE_F4: Result := MKC_F4;
  	      SCAN_CODE_F5: Result := MKC_F5;
  	      SCAN_CODE_F6: Result := MKC_F6;
  	      SCAN_CODE_F7: Result := MKC_F7;
  	      SCAN_CODE_F8: Result := MKC_F8;
  	      SCAN_CODE_F9: Result := MKC_F9;
  	      SCAN_CODE_F10: Result := MKC_F10;
  	      SCAN_CODE_F11: Result := MKC_F11;
  	      SCAN_CODE_F12: Result := MKC_F11;

  	      SCAN_CODE_NUMLOCK: Result := MKC_ForwardDel;
  	      SCAN_CODE_CAPSLOCK: Result := MKC_CapsLock;
  	      SCAN_CODE_SCROLLLOCK: Result := MKC_ScrollLock;
  	      SCAN_CODE_RIGHT_SHIFT: Result := MKC_Shift;
  	      SCAN_CODE_LEFT_SHIFT: Result := MKC_Shift;
  	      SCAN_CODE_RIGHT_CTRL: Result := MKC_Control;
  	      SCAN_CODE_LEFT_CTRL: Result := MKC_Control;
  	      SCAN_CODE_RIGHT_ALT: Result := MKC_Option;
  	      SCAN_CODE_LEFT_ALT: Result := MKC_Option;
  	      SCAN_CODE_RIGHT_GUI: Result := MKC_Command;
  	      SCAN_CODE_LEFT_GUI: Result := MKC_Command;

  	      SCAN_CODE_HELP: Result := MKC_Help;
  	      SCAN_CODE_PRINTSCREEN: Result := MKC_Print;
      end;
end;

end.

