#ifndef gameobject__h
#define gameobject__h

#include <stdint.h>

typedef struct GameObject {
  uint8_t xPos;
  uint8_t yPos;
  uint8_t sprite;
  uint8_t active;
} GameObject;

#endif