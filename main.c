#include <gb/gb.h>
#include <stdint.h>
#include <stdbool.h>
#include "media/sprites.c"
#include "mapTiles.c"
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
void Init();
void InitPlayer();
void InitBullets();
void InitEnemies();

void CheckInput();
void FireBullet();

void UpdateBullets();
void UpdateEnemies();
void CheckCollisions();
void UpdateSwitches();

//this will hold out count of sprites
uint8_t spriteCount;

// The player game object
struct GameObject player;

//bullets
struct GameObject bullets[MAX_BULLETS];

//fire button cooldown
uint8_t bulletCooldown;

//enemy pool
struct GameObject enemies[MAX_ENEMIES];

//enemy cooldown is used to control the speed of the enemies movement by skipping frames of UpdateSwitches
uint8_t enemyUpdateCooldown;
uint8_t enemySpawnTimer;


void main() {

	Init();

	while(1) {

		CheckInput();				// Check for user input (and act on it)
    UpdateBullets();
    UpdateEnemies();
    CheckCollisions();
		UpdateSwitches();			// Make sure the SHOW_SPRITES and SHOW_BKG switches are on each loop
		wait_vbl_done();			// Wait until VBLANK to avoid corrupting memory
	}

}

void Init() {

	DISPLAY_ON;						// Turn on the display

  set_bkg_data(0, 1, mapTiles);

	// Load the the 'sprites' tiles into sprite memory
  spriteCount = 0;
	set_sprite_data(0, 4, Sprites);

  InitPlayer();
  InitBullets();
  InitEnemies();
}

void InitPlayer() {

	// Set the first movable sprite (0) to be the first tile in the sprite memory (0)
  player.xPos = PLAYER_SPAWN_X;
  player.yPos = PLAYER_SPAWN_Y;
  player.sprite = spriteCount;
  player.active = true;
	set_sprite_tile(spriteCount, PLAYER_TILE);
  move_sprite(spriteCount, player.xPos, player.yPos);
  spriteCount++;
}

void InitBullets()
{
  uint8_t i;
  for(i = 0; i < MAX_BULLETS; i++)
  {
    bullets[i].xPos = 0;
    bullets[i].yPos = 0;
    bullets[i].sprite = spriteCount;
    bullets[i].active = false;
    set_sprite_tile(spriteCount, BULLET_TILE);
    move_sprite(spriteCount, 16*i, 20);
    spriteCount++;
  }
}

void InitEnemies()
{
  uint8_t i;
  for(i = 0; i < MAX_ENEMIES; i++)
  {
    enemies[i].xPos = (i+1)*16;
    enemies[i].yPos = 0;
    enemies[i].sprite = spriteCount;
    enemies[i].active = 0;
    set_sprite_tile(spriteCount, ENEMY_TILE);
    move_sprite(spriteCount, enemies[i].xPos, enemies[i].yPos);
    spriteCount++;
  }
}

void UpdateSwitches() {
	HIDE_WIN;
	SHOW_SPRITES;
	SHOW_BKG;
}

void CheckInput() {

  // LEFT
	if (joypad() & J_LEFT) {

	  player.xPos--;

	}

	// RIGHT
	if (joypad() & J_RIGHT) {

		player.xPos++;

  }

  // RIGHT
	if (joypad() & J_B) {
    if(bulletCooldown > BULLET_COOLDOWN)
    {
        FireBullet();
        bulletCooldown = 0;
    }
  }

  move_sprite(PLAYER_SPRITE, player.xPos, player.yPos);
}

void FireBullet()
{
  uint8_t i;
  for(i = 0; i < MAX_BULLETS; i++) {
    if(bullets[i].active == 0)
    {
      bullets[i].xPos = player.xPos;
      bullets[i].yPos = player.yPos;
      bullets[i].active = 1;
      return;
    }
  }
}

void UpdateBullets()
{
  uint8_t i;
  for(i = 0; i < MAX_BULLETS; i++) {
    if(bullets[i].active == 0) {
        bullets[i].xPos = 0;
        bullets[i].yPos = 0;
    }
    else
    {
      bullets[i].yPos --;
    }

    if(bullets[i].yPos < 8) {
      bullets[i].active = 0;
    }

    move_sprite(bullets[i].sprite, bullets[i].xPos, bullets[i].yPos);
  }

  bulletCooldown++;
}

void UpdateEnemies()
{
  uint8_t i;
  //only update if cooldown is over
  if(enemyUpdateCooldown > ENEMY_UPDATE_COOLDOWN) {

    enemyUpdateCooldown = 0;

    for(i = 0; i < MAX_ENEMIES; i++)
    {
      if(enemies[i].active == false) {
          enemies[i].xPos = 0;
          enemies[i].yPos = 0;
      }
      else
      {
        enemies[i].yPos++;
      }

      if(enemies[i].yPos > 160) {
        enemies[i].active = false;
        enemies[i].xPos = 0;
        enemies[i].yPos = 0;
      }

      move_sprite(enemies[i].sprite, enemies[i].xPos, enemies[i].yPos);
    }
  }
  else {
    enemyUpdateCooldown++;
  }

  if(enemySpawnTimer > ENEMY_SPAWN_TIME)
  {
    enemySpawnTimer = 0;
    for(i = 0; i < MAX_ENEMIES; i++) {
        if(enemies[i].active == false)
        {
          enemies[i].active = true;
          enemies[i].yPos = 8;
          enemies[i].xPos = rand() %112+16;
          break;
        }
    }
  }
  else
  {
    enemySpawnTimer++;
  }
}


bool CheckAABBCollision(struct GameObject * pObjectA, struct GameObject * pObjectB) {

  if(pObjectA->xPos > (pObjectB->xPos + GAMEOBJECT_WIDTH)) {
    return false;
  }
  if(pObjectA->xPos + GAMEOBJECT_WIDTH < pObjectB->xPos) {
    return false;
  }
  if(pObjectA->yPos > pObjectB->yPos + GAMEOBJECT_HEIGHT) {
    return false;
  }
  if(pObjectA->yPos + GAMEOBJECT_HEIGHT < pObjectB->yPos) {
    return false;
  }

  return true;
}

void CheckCollisions()
{
  uint8_t i;
  uint8_t j;

  for(i = 0; i < MAX_BULLETS; i++)
  {
    if(bullets[i].active == 0)
    {
      continue;
    }

    //foreach enemy
    for(j = 0; j < MAX_ENEMIES; j++) {
      if(enemies[j].active == 0) {
        continue;
      }

      if(!CheckAABBCollision(&bullets[i], &enemies[j])) {
        continue; //no collision
      }

      //collision detected
      bullets[i].active = 0;
      bullets[i].xPos = 0;
      bullets[i].yPos = 0;

      enemies[j].active = 0;
      enemies[j].xPos = 0;
      enemies[j].yPos = 0;
    }
  }
}
