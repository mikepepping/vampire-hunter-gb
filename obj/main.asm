;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Mar 24 2016) (Linux)
; This file was generated Sun Apr 28 20:49:52 2019
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _move_sprite
	.globl _set_sprite_tile
	.globl _set_sprite_data
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _enemySpawnTimer
	.globl _enemyUpdateCooldown
	.globl _enemies
	.globl _bulletCooldown
	.globl _bullets
	.globl _playerPos
	.globl _spriteCount
	.globl _mapTiles
	.globl _sprites
	.globl _init
	.globl _initBullets
	.globl _initEnemies
	.globl _updateSwitches
	.globl _checkInput
	.globl _fireBullet
	.globl _updateBullets
	.globl _updateEnemies
	.globl _checkCollisions
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_sprites::
	.ds 64
_mapTiles::
	.ds 16
_spriteCount::
	.ds 1
_playerPos::
	.ds 2
_bullets::
	.ds 40
_bulletCooldown::
	.ds 1
_enemies::
	.ds 28
_enemyUpdateCooldown::
	.ds 1
_enemySpawnTimer::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;sprites.c:1: unsigned char sprites[] =
	ld	hl,#_sprites
	ld	(hl),#0x00
	ld	bc,#_sprites + 1
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 2
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 3
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 4
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 5
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 6
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 7
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 8
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 9
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 10
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 11
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 12
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 13
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 14
	xor	a, a
	ld	(bc),a
	ld	bc,#_sprites + 15
	xor	a, a
	ld	(bc),a
	ld	hl,#(_sprites + 0x0010)
	ld	(hl),#0x18
	ld	bc,#_sprites + 17
	xor	a, a
	ld	(bc),a
	ld	hl,#(_sprites + 0x0012)
	ld	(hl),#0x18
	ld	bc,#_sprites + 19
	xor	a, a
	ld	(bc),a
	ld	hl,#(_sprites + 0x0014)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x0015)
	ld	(hl),#0x42
	ld	hl,#(_sprites + 0x0016)
	ld	(hl),#0x3C
	ld	hl,#(_sprites + 0x0017)
	ld	(hl),#0x5A
	ld	hl,#(_sprites + 0x0018)
	ld	(hl),#0x7E
	ld	hl,#(_sprites + 0x0019)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x001a)
	ld	(hl),#0x7E
	ld	bc,#_sprites + 27
	xor	a, a
	ld	(bc),a
	ld	hl,#(_sprites + 0x001c)
	ld	(hl),#0xFF
	ld	hl,#(_sprites + 0x001d)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x001e)
	ld	(hl),#0xC3
	ld	hl,#(_sprites + 0x001f)
	ld	(hl),#0xC3
	ld	hl,#(_sprites + 0x0020)
	ld	(hl),#0x18
	ld	bc,#_sprites + 33
	xor	a, a
	ld	(bc),a
	ld	hl,#(_sprites + 0x0022)
	ld	(hl),#0x24
	ld	hl,#(_sprites + 0x0023)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x0024)
	ld	(hl),#0x5A
	ld	hl,#(_sprites + 0x0025)
	ld	(hl),#0x24
	ld	hl,#(_sprites + 0x0026)
	ld	(hl),#0xA5
	ld	hl,#(_sprites + 0x0027)
	ld	(hl),#0x42
	ld	hl,#(_sprites + 0x0028)
	ld	(hl),#0xA5
	ld	hl,#(_sprites + 0x0029)
	ld	(hl),#0x42
	ld	hl,#(_sprites + 0x002a)
	ld	(hl),#0x5A
	ld	hl,#(_sprites + 0x002b)
	ld	(hl),#0x24
	ld	hl,#(_sprites + 0x002c)
	ld	(hl),#0x24
	ld	hl,#(_sprites + 0x002d)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x002e)
	ld	(hl),#0x18
	ld	bc,#_sprites + 47
	xor	a, a
	ld	(bc),a
	ld	hl,#(_sprites + 0x0030)
	ld	(hl),#0xE7
	ld	hl,#(_sprites + 0x0031)
	ld	(hl),#0xE7
	ld	hl,#(_sprites + 0x0032)
	ld	(hl),#0x3C
	ld	hl,#(_sprites + 0x0033)
	ld	(hl),#0xFF
	ld	hl,#(_sprites + 0x0034)
	ld	(hl),#0x3C
	ld	hl,#(_sprites + 0x0035)
	ld	(hl),#0xFF
	ld	hl,#(_sprites + 0x0036)
	ld	(hl),#0x3C
	ld	hl,#(_sprites + 0x0037)
	ld	(hl),#0xE7
	ld	hl,#(_sprites + 0x0038)
	ld	(hl),#0x3C
	ld	hl,#(_sprites + 0x0039)
	ld	(hl),#0x66
	ld	hl,#(_sprites + 0x003a)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x003b)
	ld	(hl),#0x5A
	ld	hl,#(_sprites + 0x003c)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x003d)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x003e)
	ld	(hl),#0x18
	ld	hl,#(_sprites + 0x003f)
	ld	(hl),#0x18
