#pragma once

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned char Uint8;
typedef unsigned short Uint16;
typedef unsigned int Uint32;

void Pal_getMousePosition(int *x, int *y);
int Pal_getBytesPerPixel();
int Pal_getScreenPitch();
char* Pal_getFrameBuffer();
void Pal_drawBuffer();
unsigned long Pal_getTicks();
int Pal_init();
void Pal_createFrameBuffer(int width, int height, int bpp);
void Pal_reset(); // Not sure this is needed
void Pal_delay(int amount);
void Pal_getKey(int *value, int *down);
int Pal_peekKey();
int Pal_peekMouse();
void Pal_getMouse(int *x, int *y, int *down);

#ifdef __cplusplus
}
#endif
