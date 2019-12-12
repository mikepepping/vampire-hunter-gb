#include <gb/gb.h>
#include "sprites.c"
#include "mapTiles.c"

/*create out game constants here as defines*/
#define PLAYER_SPRITE 0
#define PLAYER_TILE 1
#define X 0
#define Y 1
#define PLAYER_SPAWN_X 80
#define PLAYER_SPAWN_Y 128

#define BULLET_TILE 2
#define MAX_BULLETS 10
#define BULLET_COOLDOWN 30

#define ENEMY_TILE 3
#define MAX_ENEMIES 7
#define ENEMY_UPDATE_COOLDOWN 1
#define ENEMY_SPAWN_TIME 60

#define GAMEOBJECT_WIDTH 8
#define GAMEOBJECT_HEIGHT 8

/*Predeclare our functions*/
void init();
void initBullets();
void initEnemies();

void checkInput();
void fireBullet();

void updateBullets();
void updateEnemies();
void checkCollisions();
void updateSwitches();

//this will hold out count of sprites
UINT8 spriteCount;

// The player array will hold the player's position as X ([0]) and Y ([1])
UINT8 playerPos[2];

//these will hold the data for all objects other than the player
struct GameObject {
  UINT8 xPos;
  UINT8 yPos;
  UINT8 sprite;
  UINT8 active;
};

//bullets
struct GameObject bullets[MAX_BULLETS];

//fire button cooldown
UINT8 bulletCooldown;

//enemy pool
struct GameObject enemies[MAX_ENEMIES];

//enemy cooldown is used to controll the speed of the enemies movement by skipping frames of updateSwitches
UINT8 enemyUpdateCooldown;
UINT8 enemySpawnTimer;


void main() {

	init();

	while(1) {

		checkInput();				// Check for user input (and act on it)
    updateBullets();
    updateEnemies();
    checkCollisions();
		updateSwitches();			// Make sure the SHOW_SPRITES and SHOW_BKG switches are on each loop
		wait_vbl_done();			// Wait until VBLANK to avoid corrupting memory
	}

}

void init() {

	DISPLAY_ON;						// Turn on the display

  set_bkg_data(0,1, mapTiles);

	// Load the the 'sprites' tiles into sprite memory
  spriteCount = 0;
	set_sprite_data(0, 4, sprites);

	// Set the first movable sprite (0) to be the first tile in the sprite memory (0)
	set_sprite_tile(PLAYER_SPRITE, PLAYER_TILE);
  spriteCount++;

  playerPos[X] = PLAYER_SPAWN_X;
  playerPos[Y] = PLAYER_SPAWN_Y;

  initBullets();
  initEnemies();
}

void initBullets()
{
  UINT8 i;
  for(i = 0; i < MAX_BULLETS; i++)
  {
    bullets[i].xPos = 0;
    bullets[i].yPos = 0;
    bullets[i].sprite = spriteCount;
    bullets[i].active = 0;
    set_sprite_tile(spriteCount, BULLET_TILE);
    move_sprite(spriteCount, 16*i, 20);
    spriteCount++;
  }
}

void initEnemies()
{
  UINT8 i;
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

void updateSwitches() {

	HIDE_WIN;
	SHOW_SPRITES;
	SHOW_BKG;
}

void checkInput() {

  // LEFT
	if (joypad() & J_LEFT) {

		playerPos[X]--;

	}

	// RIGHT
	if (joypad() & J_RIGHT) {

		playerPos[X]++;

  }

  // RIGHT
	if (joypad() & J_B) {
    if(bulletCooldown > BULLET_COOLDOWN)
    {
        fireBullet();
        bulletCooldown = 0;
    }
  }

  move_sprite(PLAYER_SPRITE, playerPos[X], playerPos[Y]);
}

void fireBullet()
{
  UINT8 i;
  for(i = 0; i < MAX_BULLETS; i++) {
    if(bullets[i].active == 0)
    {
      bullets[i].xPos = playerPos[X];
      bullets[i].yPos = playerPos[Y];
      bullets[i].active = 1;
      return;
    }
  }
}

void updateBullets()
{
  UINT8 i;
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

void updateEnemies()
{
  UINT8 i;
  //only update if cooldown is over
  if(enemyUpdateCooldown > ENEMY_UPDATE_COOLDOWN) {

    enemyUpdateCooldown = 0;

    for(i = 0; i < MAX_ENEMIES; i++)
    {
      if(enemies[i].active == 0) {
          enemies[i].xPos = 0;
          enemies[i].yPos = 0;
      }
      else
      {
        enemies[i].yPos++;
      }

      if(enemies[i].yPos > 160) {
        enemies[i].active = 0;
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
        if(enemies[i].active == 0)
        {
          enemies[i].active = 1;
          enemies[i].yPos = 8;
          enemies[i].xPos = rand() %128+16;
          break;
        }
    }
  }
  else
  {
    enemySpawnTimer++;
  }
}


void checkAABBCollision(GameObject a, GameObject b)
{
  if(a.xPos > (b.xPos + GAMEOBJECT_WIDTH)) {
    return false;
  }
  if(a.xPos + GAMEOBJECT_WIDTH < b.xPos) {
    return false;
  }
  if(a.yPos > b.yPos + GAMEOBJECT_HEIGHT) {
    return false;
  }
  if(a.yPos + GAMEOBJECT_HEIGHT < b.yPos) {
    return false;
  }

  return true;
}

void checkCollisions()
{
  UINT8 i;
  UINT8 j;

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

      if(!checkAABBCollision(bullets[i], enemies[j]) {
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

