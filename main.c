#include <gb/gb.h>
#include <stdint.h>
#include <stdbool.h>
#include "media/sprites.h"
#include "media/map_tiles.h"
#include "gameobject.h"

/*create out game constants here as defines*/
#define PLAYER_SPRITE 0
#define PLAYER_TILE 3
#define X 0
#define Y 1
#define PLAYER_SPAWN_X 80
#define PLAYER_SPAWN_Y 128

#define BULLET_TILE 2
#define MAX_BULLETS 10
#define BULLET_COOLDOWN 30

#define ENEMY_TILE 1
#define MAX_ENEMIES 7
#define ENEMY_UPDATE_COOLDOWN 1
#define ENEMY_SPAWN_TIME 60

#define GAMEOBJECT_WIDTH 8
#define GAMEOBJECT_HEIGHT 8

/*Predeclare our functions*/
void  init();
void  init_player();
void  init_bullets();
void  init_enemies();

void process_input();
void fire_bullet();

void update_bullets();
void update_enemies();
void process_collisions();
void update_switches();

//this will hold out count of sprites
uint8_t g_sprite_count;

// The player game object
gameobject_t player;

//bullets
gameobject_t bullets[MAX_BULLETS];

//fire button cooldown
uint8_t g_bullet_cooldown;

//enemy pool
gameobject_t enemies[MAX_ENEMIES];

//enemy cooldown is used to control the speed of the enemies movement by skipping frames of update_switches
uint8_t g_enemy_update_cooldown;
uint8_t g_enemy_spawn_timer;


void main() {

  init();

	while(true) {
		process_input();				// Check for user input (and act on it)
    update_bullets();
    update_enemies();
    process_collisions();
		update_switches();			// Make sure the SHOW_SPRITES and SHOW_BKG switches are on each loop
		wait_vbl_done();			// Wait until VBLANK to avoid corrupting memory
	}

}

void  init() {

	DISPLAY_ON;						// Turn on the display

  set_bkg_data(0, 1, map_tiles);

	// Load the the 'sprites' tiles into sprite memory
  g_sprite_count = 0;
	set_sprite_data(0, 4, sprites);

  init_player();
  init_bullets();
  init_enemies();
}

void  init_player() {

	// Set the first movable sprite (0) to be the first tile in the sprite memory (0)
  player.x_pos = PLAYER_SPAWN_X;
  player.y_pos = PLAYER_SPAWN_Y;
  player.sprite = g_sprite_count;
  player.active = true;
	set_sprite_tile(g_sprite_count, PLAYER_TILE);
  move_sprite(g_sprite_count, player.x_pos, player.y_pos);
  g_sprite_count++;
}

void  init_bullets()
{
  uint8_t i;
  for(i = 0; i < MAX_BULLETS; i++)
  {
    reset_gameobject(&bullets[i]);
    bullets[i].sprite = g_sprite_count;
    set_sprite_tile(bullets[i].sprite, BULLET_TILE);
    move_sprite(bullets[i].sprite, 16*i, 20);
    g_sprite_count++;
  }
}

void  init_enemies()
{
  uint8_t i;
  for(i = 0; i < MAX_ENEMIES; i++)
  {
    reset_gameobject(&enemies[i]);
    enemies[i].x_pos = (i+1)*16;
    enemies[i].sprite = g_sprite_count;
    set_sprite_tile(enemies[i].sprite, ENEMY_TILE);
    move_sprite(enemies[i].sprite, enemies[i].x_pos, enemies[i].y_pos);
    g_sprite_count++;
  }
}

void update_switches() {
	HIDE_WIN;
	SHOW_SPRITES;
	SHOW_BKG;
}

void process_input() {

  // LEFT
	if (joypad() & J_LEFT) {

	  player.x_pos--;

	}

	// RIGHT
	if (joypad() & J_RIGHT) {

		player.x_pos++;

  }

  // RIGHT
	if (joypad() & J_B) {
    if(g_bullet_cooldown > BULLET_COOLDOWN)
    {
        fire_bullet();
        g_bullet_cooldown = 0;
    }
  }

  move_sprite(PLAYER_SPRITE, player.x_pos, player.y_pos);
}

void fire_bullet()
{
  uint8_t i;
  for(i = 0; i < MAX_BULLETS; i++) {
    if(bullets[i].active == 0)
    {
      bullets[i].x_pos = player.x_pos;
      bullets[i].y_pos = player.y_pos;
      bullets[i].active = 1;
      return;
    }
  }
}

void update_bullets()
{
  uint8_t i;
  for(i = 0; i < MAX_BULLETS; i++) {
    if(bullets[i].active == 0) {
        bullets[i].x_pos = 0;
        bullets[i].y_pos = 0;
    }
    else
    {
      bullets[i].y_pos --;
    }

    if(bullets[i].y_pos < 8) {
      bullets[i].active = 0;
    }

    move_sprite(bullets[i].sprite, bullets[i].x_pos, bullets[i].y_pos);
  }

  g_bullet_cooldown++;
}

void update_enemies()
{
  uint8_t i;
  //only update if cooldown is over
  if(g_enemy_update_cooldown > ENEMY_UPDATE_COOLDOWN) {

    g_enemy_update_cooldown = 0;

    for(i = 0; i < MAX_ENEMIES; i++)
    {
      if(enemies[i].active == false) {
          enemies[i].x_pos = 0;
          enemies[i].y_pos = 0;
      }
      else
      {
        enemies[i].y_pos++;
      }

      if(enemies[i].y_pos > 160) {
        enemies[i].active = false;
        enemies[i].x_pos = 0;
        enemies[i].y_pos = 0;
      }

      move_sprite(enemies[i].sprite, enemies[i].x_pos, enemies[i].y_pos);
    }
  }
  else {
    g_enemy_update_cooldown++;
  }

  if(g_enemy_spawn_timer > ENEMY_SPAWN_TIME)
  {
    g_enemy_spawn_timer = 0;
    for(i = 0; i < MAX_ENEMIES; i++) {
        if(enemies[i].active == false)
        {
          enemies[i].active = true;
          enemies[i].y_pos = 8;
          enemies[i].x_pos = rand() %112+16;
          break;
        }
    }
  }
  else
  {
    g_enemy_spawn_timer++;
  }
}


bool check_aabb_collision(struct gameobject_t * p_object_a, struct gameobject_t * p_object_b) {

  if(p_object_a->x_pos > (p_object_b->x_pos + GAMEOBJECT_WIDTH)) {
    return false;
  }
  if(p_object_a->x_pos + GAMEOBJECT_WIDTH < p_object_b->x_pos) {
    return false;
  }
  if(p_object_a->y_pos > p_object_b->y_pos + GAMEOBJECT_HEIGHT) {
    return false;
  }
  if(p_object_a->y_pos + GAMEOBJECT_HEIGHT < p_object_b->y_pos) {
    return false;
  }

  return true;
}

void process_collisions()
{
  uint8_t i;
  uint8_t j;

  for(i = 0; i < MAX_BULLETS; i++)
  {
    if(bullets[i].active == false)
    {
      continue;
    }

    //foreach enemy
    for(j = 0; j < MAX_ENEMIES; j++) {
      if(enemies[j].active == false) {
        continue;
      }

      if(!check_aabb_collision(&bullets[i], &enemies[j])) {
        continue; //no collision
      }

      //collision detected
      bullets[i].active = 0;
      bullets[i].x_pos = 0;
      bullets[i].y_pos = 0;

      enemies[j].active = 0;
      enemies[j].x_pos = 0;
      enemies[j].y_pos = 0;
    }
  }
}

