#ifndef gameobject__h
#define gameobject__h

#include <stdint.h>
#include <stdbool.h>

typedef struct gameobject_t {
  uint8_t x_pos;
  uint8_t y_pos;
  uint8_t sprite;
  uint8_t active;
} gameobject_t;

void reset_gameobject(gameobject_t* p_gameobject) {
  p_gameobject->x_pos = 0;
  p_gameobject->y_pos = 0;
  p_gameobject->active = false;
}

#endif