;mapTiles.c:26: unsigned char mapTiles[] =
	ld	hl,#_mapTiles
	ld	(hl),#0x00
	ld	bc,#_mapTiles + 1
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 2
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 3
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 4
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 5
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 6
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 7
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 8
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 9
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 10
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 11
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 12
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 13
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 14
	xor	a, a
	ld	(bc),a
	ld	bc,#_mapTiles + 15
	xor	a, a
	ld	(bc),a
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:63: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:65: init();
	call	_init
;main.c:67: while(1) {
00102$:
;main.c:69: checkInput();				// Check for user input (and act on it)
	call	_checkInput
;main.c:70: updateBullets();
	call	_updateBullets
;main.c:71: updateEnemies();
	call	_updateEnemies
;main.c:72: checkCollisions();
	call	_checkCollisions
;main.c:73: updateSwitches();			// Make sure the SHOW_SPRITES and SHOW_BKG switches are on each loop
	call	_updateSwitches
;main.c:74: wait_vbl_done();			// Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
	jr	00102$
	ret
;main.c:79: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:81: DISPLAY_ON;						// Turn on the display
	ld	de,#0xFF40
	ld	a,(de)
	ld	e,a
	ld	d,#0x00
	ld	a,e
	set	7, a
	ld	b,a
	ld	hl,#0xFF40
	ld	(hl),b
;main.c:83: set_bkg_data(0,1, mapTiles);
	ld	de,#_mapTiles
	push	de
	ld	hl,#0x0100
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:86: spriteCount = 0;
	ld	hl,#_spriteCount
	ld	(hl),#0x00
;main.c:87: set_sprite_data(0, 4, sprites);
	ld	de,#_sprites
	push	de
	ld	hl,#0x0400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:90: set_sprite_tile(PLAYER_SPRITE, PLAYER_TILE);
	ld	hl,#0x0100
	push	hl
	call	_set_sprite_tile
	add	sp, #2
;main.c:91: spriteCount++;
	ld	hl,#_spriteCount
	inc	(hl)
;main.c:93: playerPos[X] = PLAYER_SPAWN_X;
	ld	hl,#_playerPos
	ld	(hl),#0x50
;main.c:94: playerPos[Y] = PLAYER_SPAWN_Y;
	ld	hl,#(_playerPos + 0x0001)
	ld	(hl),#0x80
;main.c:96: initBullets();
	call	_initBullets
;main.c:97: initEnemies();
	jp	_initEnemies
;main.c:100: void initBullets()
;	---------------------------------
; Function initBullets
; ---------------------------------
_initBullets::
	add	sp, #-3
;main.c:103: for(i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,#0
	ld	(hl),#0x00
00102$:
;main.c:105: bullets[i].xPos = 0;
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_bullets
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#1
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:106: bullets[i].yPos = 0;
	ldhl	sp,#2
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	xor	a, a
	ld	(bc),a
;main.c:107: bullets[i].sprite = spriteCount;
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	hl,#_spriteCount
	ld	a,(hl)
	ld	(bc),a
;main.c:108: bullets[i].active = 0;
	ldhl	sp,#2
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc),a
;main.c:109: set_sprite_tile(spriteCount, BULLET_TILE);
	ld	a,#0x02
	push	af
	inc	sp
	ld	hl,#_spriteCount
	ld	a,(hl)
	push	af
	inc	sp
	call	_set_sprite_tile
	add	sp, #2
;main.c:110: move_sprite(spriteCount, 16*i, 20);
	ldhl	sp,#0
	ld	a,(hl)
	swap	a
	and	a,#0xF0
	ld	d,a
	ld	a,#0x14
	push	af
	inc	sp
	push	de
	inc	sp
	ld	hl,#_spriteCount
	ld	a,(hl)
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:111: spriteCount++;
	ld	hl,#_spriteCount
	inc	(hl)
;main.c:103: for(i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,#0
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x0A
	jp	C,00102$
	add	sp, #3
	ret
;main.c:115: void initEnemies()
;	---------------------------------
; Function initEnemies
; ---------------------------------
_initEnemies::
	add	sp, #-6
;main.c:118: for(i = 0; i < MAX_ENEMIES; i++)
	ldhl	sp,#0
	ld	(hl),#0x00
00102$:
;main.c:120: enemies[i].xPos = (i+1)*16;
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_enemies
	add	hl,bc
	ld	c,l
	ld	b,h
	ldhl	sp,#0
	ld	a,(hl)
	inc	a
	inc	hl
	ld	(hl),a
	ld	a,(hl)
	swap	a
	and	a,#0xF0
	ld	(bc),a
;main.c:121: enemies[i].yPos = 0;
	ld	hl,#0x0001
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:122: enemies[i].sprite = spriteCount;
	ld	hl,#0x0002
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_spriteCount
	ld	a,(hl)
	ld	(de),a
;main.c:123: enemies[i].active = 0;
	ld	hl,#0x0003
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:124: set_sprite_tile(spriteCount, ENEMY_TILE);
	push	bc
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#_spriteCount
	ld	a,(hl)
	push	af
	inc	sp
	call	_set_sprite_tile
	add	sp, #2
	pop	bc
;main.c:125: move_sprite(spriteCount, enemies[i].xPos, enemies[i].yPos);
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	push	af
	ld	a,(bc)
	ld	d,a
	pop	af
	push	af
	inc	sp
	push	de
	inc	sp
	ld	hl,#_spriteCount
	ld	a,(hl)
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:126: spriteCount++;
	ld	hl,#_spriteCount
	inc	(hl)
;main.c:118: for(i = 0; i < MAX_ENEMIES; i++)
	ldhl	sp,#1
	ld	a,(hl-)
	ld	(hl),a
	ld	a,(hl)
	sub	a, #0x07
	jp	C,00102$
	add	sp, #6
	ret
;main.c:130: void updateSwitches() {
;	---------------------------------
; Function updateSwitches
; ---------------------------------
_updateSwitches::
;main.c:132: HIDE_WIN;
	ld	de,#0xFF40
	ld	a,(de)
	ld	b,a
	ld	d,#0x00
	res	5, b
	ld	d,#0x00
	ld	hl,#0xFF40
	ld	(hl),b
;main.c:133: SHOW_SPRITES;
	ld	de,#0xFF40
	ld	a,(de)
	ld	e,a
	ld	d,#0x00
	ld	a,e
	set	1, a
	ld	b,a
	ld	l, #0x40
	ld	(hl),b
;main.c:134: SHOW_BKG;
	ld	de,#0xFF40
	ld	a,(de)
	ld	e,a
	ld	d,#0x00
	ld	a,e
	set	0, a
	ld	b,a
	ld	l, #0x40
	ld	(hl),b
	ret
;main.c:137: void checkInput() {
;	---------------------------------
; Function checkInput
; ---------------------------------
_checkInput::
;main.c:140: if (joypad() & J_LEFT) {
	call	_joypad
	ld	d,#0x00
	bit	1, e
	jr	Z,00102$
;main.c:142: playerPos[X]--;
	ld	a, (#_playerPos + 0)
	add	a,#0xFF
	ld	de,#_playerPos
	ld	(de),a
00102$:
;main.c:147: if (joypad() & J_RIGHT) {
	call	_joypad
	ld	d,#0x00
	bit	0, e
	jr	Z,00104$
;main.c:149: playerPos[X]++;
	ld	de,#_playerPos+0
	ld	a,(de)
	inc	a
	ld	(de),a
00104$:
;main.c:154: if (joypad() & J_B) {
	call	_joypad
	ld	d,#0x00
	bit	5, e
	jr	Z,00108$
;main.c:155: if(bulletCooldown > BULLET_COOLDOWN)
	ld	a,#0x1E
	ld	hl,#_bulletCooldown
	sub	a, (hl)
	jr	NC,00108$
;main.c:157: fireBullet();
	call	_fireBullet
;main.c:158: bulletCooldown = 0;
	ld	hl,#_bulletCooldown
	ld	(hl),#0x00
00108$:
;main.c:162: move_sprite(PLAYER_SPRITE, playerPos[X], playerPos[Y]);
	ld	de, #(_playerPos + 0x0001) + 0
	ld	a,(de)
	ld	b,a
	ld	a, (#_playerPos + 0)
	push	bc
	inc	sp
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
	ret
;main.c:165: void fireBullet()
;	---------------------------------
; Function fireBullet
; ---------------------------------
_fireBullet::
	add	sp, #-3
;main.c:168: for(i = 0; i < MAX_BULLETS; i++) {
	ldhl	sp,#0
	ld	(hl),#0x00
00104$:
;main.c:169: if(bullets[i].active == 0)
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_bullets
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	hl,#0x0003
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#1
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a, a
	jr	NZ,00105$
;main.c:171: bullets[i].xPos = playerPos[X];
	ld	a, (#_playerPos + 0)
	ld	(bc),a
;main.c:172: bullets[i].yPos = playerPos[Y];
	inc	bc
	ld	a, (#(_playerPos + 0x0001) + 0)
	ld	(bc),a
;main.c:173: bullets[i].active = 1;
	dec	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x01
;main.c:174: return;
	jr	00106$
00105$:
;main.c:168: for(i = 0; i < MAX_BULLETS; i++) {
	ldhl	sp,#0
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x0A
	jp	C,00104$
00106$:
	add	sp, #3
	ret
;main.c:179: void updateBullets()
;	---------------------------------
; Function updateBullets
; ---------------------------------
_updateBullets::
	add	sp, #-6
;main.c:182: for(i = 0; i < MAX_BULLETS; i++) {
	ldhl	sp,#0
	ld	(hl),#0x00
00107$:
;main.c:183: if(bullets[i].active == 0) {
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_bullets
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#1
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0003
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	dec	hl
;main.c:192: if(bullets[i].yPos < 8) {
	ld	(hl-),a
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
;main.c:183: if(bullets[i].active == 0) {
	inc	hl
	ld	a,(hl)
	or	a, a
	jr	NZ,00102$
;main.c:184: bullets[i].xPos = 0;
	dec	hl
	dec	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:185: bullets[i].yPos = 0;
	xor	a, a
	ld	(bc),a
	jr	00103$
00102$:
;main.c:189: bullets[i].yPos --;
	ld	a,(bc)
	add	a,#0xFF
	ld	(bc),a
00103$:
;main.c:192: if(bullets[i].yPos < 8) {
	ld	a,(bc)
	ldhl	sp,#3
	ld	(hl),a
	ld	a,(hl)
	sub	a, #0x08
	jr	NC,00105$
;main.c:193: bullets[i].active = 0;
	inc	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
00105$:
;main.c:196: move_sprite(bullets[i].sprite, bullets[i].xPos, bullets[i].yPos);
	ld	a,(bc)
	ldhl	sp,#3
	ld	(hl-),a
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	inc	hl
	inc	hl
	ld	(hl-),a
	dec	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	d,a
	inc	hl
	ld	a,(hl)
	push	af
	inc	sp
	inc	hl
	ld	a,(hl)
	push	af
	inc	sp
	push	de
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:182: for(i = 0; i < MAX_BULLETS; i++) {
	ldhl	sp,#0
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x0A
	jp	C,00107$
;main.c:199: bulletCooldown++;
	ld	hl,#_bulletCooldown
	inc	(hl)
	add	sp, #6
	ret
;main.c:202: void updateEnemies()
;	---------------------------------
; Function updateEnemies
; ---------------------------------
_updateEnemies::
	add	sp, #-6
;main.c:206: if(enemyUpdateCooldown > ENEMY_UPDATE_COOLDOWN) {
	ld	a,#0x01
	ld	hl,#_enemyUpdateCooldown
	sub	a, (hl)
	jp	NC,00108$
;main.c:208: enemyUpdateCooldown = 0;
	ld	(hl),#0x00
;main.c:210: for(i = 0; i < MAX_ENEMIES; i++)
	ldhl	sp,#0
	ld	(hl),#0x00
00116$:
;main.c:212: if(enemies[i].active == 0) {
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_enemies
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0003
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	dec	hl
	ld	(hl),a
;main.c:221: if(enemies[i].yPos > 160) {
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
;main.c:212: if(enemies[i].active == 0) {
	ldhl	sp,#1
	ld	a,(hl)
	or	a, a
	jr	NZ,00102$
;main.c:213: enemies[i].xPos = 0;
	ldhl	sp,#4
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:214: enemies[i].yPos = 0;
	xor	a, a
	ld	(bc),a
	jr	00103$
00102$:
;main.c:218: enemies[i].yPos++;
	ld	a,(bc)
	inc	a
	ld	(bc),a
00103$:
;main.c:221: if(enemies[i].yPos > 160) {
	ld	a,(bc)
	ldhl	sp,#1
	ld	(hl),a
	ld	a,#0xA0
	sub	a, (hl)
	jr	NC,00105$
;main.c:222: enemies[i].active = 0;
	inc	hl
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:223: enemies[i].xPos = 0;
	ldhl	sp,#4
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:224: enemies[i].yPos = 0;
	xor	a, a
	ld	(bc),a
00105$:
;main.c:227: move_sprite(enemies[i].sprite, enemies[i].xPos, enemies[i].yPos);
	ld	a,(bc)
	ldhl	sp,#1
	ld	(hl),a
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#2
	ld	(hl),a
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	d,a
	ldhl	sp,#1
	ld	a,(hl)
	push	af
	inc	sp
	inc	hl
	ld	a,(hl)
	push	af
	inc	sp
	push	de
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:210: for(i = 0; i < MAX_ENEMIES; i++)
	ldhl	sp,#0
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x07
	jp	C,00116$
	jr	00109$
00108$:
;main.c:231: enemyUpdateCooldown++;
	ld	hl,#_enemyUpdateCooldown
	inc	(hl)
00109$:
;main.c:234: if(enemySpawnTimer > ENEMY_SPAWN_TIME)
	ld	a,#0x3C
	ld	hl,#_enemySpawnTimer
	sub	a, (hl)
	jp	NC,00114$
;main.c:236: enemySpawnTimer = 0;
	ld	(hl),#0x00
;main.c:237: for(i = 0; i < MAX_ENEMIES; i++) {
	ldhl	sp,#0
	ld	(hl),#0x00
00118$:
;main.c:238: if(enemies[i].active == 0)
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_enemies
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a,(bc)
	or	a, a
	jr	NZ,00119$
;main.c:240: enemies[i].active = 1;
	ld	a,#0x01
	ld	(bc),a
;main.c:241: enemies[i].yPos = 8;
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	ld	a,#0x08
	ld	(bc),a
;main.c:242: enemies[i].xPos = rand() %128+16;
	call	_rand
	ld	hl,#0x0080
	push	hl
	push	de
	call	__modsint
	add	sp, #4
	ld	a,e
	add	a, #0x10
	ld	b,a
	ldhl	sp,#2
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),b
;main.c:243: break;
	jr	00120$
00119$:
;main.c:237: for(i = 0; i < MAX_ENEMIES; i++) {
	ldhl	sp,#0
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x07
	jp	C,00118$
	jr	00120$
00114$:
;main.c:249: enemySpawnTimer++;
	ld	hl,#_enemySpawnTimer
	inc	(hl)
00120$:
	add	sp, #6
	ret
;main.c:253: void checkCollisions()
;	---------------------------------
; Function checkCollisions
; ---------------------------------
_checkCollisions::
	add	sp, #-18
;main.c:258: for(i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,#0
	ld	(hl),#0x00
00118$:
;main.c:260: if(bullets[i].active == 0)
	ldhl	sp,#0
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_bullets
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#6
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0003
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a, a
	jp	Z,00115$
;main.c:266: for(j = 0; j < MAX_ENEMIES; j++) {
	ldhl	sp,#1
	ld	(hl),#0x00
00117$:
;main.c:267: if(enemies[j].active == 0) {
	ldhl	sp,#1
	ld	c,(hl)
	ld	b,#0x00
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,#_enemies
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0003
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#16
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a, a
	jp	Z,00113$
;main.c:271: if(bullets[i].xPos > (enemies[j].xPos+8)) {
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#14
	ld	(hl+),a
	ld	(hl),#0x00
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0008
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#12
	ld	(hl+),a
	ld	(hl),d
	ld	b,#0x00
	dec	hl
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a,b
	ld	e, a
	bit	7, e
	jr	Z,00159$
	bit	7, d
	jr	NZ,00160$
	cp	a, a
	jr	00160$
00159$:
	bit	7, d
	jr	Z,00160$
	scf
00160$:
	jp	C,00113$
;main.c:274: if(bullets[i].xPos + 8 < enemies[j].xPos) {
	ld	hl,#0x0008
	add	hl,bc
	ld	c,l
	ld	b,h
	ldhl	sp,#14
	ld	a,c
	sub	a, (hl)
	inc	hl
	ld	a,b
	sbc	a, (hl)
	ld	a,b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z,00161$
	bit	7, d
	jr	NZ,00162$
	cp	a, a
	jr	00162$
00161$:
	bit	7, d
	jr	Z,00162$
	scf
00162$:
	jp	C,00113$
;main.c:277: if(bullets[i].yPos > enemies[j].yPos+8) {
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#12
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#14
	ld	(hl+),a
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#10
	ld	(hl+),a
	ld	(hl),#0x00
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0008
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#8
	ld	(hl+),a
	ld	(hl),d
	ld	b,#0x00
	dec	hl
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a,b
	ld	e, a
	bit	7, e
	jr	Z,00163$
	bit	7, d
	jr	NZ,00164$
	cp	a, a
	jr	00164$
00163$:
	bit	7, d
	jr	Z,00164$
	scf
00164$:
	jp	C,00113$
;main.c:280: if(bullets[i].yPos + 8 < enemies[j].yPos) {
	ld	hl,#0x0008
	add	hl,bc
	ld	c,l
	ld	b,h
	ldhl	sp,#10
	ld	a,c
	sub	a, (hl)
	inc	hl
	ld	a,b
	sbc	a, (hl)
	ld	a,b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z,00165$
	bit	7, d
	jr	NZ,00166$
	cp	a, a
	jr	00166$
00165$:
	bit	7, d
	jr	Z,00166$
	scf
00166$:
	jp	C,00113$
;main.c:285: bullets[i].active = 0;
	ldhl	sp,#4
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:286: bullets[i].xPos = 0;
	ldhl	sp,#6
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:287: bullets[i].yPos = 0;
	ldhl	sp,#12
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:289: enemies[j].active = 0;
	ldhl	sp,#16
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:290: enemies[j].xPos = 0;
	ldhl	sp,#2
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
;main.c:291: enemies[j].yPos = 0;
	ldhl	sp,#14
	ld	a,(hl+)
	ld	h,(hl)
	ld	l,a
	ld	(hl),#0x00
00113$:
;main.c:266: for(j = 0; j < MAX_ENEMIES; j++) {
	ldhl	sp,#1
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x07
	jp	C,00117$
00115$:
;main.c:258: for(i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,#0
	inc	(hl)
	ld	a,(hl)
	sub	a, #0x0A
	jp	C,00118$
	add	sp, #18
	ret
	.area _CODE
	.area _CABS (ABS)
