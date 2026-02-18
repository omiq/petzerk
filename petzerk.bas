REM Petzerk BASIC 1.0
REM Recreation of the classic game "Bezerk" by Atari in XC-BASIC for the Commodore PET
REM Chris Garrett 2026
REM RetroGameCoders.com
REM ========================================================

REM PLAYER:
DIM X AS INT
DIM Y AS INT
DIM OLDX AS INT
DIM OLDY AS INT

REM BULLET:
DIM BX AS INT
DIM BY AS INT
DIM BF AS INT
DIM BOFFSET AS LONG
REM In Bezerk, the bullet moves in the direction of the player including diagonals
DIM BXDIR AS INT 
DIM BYDIR AS INT 
DIM LASTXDIR AS INT
DIM LASTYDIR AS INT

REM INITIALIZE:
X=10
Y=10
K$=""
GAME_OVER = 0
LASTXDIR=0
LASTYDIR=-1

REM SHOW PLAYER START POSITION:
POKE 32768+(40*Y)+X,65

REM MAIN LOOP:
DO WHILE GAME_OVER <> 1

  OLDX=X
  OLDY=Y
  
  GET K$
  IF K$="Q" OR K$="q" THEN GAME_OVER = 1
  IF K$="D" OR K$="d" THEN X=X+1
  IF K$="A" OR K$="a" THEN X=X-1
  IF K$="W" OR K$="w" THEN Y=Y-1
  IF K$="S" OR K$="s" THEN Y=Y+1
  IF K$=" " THEN 
    BXDIR=LASTXDIR
    BYDIR=LASTYDIR
    BX=X+BXDIR
    BY=Y+BYDIR
  	BF=1
  END IF
  
  IF PEEK(32768+(40*Y)+X)<>32 THEN
  	X=OLDX
  	Y=OLDY
  END IF

        
  IF OLDX<>X OR OLDY<>Y THEN 
  	IF X<>OLDX THEN LASTXDIR=X-OLDX
  	IF Y<>OLDY THEN LASTYDIR=Y-OLDY
  	POKE 32768+(40*OLDY)+OLDX,32
  	POKE 32768+(40*Y)+X,65
  END IF

  IF BF=1 THEN
      BOFFSET=32768+(40*BY)+BX
      POKE BOFFSET,32

      IF BY >= 0 AND BY <= 24 AND BX >= 0 AND BX <= 39 THEN 
        BY=BY+BYDIR
        BX=BX+BXDIR
      ELSE 
        BF=0
      END IF

      IF PEEK(BOFFSET)<>32 THEN 
        POKE BOFFSET,32
        BF=0 
      ELSE
        POKE BOFFSET,34
      END IF

  END IF
LOOP
