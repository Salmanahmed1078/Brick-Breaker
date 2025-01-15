INCLUDE Irvine32.inc
Includelib winmm.lib
TITLE MASM PlaySound

PlaySound PROTO,
pszSound:PTR BYTE,
hmod:DWORD,
fdwSound:DWORD


.data
SND_FILENAME DWORD 20001h
musicfile DB "Ten.wav",0
    ; Border characters
    borderSide   BYTE "|", 0
    borderTop    BYTE "-", 0
    hLine        BYTE "================================================================================", 0
    
    ; Menu text
    startText    BYTE "Start Game", 0
    leaderText   BYTE "LeaderBoard", 0
    instructText BYTE "Instructions", 0
    exitText     BYTE "Exit Game", 0
    emptySpace   BYTE "                                          ", 0
    welcomeMsg   BYTE "BRICK BREAKER", 0

    ; Landing page elements
    ball        BYTE "          0", 0
    arrow1      BYTE "         /", 0
    arrow2      BYTE "        /", 0
    arrow3      BYTE "      \|/", 0
    brick1      BYTE " __________ ", 0
    brick2      BYTE "|          |", 0
    brick3      BYTE " ---------- ", 0
    welcome     BYTE "W  E  L  C  O  M  E", 0
    to          BYTE "  T  O", 0
    brick       BYTE "B  R  I  C  K", 0
    breaker     BYTE "B  R  E  A  K  E  R", 0

    ; Main menu title
    brickText    BYTE "B R I C K", 0
    breakerText  BYTE "    B R E A K E R", 0
    
    ; Large ASCII art MAIN MENU text
    menuLine1    BYTE "M   M   AAA   III  N   N      M   M  EEEEE  N   N  U   U", 0
    menuLine2    BYTE "MM MM  A   A   I   NN  N      MM MM  E      NN  N  U   U", 0
    menuLine3    BYTE "M M M  AAAAA   I   N N N      M M M  EEE    N N N  U   U", 0
    menuLine4    BYTE "M   M  A   A   I   N  NN      M   M  E      N  NN  U   U", 0
    menuLine5    BYTE "M   M  A   A  III  N   N      M   M  EEEEE  N   N   UUU ", 0

    currentSelection BYTE 0   ; 0=Start, 1=Leaderboard, 2=Instructions, 3=Exit
    menuCount = 4            ; Total number of menu items

    ; Add new data for all screens
    namePrompt       BYTE "ENTER YOUR NAME :", 0

    playerName       BYTE 30 DUP(0)
    maxNameLen = 29
    leaderTitle      BYTE "LEADERBOARD", 0
    leaderEmpty      BYTE "No scores yet!", 0
    instructTitle    BYTE "INSTRUCTIONS", 0
    instructText1    BYTE "Use LEFT and RIGHT arrow keys to move paddle", 0
    instructText2    BYTE "Press SPACEBAR to launch the ball", 0
    instructText3    BYTE "Break all bricks to advance to next level", 0
    instructText4    BYTE "Don't let the ball fall below paddle", 0
    instructText5    BYTE "Press ESC to return to previous screen", 0
    instructText6    BYTE "Press P to pause the game", 0
    instructText7    BYTE "Collect power-ups for special abilities", 0
    exitMsg         BYTE "Thanks for playing! Press any key to exit...", 0
    pressAnyKey     BYTE "Press any key to return to menu...", 0

    ; Add player profile title
    profileTitle1   BYTE "PPPPPP  LL      AAAAA  YY  YY EEEEEE RRRRRR ", 0
    profileTitle2   BYTE "PP  PP  LL     AA   AA  YYYY  EE     RR   RR", 0
    profileTitle3   BYTE "PPPPPP  LL     AAAAAAA   YY   EEEE   RRRRRR ", 0
    profileTitle4   BYTE "PP      LL     AA   AA   YY   EE     RR  RR ", 0
    profileTitle5   BYTE "PP      LLLLLL AA   AA   YY   EEEEEE RR   RR", 0 , 

    profileTitle6   BYTE "PPPPPP  RRRRRR  OOOOO  FFFFFF IIIIII LL     EEEEEE", 0
    profileTitle7   BYTE "PP  PP  RR   RR OO   OO FF      II   LL     EE    ", 0
    profileTitle8   BYTE "PPPPPP  RRRRRR  OO   OO FFFF    II   LL     EEEE  ", 0
    profileTitle9   BYTE "PP      RR  RR  OO   OO FF      II   LL     EE    ", 0
    profileTitle10  BYTE "PP      RR   RR  OOOOO  FF    IIIIII LLLLLL EEEEEE", 0

    ; Add to .data section
    levelTitle1    BYTE "L    EEEEE V   V EEEEE L    ", 0
    levelTitle2    BYTE "L    E     V   V E     L    ", 0
    levelTitle3    BYTE "L    EEE    V V  EEE   L    ", 0
    levelTitle4    BYTE "L    E      V V  E     L    ", 0
    levelTitle5    BYTE "LLLL EEEEE   V   EEEEE LLLL ", 0

    selectionTitle1 BYTE "SSSSS EEEEE L    EEEEE  CCCC TTTTT III  OOOOO N   N", 0
    selectionTitle2 BYTE "S     E     L    E     C      T    I   O   O NN  N", 0
    selectionTitle3 BYTE "SSSSS EEE   L    EEE   C      T    I   O   O N N N", 0
    selectionTitle4 BYTE "    S E     L    E     C      T    I   O   O N  NN", 0
    selectionTitle5 BYTE "SSSSS EEEEE LLLL EEEEE  CCCC  T   III  OOOOO N   N", 0

    level1Text     BYTE "LEVEL 1 - BEGINNER", 0
    level2Text     BYTE "LEVEL 2 - INTERMEDIATE", 0
    level3Text     BYTE "LEVEL 3 - EXPERT", 0

    currentLevel   BYTE 0    ; 0=Level1, 1=Level2, 2=Level3
    levelCount = 3          ; Total number of levels

    ; Add to .data section
    leaderTitle1    BYTE "L    EEEEE   AAA   DDDD   EEEEE RRRR  ", 0
    leaderTitle2    BYTE "L    E      A   A  D   D  E     R   R ", 0
    leaderTitle3    BYTE "L    EEE    AAAAA  D   D  EEE   RRRR  ", 0
    leaderTitle4    BYTE "L    E      A   A  D   D  E     R  R  ", 0
    leaderTitle5    BYTE "LLLL EEEEE  A   A  DDDD   EEEEE R   R ", 0

    boardTitle1     BYTE " BBBB   OOOOO   AAA   RRRR  DDDD ", 0
    boardTitle2     BYTE " B   B  O   O  A   A  R   R D   D", 0
    boardTitle3     BYTE " BBBB   O   O  AAAAA  RRRR  D   D", 0
    boardTitle4     BYTE " B   B  O   O  A   A  R  R  D   D", 0
    boardTitle5     BYTE " BBBB   OOOOO  A   A  R   R DDDD ", 0
    NA1 db 'Player1',0
NA2 db 'Player2',0
NA3 db 'Player3',0
NA4 db 'Player4',0
NA5 db 'Player5',0

 fileHandle DWORD ?
scores db 0,0,0,0,0,0,0,0,0,0
scoresFile DWORD ? 
    
 levels BYTE 3, 2, 2, 1, 1  ; Dummy levels for each player


    topScorerText   BYTE "   T O P   S C O R E R S", 0
    names byte "Names     " ,0 
    scoreshow byte "Score    " , 0 
    levelshow byte "Level   ", 0 
    ; Add to .data section
    SCORE_ENTRY STRUCT
        name BYTE 30 DUP(0)    ; Player name
        score DWORD 0          ; Player score
    SCORE_ENTRY ENDS

    ; Dummy top scorers data
    topScorers SCORE_ENTRY 5 DUP(<>)    ; Array of 5 score entries
    nameJohn  BYTE "Salman ", 0, 26 DUP(0)
    nameSarah BYTE "Zain ", 0, 25 DUP(0)
    nameMike  BYTE "Zeshan ", 0, 26 DUP(0)
    nameEmma  BYTE "kanwal ", 0, 26 DUP(0)
    nameAlex  BYTE "Awais ", 0, 26 DUP(0)

    ; Format string for score display
    scoreFormat BYTE "%-40s %5d", 0
    scoreStr    BYTE 40 DUP(0)

    ; Add to .data section
    instrTitle1    BYTE "III N   N  SSSSS TTTTT RRRR  U   U  CCCC TTTTT III  OOOOO N   N", 0
    instrTitle2    BYTE " I  NN  N  S       T   R   R U   U C      T    I   O   O NN  N", 0
    instrTitle3    BYTE " I  N N N  SSSSS   T   RRRR  U   U C      T    I   O   O N N N", 0
    instrTitle4    BYTE " I  N  NN      S   T   R  R  U   U C      T    I   O   O N  NN", 0
    instrTitle5    BYTE "III N   N  SSSSS   T   R   R  UUU   CCCC  T   III  OOOOO N   N", 0

    ; Add to .data section
    VK_ESCAPE = 27         ; Virtual key code for ESC

    ; Add to .data section
    lives       dd 3
    heart       db "$", 0        ; Heart symbol
    scoreText   db "Score: ", 0
    livesText   db "Lives: ", 0
    levelText   db "Level: ", 0
    currentScore dd 0

    ; Update the box characters in .data section
    boxTopLeft       BYTE 219, 219, 0    ; Solid block for corners
    boxTopRight      BYTE 219, 219, 0
    boxBottomLeft    BYTE 219, 219, 0
    boxBottomRight   BYTE 219, 219, 0
    boxHorizontal    BYTE 219, 0         ; Solid block for horizontal lines
    boxVertical      BYTE 219, 219, 0    ; Solid block for vertical lines
 
 heartSymbol DB "$", 0   ; 
    ; Constants for brick layout
    BRICK_WIDTH = 9      
    BRICK_HEIGHT = 1     
    BRICK_GAP = 1         
    BRICKS_PER_ROW = 9   
    BRICK_ROWS = 4        
    MAX_BRICKS = 36     

    ; Arrays to store brick information
    brickX BYTE MAX_BRICKS DUP(0)     ; X positions
    brickY BYTE MAX_BRICKS DUP(0)     ; Y positions
    brickActive BYTE MAX_BRICKS DUP(1) ; Active status (1=active, 0=inactive)

    ; Colors for bricks
    BRICK_COLOR1 = 9 + (9* 16)      ; Light cyan bricks (instead of cyan)
    BRICK_COLOR2 = Red + (lightRed * 16)          ; Light red bricks (instead of red)

    ; Colors for damaged bricks
    BRICK_COLOR1_DAMAGED = lightCyan + (lightGray * 16)     ; Damaged light cyan becomes even lighter
    BRICK_COLOR2_DAMAGED = 12 + (12 * 16)  ; Damaged light red becomes lighter pink

    ; Add to your .data section
    PADDLE_WIDTH = 13            ; Width of paddle
    PADDLE_HEIGHT = 1            ; Height of paddle
    PADDLE_COLOR = cyan + (cyan * 16)  ; Main paddle color (cyan)
    PADDLE_EDGE_COLOR = white + (white * 16)  ; Edge color (white)
    PADDLE_SPEED = 4             ; Base speed
    PADDLE_ACCEL = 2             ; Acceleration rate
    MAX_PADDLE_SPEED = 4         ; Maximum speed
    LEFT_BOUNDARY = 12           ; Left boundary (after border)
    RIGHT_BOUNDARY = 104        ; Right boundary (before border)
    PADDLE_START_X = 50          ; Initial paddle X position

    ; Paddle position variables
    paddleX BYTE 50             ; Initial X position of paddle
    paddleY BYTE 25             ; Initial Y position (just above bottom border)
    
    ; Keyboard scan codes
    KEY_LEFT = 4Bh              ; Left arrow scan code
    KEY_RIGHT = 4Dh             ; Right arrow scan code
    KEY_ESC = 1Bh               ; ESC key scan code
    KEY_P = 19h                 ; Scan code for 'P'
    KEY_SPACE = 39h            ; Scan code for spacebar
    isPaused BYTE 0             ; Flag for game pause state
    pauseText BYTE "GAME PAUSED", 0

    ; Ball constants and variables
    BALL_CHAR = 'O'           ; Ball character
    BALL_COLOR = 7 + (black * 16)  ; Changed from white to light red
    ballX BYTE 55             ; Initial X position (center of paddle)
    ballY BYTE 25             ; Initial Y position (just above paddle)
    ballDX SBYTE 1            ; X direction (-1 = left, 1 = right)
    ballDY SBYTE -1           ; Y direction (-1 = up, 1 = down)
    ballSpeed BYTE 1          ; Ball movement speed
    isBallLaunched BYTE 0     ; 0 = Ball on paddle, 1 = Ball in motion

    ; Add these variables in the .data section
    paddleVelocity SBYTE 0       ; Current paddle velocity
    paddleFriction BYTE 1        ; Reduced friction for smoother deceleration

    ; Add these variables to the .data section
    BALL_DELAY = 5              ; Higher number = slower ball (adjust as needed)
    ballDelayCounter BYTE 0     ; Counter for ball movement delay

    ; Add to .data section
    BRICK_POINTS = 10          ; Points awarded for hitting a brick

    ; Add these to your .data section
    cursorInfo CONSOLE_CURSOR_INFO <>    ; Structure for cursor info
    consoleHandle DWORD ?                ; Handle to console

    ; Add exit menu text and ASCII art
    exitTitle1    BYTE "EEEEE X   X III TTTTT", 0
    exitTitle2    BYTE "E      X X   I    T  ", 0
    exitTitle3    BYTE "EEE     X    I    T  ", 0
    exitTitle4    BYTE "E      X X   I    T  ", 0
    exitTitle5    BYTE "EEEEE X   X III   T  ", 0

    ; Exit menu options
    restartText   BYTE "Restart Game", 0
    mainMenuText  BYTE "Back to Main Menu", 0
    viewScoreText BYTE "View High Scores", 0
    exitGameText   BYTE "Exit Game", 0    ; New option text
    
    exitSelection BYTE 0    ; 0=Restart, 1=Main Menu, 2=High Scores, 3=Exit
    exitMenuCount = 4       ; Now 4 options: Restart, Main Menu, High Scores, Exit

    gameOverText  BYTE "GAME OVER!", 0

    ; Add to your .data section
    gameOverTitle1    BYTE "  GGGGG    AAAA   MM    MM EEEEEEE", 0
    gameOverTitle2    BYTE " GG   GG  AA  AA  MMM  MMM EE     ", 0
    gameOverTitle3    BYTE "GG       AA    AA MM MM MM EEEEE  ", 0
    gameOverTitle4    BYTE "GG   GGG AAAAAAAA MM    MM EE     ", 0
    gameOverTitle5    BYTE " GGGGGG  AA    AA MM    MM EEEEEEE", 0

    gameOverTitle6    BYTE " OOOOO  VV     VV EEEEEEE RRRRRR  !!!", 0
    gameOverTitle7    BYTE "OO   OO VV     VV EE      RR   RR !!!", 0
    gameOverTitle8    BYTE "OO   OO  VV   VV  EEEEE   RRRRRR  !!!", 0
    gameOverTitle9    BYTE "OO   OO   VV VV   EE      RR  RR  !!!", 0
    gameOverTitle10   BYTE " OOOOO     VVV    EEEEEEE RR   RR !!!", 0

    ; Add this constant in the .data section with other constants
    PADDLE_WIDTH_L2 = 9            ; Shorter paddle for Level 2 (original was 13)

    ; Add to .data section at the top with other constants
    BRICK_HITS BYTE MAX_BRICKS DUP(2)  ; Each brick needs 2 hits in Level 2

    ; Add to .data section
    BALL_DELAY_L3 = 4              ; Even faster ball speed for Level 3 (lower = faster)
    PADDLE_WIDTH_L3 = 9            ; Same as Level 2

    ; Add to .data section
    BRICK_UNBREAKABLE = 255                         ; Special value for unbreakable bricks
    BRICK_COLOR_UNBREAKABLE = Gray + (Gray * 16)    ; Gray color for unbreakable bricks
    BRICK_HITS_L3 BYTE MAX_BRICKS DUP(3)           ; 3 hits for normal bricks (like Level 2)

    ; Add to data section (at the top with other constants)
    ; Colors for Level 3 bricks
    BRICK_COLOR1_L3 = 9 + (9 *16)             ; Initial cyan brick
    BRICK_COLOR1_DAMAGED1_L3 = 3 + (3 * 16)   ; First hit - light cyan
    BRICK_COLOR1_DAMAGED2_L3 = 11 + (11 *16 )    ; Second hit - light blue

    BRICK_COLOR2_L3 = Red + (Red * 16)                ; Initial red brick
    BRICK_COLOR2_DAMAGED1_L3 = 12     ; First hit - light red
    BRICK_COLOR2_DAMAGED2_L3 = 14 + (14* 16)          ; Second hit - yellow

    ; Add array for Level 3 brick hits
    
    ; Add to .data section with other color constants
    BRICK_COLOR_MAGICAL = Brown + (Brown * 16)  ; Brown color for magical brick
    MAGICAL_BRICK_INDEX = 35                    ; Last brick in the last row (index 35)

    ; Add array to track which bricks can be randomly removed
    REMOVABLE_BRICKS BYTE MAX_BRICKS DUP(0)    ; Will be set to 1 for removable bricks

    ; Add to .data section
    POWERUP_BRICK_INDEX = 23    ; Third row, middle position (9 bricks per row * 2 + 5 = 23)
    BRICK_COLOR_POWERUP = lightGreen + (lightGreen * 16)  ; Light green color for power-up brick
    PADDLE_WIDTH_EXTENDED = 15   ; Extended paddle width after power-up
    POWERUP_POINTS = 50         ; Points for hitting power-up brickAA

    ; In the .data section, add:
    currentPaddleWidth BYTE PADDLE_WIDTH_L2  ; Variable to store current paddle width
    oneHitModeActive BYTE 0        ; Flag for one-hit mode
oneHitTimer DWORD 0            ; Timer for one-hit mode
ONE_HIT_DURATION EQU 100  

.code
main PROC
 INVOKE PlaySound, OFFSET musicfile, NULL, SND_FILENAME
    ; Clear screen
    call ClrScr

    ; Show landing page
    call showLandingPage
    
    ; Show main menu title and options
    call showMainMenu
   
    exit
main ENDP

showLandingPage PROC
    ; Draw top border in red
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dh, 4      ; Start at row 4
    mov dl, 10     ; Start at column 10 (centered)
    call Gotoxy
    mov edx, OFFSET hLine
    call WriteString

    ; Animation counter
    mov ecx, 5     ; Number of animation cycles
    mov bl, 0      ; Color toggle flag

logoAnimation:
    push ecx       ; Save animation counter

    ; Draw the ball and arrow
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Position for ball
    mov dh, 6     ; Row
    mov dl, 45    ; Column
    call Gotoxy
    mov edx, OFFSET ball
    call WriteString

    ; Position for arrows
    mov dh, 7
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET arrow1
    call WriteString

    mov dh, 8
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET arrow2
    call WriteString

    mov dh, 9
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET arrow3
    call WriteString

    ; Draw brick
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 10
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET brick1
    call WriteString

    mov dh, 11
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET brick2
    call WriteString

    ; Toggle brick color
    xor bl, 1
    test bl, 1
    jz useRed
    mov eax, cyan + (cyan * 16)
    jmp colorBrick
useRed:
    mov eax, lightRed + (lightRed * 16)
colorBrick:
    call SetTextColor
    
    ; Fill brick with color (shorter width)
    mov dh, 11      ; Same row as brick2
    mov dl, 46      ; Start one position after the left border
    call Gotoxy
    mov ecx, 10     ; Reduced width for color fill
fillLoop:
    mov al, ' '
    call WriteChar
    loop fillLoop

    ; Draw bottom of brick
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 12
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET brick3
    call WriteString

    ; Delay for animation
    mov eax, 200
    call Delay

    pop ecx
    dec ecx
    jnz logoAnimation

    ; Draw welcome text
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dh, 15
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET welcome
    call WriteString

    mov dh, 17
    mov dl, 49
    call Gotoxy
    mov edx, OFFSET to
    call WriteString

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dh, 19
    mov dl, 46
    call Gotoxy
    mov edx, OFFSET brick
    call WriteString

    mov dh, 21
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET breaker
    call WriteString

    ; Draw bottom border
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov dh, 23
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET hLine
    call WriteString

    ; Wait before transition
    mov eax, 3000  ; 3 second delay
    call Delay

    ret
showLandingPage ENDP

showMainMenu PROC
    ; Clear screen for main menu
    call ClrScr

    ; Display BRICK BREAKER title
    mov dh, 1
    mov dl, 50
    call Gotoxy
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET brickText
    call WriteString

    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov dl, 70
    call Gotoxy
    mov edx, OFFSET breakerText
    call WriteString

    ; Display MAIN MENU ASCII art
    mov eax, yellow + (black * 16)
    call SetTextColor

    mov dh, 4
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET menuLine1
    call WriteString

    mov dh, 5
     mov dl, 35
    call Gotoxy
    mov edx, OFFSET menuLine2
    call WriteString

    mov dh, 6
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET menuLine3
    call WriteString

    mov dh, 7
     mov dl, 35
    call Gotoxy
    mov edx, OFFSET menuLine4
    call WriteString

    mov dh, 8
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET menuLine5
    call WriteString

    ; Draw menu and handle selection
    call drawMenu
    ret
showMainMenu ENDP

drawMenu PROC
    ; Draw initial menu structure
    call drawMenuStructure
    
    ; Initial selection highlight
    call highlightCurrentSelection
    
    ; Menu selection loop
menuLoop:
    call ReadKey
    jz menuLoop
    
    cmp dx, VK_UP
    jne checkDown
    mov al, currentSelection
    cmp al, 0
    je menuLoop
    dec currentSelection
    call drawMenuStructure
    call highlightCurrentSelection
    jmp menuLoop

checkDown:
    cmp dx, VK_DOWN
    jne checkEnter
    mov al, currentSelection
    cmp al, menuCount-1
    je menuLoop
    inc currentSelection
    call drawMenuStructure
    call highlightCurrentSelection
    jmp menuLoop

checkEnter:
    cmp dx, VK_RETURN
    jne menuLoop
    
    ; Handle menu selection
    mov al, currentSelection
    cmp al, 0
    je startGameSelected
    cmp al, 1
    je leaderboardSelected
    cmp al, 2
    je instructionsSelected
    cmp al, 3
    je exitSelected
    jmp menuLoop

startGameSelected:
    call handleStartGame
    jmp menuLoop
leaderboardSelected:
    call handleLeaderboard
    jmp menuLoop
instructionsSelected:
    call handleInstructions
    jmp menuLoop
exitSelected:
    call handleExit
    ret             ; Return to end program

drawMenu ENDP

drawMenuStructure PROC
    ; Draw top border
    mov dh, 12
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov ecx, 45
fillTop:
    mov al, ' '
    call WriteChar
    loop fillTop
    
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw start option line
    mov dh, 13
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillStart:
    mov al, ' '
    call WriteChar
    loop fillStart
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw extra empty line after top border
    mov dh, 14
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillExtra1:
    mov al, ' '
    call WriteChar
    loop fillExtra1
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw start text line
    mov dh, 15
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillStartLine:
    mov al, ' '
    call WriteChar
    loop fillStartLine
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 15
    mov dl, 57
    call Gotoxy
    mov edx, OFFSET startText
    call WriteString

    ; Draw empty line between options
    mov dh, 16
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillEmpty1:
    mov al, ' '
    call WriteChar
    loop fillEmpty1
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw LeaderBoard text
    mov dh, 17
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillLeaderLine:
    mov al, ' '
    call WriteChar
    loop fillLeaderLine
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 17
    mov dl, 56
    call Gotoxy
    mov edx, OFFSET leaderText
    call WriteString

    ; Draw empty line between options
    mov dh, 18
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillEmpty2:
    mov al, ' '
    call WriteChar
    loop fillEmpty2
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw Instruction text
    mov dh, 19
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillInstructLine:
    mov al, ' '
    call WriteChar
    loop fillInstructLine
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 19
    mov dl, 55
    call Gotoxy
    mov edx, OFFSET instructText
    call WriteString

    ; Draw empty line between options
    mov dh, 20
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillEmpty3:
    mov al, ' '
    call WriteChar
    loop fillEmpty3
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw Exit text
    mov dh, 21
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
fillExitLine:
    mov al, ' '
    call WriteChar
    loop fillExitLine
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 21
    mov dl, 57
    call Gotoxy
    mov edx, OFFSET exitText
    call WriteString
     ; Draw empty line between options
    mov dh, 22
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
   fillEmpty5:
    mov al, ' '
    call WriteChar
    loop fillEmpty5
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw empty line between options
    mov dh, 23
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 45
   fillEmpty4:
    mov al, ' '
    call WriteChar
    loop fillEmpty4
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString

    ; Draw bottom border
    mov dh, 24
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov edx, OFFSET borderSide
    call WriteString
    
    mov ecx, 45
fillBottom:
    mov al, ' '
    call WriteChar
    loop fillBottom
    
    mov edx, OFFSET borderSide
    call WriteString

    ret
drawMenuStructure ENDP

highlightCurrentSelection PROC
    pushad
    
    ; Calculate Y position based on currentSelection
    mov al, currentSelection
    mov bl, 2
    mul bl
    add al, 15
    mov dh, al
    mov dl, 35      ; Original starting position
    call Gotoxy
    
    ; Fill with red background (moved more right)
    mov dl, 40    ; Moved highlight more towards right
    call Gotoxy
    mov eax, red + (red * 16)
    call SetTextColor
    mov ecx, 46
fillBackground:
    mov al, ' '
    call WriteChar
    loop fillBackground
    
    ; Write the menu text in yellow (positions unchanged)
    mov dl, 56
    mov al, currentSelection
    cmp al, 1
    jne notLeader
    mov dl, 56
notLeader:
    cmp al, 2
    jne notInstruct
    mov dl, 56
notInstruct:
    cmp al, 3
    jne notExit
    mov dl, 56
notExit:
    call Gotoxy
    mov eax, yellow + (red * 16)
    call SetTextColor
    
    ; Select correct text based on currentSelection
    mov al, currentSelection
    cmp al, 0
    je writeStart
    cmp al, 1
    je writeLeader
    cmp al, 2
    je writeInstruct
    cmp al, 3
    je writeExit
    
writeStart:
    mov edx, OFFSET startText
    jmp writeText
writeLeader:
    mov edx, OFFSET leaderText
    jmp writeText
writeInstruct:
    mov edx, OFFSET instructText
    jmp writeText
writeExit:
    mov edx, OFFSET exitText
    
writeText:
    call WriteString
    
    popad
    ret
highlightCurrentSelection ENDP

handleStartGame PROC
    ; Clear screen
    call ClrScr
    
    ; Set black background
    mov eax, black + (black * 16)
    call SetTextColor
    call Clrscr
    
    ; Draw PLAYER in yellow
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    ; Draw all lines of PLAYER with explicit positions (moved up)
    mov dh, 3          ; First line (was 5)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle1
    call WriteString
    
    mov dh, 4          ; Second line (was 6)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle2
    call WriteString
    
    mov dh, 5          ; Third line (was 7)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle3
    call WriteString
    
    mov dh, 6          ; Fourth line (was 8)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle4
    call WriteString
    
    mov dh, 7          ; Fifth line (was 9)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle5
    call WriteString
    
    ; Draw PROFILE in red
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    ; Draw all lines of PROFILE with explicit positions (moved up)
    mov dh, 9          ; First line (was 11)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle6
    call WriteString
    
    mov dh, 10         ; Second line (was 12)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle7
    call WriteString
    
    mov dh, 11         ; Third line (was 13)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle8
    call WriteString
    
    mov dh, 12         ; Fourth line (was 14)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle9
    call WriteString
    
    mov dh, 13         ; Fifth line (was 15)
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET profileTitle10
    call WriteString
    
    ; Draw bigger light blue input box
    mov dh, 17         ; Start position for box (was 17)
    mov dl, 35         ; Wider box (was 35)
    mov ecx, 9         ; Taller box (was 6)
drawRect:
    push ecx
    call Gotoxy
    
    mov eax, 9 + (cyan * 16)    ; Light blue (color code 9)
    call SetTextColor
    
    mov ecx, 40        ; Wider box (was 40)
fillRect:
    mov al, ' '
    call WriteChar
    loop fillRect
    
    add dh, 1
    pop ecx
    loop drawRect
    
    ; Draw inner white rectangle for name input
    mov dh, 20        ; Position inside cyan box
    mov dl, 39         ; Slightly inset from cyan box
    mov ecx, 4          ; Height of white box
drawWhiteRect:
    push ecx
    call Gotoxy
    
    mov eax, white + (white * 16)    ; White background
    call SetTextColor
    
    mov ecx, 32        ; Width of white box
fillWhiteRect:
    mov al, ' '
    call WriteChar
    loop fillWhiteRect
    
    add dh, 1
    pop ecx
    loop drawWhiteRect
    
    ; Draw name input prompt (adjusted for new box position)
    mov dh, 18         ; Above white box
    mov dl, 40         
    call Gotoxy
    mov eax, White + (cyan * 16)    ; White text on cyan
    call SetTextColor
    mov edx, OFFSET namePrompt
    call WriteString
    
    ; Position cursor for name input
    mov dh, 21         ; Center of white box
    mov dl, 40
    call Gotoxy
    mov eax, black + (white * 16)    ; Black text on white background
    call SetTextColor
    
    ; Get player name
    mov edx, OFFSET playerName
    mov ecx, maxNameLen
    call ReadString
    
    ; Show level selection screen
    call showLevelSelection
    
    ; Return to menu
    call ClrScr
    ret
handleStartGame ENDP

showLevelSelection PROC
    ; Clear screen with black background
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Draw LEVEL in red (moved further right and up)
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    mov dh, 2          ; Moved up (was 4)
    mov dl, 45         ; Moved more right (was 35)
    call Gotoxy
    mov edx, OFFSET levelTitle1
    call WriteString
    
    mov dh, 3          ; Moved up (was 5)
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET levelTitle2
    call WriteString
    
    mov dh, 4          ; Moved up (was 6)
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET levelTitle3
    call WriteString
    
    mov dh, 5          ; Moved up (was 7)
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET levelTitle4
    call WriteString
    
    mov dh, 6          ; Moved up (was 8)
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET levelTitle5
    call WriteString
    
    ; Draw SELECTION in yellow (moved right and up)
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dh, 8          ; Moved up (was 10)
    mov dl, 35         ; Moved more right (was 25)
    call Gotoxy
    mov edx, OFFSET selectionTitle1
    call WriteString
    
    mov dh, 9          ; Moved up (was 11)
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET selectionTitle2
    call WriteString
    
    mov dh, 10         ; Moved up (was 12)
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET selectionTitle3
    call WriteString
    
    mov dh, 11         ; Moved up (was 13)
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET selectionTitle4
    call WriteString
    
    mov dh, 12         ; Moved up (was 14)
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET selectionTitle5
    call WriteString
    
    ; Draw level options box with borders (moved right)
    mov dh, 16         ; Top border
    mov dl, 35         ; Moved right
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov ecx, 46        ; Wider box
fillTopBoxBorder:
    mov al, ' '
    call WriteChar
    loop fillTopBoxBorder
    
    ; Draw side borders and fill
    mov ecx, 8         ; Box height
    mov ebx, 17        ; Starting row
drawLevelBox:
    push ecx
    
    ; Left border
    mov dh, bl
    mov dl, 35         ; Moved right
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    
    ; Box fill
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 44        ; Wider fill
fillLevelBox:
    mov al, ' '
    call WriteChar
    loop fillLevelBox
    
    ; Right border
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    
    inc bl
    pop ecx
    loop drawLevelBox
    
    ; Draw bottom border
    mov dh, 24
    mov dl, 35         ; Moved right
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov ecx, 46        ; Match top border width
fillBottomBoxBorder:
    mov al, ' '
    call WriteChar
    loop fillBottomBoxBorder
    
    ; Draw level options
    mov eax, LightGray + (black * 16)
    call SetTextColor
    
    mov dh, 18         ; Level 1
    mov dl, 45         ; Centered in box
    call Gotoxy
    mov edx, OFFSET level1Text
    call WriteString
    
    mov dh, 20         ; Level 2
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET level2Text
    call WriteString
    
    mov dh, 22         ; Level 3
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET level3Text
    call WriteString
    
    ; Handle level selection
    mov currentLevel, 0    ; Start with first level selected
    call highlightCurrentLevel
    
levelSelectionLoop:
    call ReadKey
    jz levelSelectionLoop
    
    cmp dx, VK_UP
    jne checkLevelDown
    mov al, currentLevel
    cmp al, 0
    je levelSelectionLoop
    dec currentLevel
    call highlightCurrentLevel
    jmp levelSelectionLoop

checkLevelDown:
    cmp dx, VK_DOWN
    jne checkLevelEnter
    mov al, currentLevel
    cmp al, levelCount-1
    je levelSelectionLoop
    inc currentLevel
    call highlightCurrentLevel
    jmp levelSelectionLoop

checkLevelEnter:
    cmp dx, VK_RETURN
    jne levelSelectionLoop
    
    ; If ENTER pressed, show game screen based on selected level
    mov al, currentLevel
    cmp al, 0              ; Check if Level 1 selected
    jne checkLevel2
    
    ; Level 1 selected - Show game screen
    call displayGameScreen
    
    ; Wait for ESC to return to level selection
checkGameKey:
    call ReadKey
    cmp al, VK_ESCAPE
    jne checkGameKey
    
    ; If ESC pressed, return to level selection
    call ClrScr
    call showLevelSelection
    jmp levelSelectionLoop
    
checkLevel2:
    cmp al, 1              ; Check if Level 2 selected
    jne checkLevel3
    ; Handle Level 2
    call displayGameScreen2    ; New procedure for Level 2
    
    ; Wait for ESC to return to level selection
checkGameKey2:
    call ReadKey
    cmp al, VK_ESCAPE
    jne checkGameKey2
    
    call ClrScr
    call showLevelSelection
    jmp levelSelectionLoop
    
checkLevel3:
    cmp al, 2              ; Check if Level 3 selected
    jne levelSelectionLoop
    ; Handle Level 3
   call displayGameScreen3
    
    ; Wait for ESC to return to level selection
checkGameKey3:
    call ReadKey
    cmp al, VK_ESCAPE
    jne checkGameKey3
    
    call ClrScr
    call showLevelSelection
    jmp levelSelectionLoop
    
    ret
showLevelSelection ENDP

highlightCurrentLevel PROC
    pushad
    
    ; First redraw the black background for the entire selection area
    mov eax, black + (black * 16)
    call SetTextColor
    mov ebx, 18        ; Start row
    mov ecx, 6         ; Number of rows to clear
clearLoop:
    push ecx
    mov dh, bl
    mov dl, 36         ; Start column
    call Gotoxy
    mov ecx, 44        ; Width to clear
fillBlack:
    mov al, ' '
    call WriteChar
    loop fillBlack
    inc bl
    pop ecx
    loop clearLoop
    
    ; Draw all unselected options in white
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Redraw Level 1 (unless it's selected)
    mov al, currentLevel
    cmp al, 0
    je skipLevel1
    mov dh, 18
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET level1Text
    call WriteString
skipLevel1:
    
    ; Redraw Level 2 (unless it's selected)
    mov al, currentLevel
    cmp al, 1
    je skipLevel2
    mov dh, 20
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET level2Text
    call WriteString
skipLevel2:
    
    ; Redraw Level 3 (unless it's selected)
    mov al, currentLevel
    cmp al, 2
    je skipLevel3
    mov dh, 22
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET level3Text
    call WriteString
skipLevel3:
    
    ; Now highlight the selected level
    mov al, currentLevel
    mov bl, 2
    mul bl
    add al, 18         ; Starting from row 18
    mov dh, al
    mov dl, 36         ; Start column for highlight
    call Gotoxy
    
    ; Draw highlight background
    mov eax, red + (red * 16)
    call SetTextColor
    mov ecx, 44        ; Width of highlight
fillLevelHighlight:
    mov al, ' '
    call WriteChar
    loop fillLevelHighlight
    
    ; Write the selected level text in yellow on red background
    mov dl, 45         ; Text position
    call Gotoxy
    mov eax, yellow + (red * 16)
    call SetTextColor
    
    ; Select correct text based on currentLevel
    mov al, currentLevel
    cmp al, 0
    je writeLvl1
    cmp al, 1
    je writeLvl2
    jmp writeLvl3
    
writeLvl1:
    mov edx, OFFSET level1Text
    jmp writeLevelText
writeLvl2:
    mov edx, OFFSET level2Text
    jmp writeLevelText
writeLvl3:
    mov edx, OFFSET level3Text
    
writeLevelText:
    call WriteString
    
    popad
    ret
highlightCurrentLevel ENDP

handleLeaderboard PROC
    ; Clear screen with black background
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Draw LEADER in yellow on black
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dh, 2          ; First line
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET leaderTitle1
    call WriteString
    
    mov dh, 3          ; Second line
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET leaderTitle2
    call WriteString
    
    mov dh, 4          ; Third line
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET leaderTitle3
    call WriteString
    
    mov dh, 5          ; Fourth line
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET leaderTitle4
    call WriteString
    
    mov dh, 6          ; Fifth line
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET leaderTitle5
    call WriteString
    
    ; Draw BOARD in red on black
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    mov dh, 2          ; First line
    mov dl, 65         ; Position next to LEADER
    call Gotoxy
    mov edx, OFFSET boardTitle1
    call WriteString
    
    mov dh, 3          ; Second line
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET boardTitle2
    call WriteString
    
    mov dh, 4          ; Third line
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET boardTitle3
    call WriteString
    
    mov dh, 5          ; Fourth line
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET boardTitle4
    call WriteString
    
    mov dh, 6          ; Fifth line
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET boardTitle5
    call WriteString
    
    ; Draw TOP SCORERS text in white on black
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov dh, 9
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET topScorerText
    call WriteString
    
    ; Draw scores box borders in cyan on black
    mov dh, 11         ; Top border
    mov dl, 30
    call Gotoxy
    mov eax, cyan + (black * 16)    ; Changed from cyan background to black
    call SetTextColor
    mov ecx, 50
fillTopBorder:
    mov al, 223        ; Bottom half block character for top border
    call WriteChar
    loop fillTopBorder
    
    ; Draw side borders
    mov ecx, 12        ; Box height
    mov ebx, 12        ; Starting row
drawScoreBox:
    push ecx
  
    ; Left border
    mov dh, bl
    mov dl, 30
    call Gotoxy
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov al, 186        ; Vertical line character
    call WriteChar
    
    ; Box fill (black)
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 48
    call fillRowSpace
    
    ; Right border
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov al, 186        ; Vertical line character
    call WriteChar
    
    inc bl
    pop ecx
    loop drawScoreBox
    
    ; Draw bottom border
    mov dh, 24
    mov dl, 30
    call Gotoxy
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov ecx, 50
fillBottomBorder:
    mov al, 220        ; Top half block character for bottom border
    call WriteChar
    loop fillBottomBorder
    
    ; Initialize top scorers (call once at the start)
    call initializeTopScorers
    
    ; After drawing the box, call displayScores instead of showing "No scores yet!"
    call displayScores
    
    
    ; Wait for key
checkLeaderboardKey:
    call ReadKey        ; Read key input
    
    ; Check if ESC was pressed
    cmp al, VK_ESCAPE
    je returnToMainMenu     ; If ESC pressed, go back to main menu
    
    jmp checkLeaderboardKey ; If not ESC, keep checking
    
returnToMainMenu:
    call ClrScr
    call showMainMenu   ; Return to main menu
    ret
handleLeaderboard ENDP

fillRowSpace PROC
    push ecx
fillLoop:
    mov al, ' '
    call WriteChar
    loop fillLoop
    pop ecx
    ret
fillRowSpace ENDP

initializeTopScorers PROC
    pushad
    
    ; Initialize first entry
    mov esi, OFFSET nameJohn
    mov edi, OFFSET topScorers
    mov ecx, 30
    rep movsb
    mov eax, 1500
    mov [edi], eax
   

    ; Initialize second entry
    mov esi, OFFSET nameSarah
    add edi, 4          ; Move past previous score
    mov ecx, 30
    rep movsb
    mov eax, 1200
    mov [edi], eax
    
    ; Initialize third entry
    mov esi, OFFSET nameMike
    add edi, 4
    mov ecx, 30
    rep movsb
    mov eax, 900
    mov [edi], eax
    
    ; Initialize fourth entry
    mov esi, OFFSET nameEmma
    add edi, 4
    mov ecx, 30
    rep movsb
    mov eax, 750
    mov [edi], eax
    
    ; Initialize fifth entry
    mov esi, OFFSET nameAlex
    add edi, 4
    mov ecx, 30
    rep movsb
    mov eax, 500
    mov [edi], eax
    
    popad
    ret
initializeTopScorers ENDP

displayScores PROC
    pushad
    mov dh , 12 
    mov dl , 42
    call Gotoxy
      mov eax, lightGray + (black * 16)
    call SetTextColor
     mov edx, OFFSET names
    call WriteString
     mov eax , "   "
     call WriteChar
     mov edx, OFFSET scoreshow
     call WriteString
    mov eax , "  "
    call WriteChar
    mov edx, OFFSET levelshow
     call WriteString
    ; Display first entry
    mov dh, 14
    mov dl, 40
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov al, '1'
    call WriteChar
    mov al, '.'
    call WriteChar
    mov eax, "   "
    call WriteChar
    
    mov edx, OFFSET topScorers
    call WriteString
    mov dl, 65
    call Gotoxy 
    mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov eax, [topScorers + 30]
     call WriteDec
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov al, ' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov eax , 1 
   call WriteDec
    ; Display second entry
    mov dh, 16
    mov dl, 40
    call Gotoxy
    mov al, '2'
    call WriteChar
    mov al, '.'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov edx, OFFSET topScorers + 34
    call WriteString
    mov dl, 65
    call Gotoxy
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov eax, [topScorers + 64]
    call WriteDec
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov eax, 2
    call WriteDec


    ; Display third entry
    mov dh, 18
    mov dl, 40
    call Gotoxy
    mov al, '3'
    call WriteChar
    mov al, '.'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov edx, OFFSET topScorers + 68
    call WriteString
    mov dl, 65
    call Gotoxy
    mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov eax, [topScorers + 98]
    call WriteDec
    mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
     mov al,' '
    call WriteChar
    mov eax, 3
    call WriteDec

    ; Display fourth entry
    mov dh, 20
    mov dl, 40
    call Gotoxy
    mov al, '4'
    call WriteChar
    mov al, '.'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar

    mov edx, OFFSET topScorers + 102
    call WriteString
    mov dl, 65
    call Gotoxy
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar

    mov eax, [topScorers + 132]
    call WriteDec
     mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
     mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
     mov eax, 3
    call WriteDec


    ; Display fifth entry
    mov dh, 22
    mov dl, 40
    call Gotoxy
    mov al, '5'
    call WriteChar
    mov al, '.'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov edx, OFFSET topScorers + 136
    call WriteString
    mov dl, 65
    call Gotoxy
     mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov eax, [topScorers + 166]
    call WriteDec
     mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
     mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
     mov eax, 3
    call WriteDec
    popad
    ret
displayScores ENDP

handleInstructions PROC
    ; Clear screen with black background
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Draw INSTRUCTIONS in yellow
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dh, 2
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET instrTitle1
    call WriteString
    
    mov dh, 3
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET instrTitle2
    call WriteString
    
    mov dh, 4
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET instrTitle3
    call WriteString
    
    mov dh, 5
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET instrTitle4
    call WriteString
    
    mov dh, 6
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET instrTitle5
    call WriteString
    
    ; Draw box borders
    mov dh, 9
    mov dl, 20
    call Gotoxy
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov ecx, 70
fillTopInstrBorder:
    mov al, 223        ; Bottom half block character
    call WriteChar
    loop fillTopInstrBorder
    
    ; Draw side borders for each row
    mov eax, cyan + (black * 16)
    call SetTextColor
    
    ; Draw vertical borders for rows 10 through 20
    mov dh, 10
drawBorders:
    ; Left border
    mov dl, 20
    call Gotoxy
    mov al, 186        ; Vertical line character
    call WriteChar
    
    ; Right border
    mov dl, 89         ; Right border position
    call Gotoxy
    mov al, 186        ; Vertical line character
    call WriteChar
    
    inc dh            ; Move to next row
    cmp dh, 20
    jle drawBorders
    
    ; Draw bottom border
    mov dh, 21
    mov dl, 20
    call Gotoxy
    mov eax, cyan + (black * 16)
    call SetTextColor
    mov ecx, 70
fillBottomInstrBorder:
    mov al, 220        ; Top half block character
    call WriteChar
    loop fillBottomInstrBorder
    
    ; Draw instruction texts
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    mov dh, 11
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText1
    call WriteString
    
    mov dh, 13
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText2
    call WriteString
    
    mov dh, 15
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText3
    call WriteString
    
    mov dh, 17
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText4
    call WriteString
    
    mov dh, 19
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText5
    call WriteString
    
    mov dh, 14
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText6
    call WriteString
    
    mov dh, 16
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET instructText7
    call WriteString
    
    ; Check for key press
checkInstructKey:
    call ReadKey        ; Read key input
    
    ; Check if ESC was pressed
    cmp al, VK_ESCAPE
    je returnToMenu     ; If ESC pressed, go back to main menu
    
    jmp checkInstructKey ; If not ESC, keep checking
    
returnToMenu:
    call ClrScr
    call showMainMenu   ; Return to main menu
    ret
    
handleInstructions ENDP

handleExit PROC
    ; Clear screen
    call ClrScr
    
    ; Show game over screen
    call showGameOverScreen
    
    ; Exit program
    exit
handleExit ENDP

; Add new procedure for level display
displayGameScreen PROC
    ; Clear screen
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Hide cursor
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov consoleHandle, eax
    mov cursorInfo.dwSize, 100
    mov cursorInfo.bVisible, 0
    INVOKE SetConsoleCursorInfo, consoleHandle, ADDR cursorInfo
    
    ; Display status bar at top
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Display Level
    mov dh, 0
    mov dl, 12
    call Gotoxy
    mov edx, OFFSET levelText
    call WriteString
    movzx eax, currentLevel
    inc eax
    call WriteDec
    
    ; Display Score
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    ; Display Lives
    mov dh, 0
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET livesText
    call WriteString
    
    ; Display hearts with red color
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov ecx, [lives]
displayHearts:
    mov edx, OFFSET heartSymbol
    call WriteString
    mov al, ' '        ; Space between symbols
    call WriteChar
    loop displayHearts
    
    ; Draw game boundary with thick borders in yellow
    mov eax, lightGray + (black * 16)    ; Changed from cyan to yellow
    call SetTextColor
    
    ; Top border - make it thicker and longer
    mov dh, 2          ; Start below status bar
    mov dl, 11         ; Start one column earlier
    call Gotoxy
    mov ecx, 95       ; Increased width by 2
fillTopBorder:
    mov al, 219        ; Solid block character
    call WriteChar
    loop fillTopBorder
    
    ; Draw side borders - make them thicker
    mov ecx, 25        ; Height of game area
    mov dh, 3         ; Start below top border
drawSideBorders:
    push ecx
    
    ; Left border (two blocks wide)
    mov dl, 11        ; Start one column earlier
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    ; Right border (two blocks wide)
    mov dl, 104        ; Keep right border position
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    inc dh
    pop ecx
    loop drawSideBorders
    
    ; Bottom border - make it thicker and longer
    mov dh, 28         ; Bottom row
    mov dl, 11          ; Start one column earlier
    call Gotoxy
    mov ecx, 95       ; Increased width by 2
fillBottomBorder:
    mov al, 219        ; Solid block character
    call WriteChar
    loop fillBottomBorder
    
    ; Initialize and draw bricks
    call initializeBricks
    call drawBricks
    
    ; Draw initial paddle
    call drawPaddle
    
gameLoop:
    ; Reduce delay for smoother movement
    mov eax, 5              ; Reduced from 15 to 5 for more responsive movement
    call Delay
    
    ; Call new input handler
    call HandleInput
    
    ; Check for ESC key separately (since it's not handled in HandleInput)
    call ReadKey
    jz updateBallPos       ; If no key, just update ball
    cmp al, 27            ; ESC
    je exitGame
    jmp updateBallPos     ; Remove the spacebar check since it's now in HandleInput
    
updateBallPos:
    ; Only update ball position after delay counter reaches BALL_DELAY
    inc ballDelayCounter
    mov al, ballDelayCounter
    cmp al, BALL_DELAY
    jl continueGameLoop     ; Skip ball update if delay not reached
    
    mov ballDelayCounter, 0 ; Reset counter
    call updateBall         ; Update ball position
    
continueGameLoop:
    jmp gameLoop
    
exitGame:
    ; Show cursor before exit
    mov cursorInfo.bVisible, 1
    INVOKE SetConsoleCursorInfo, consoleHandle, ADDR cursorInfo
    ret
displayGameScreen ENDP

drawPaddle PROC
    pushad
    
    ; Set position
    mov dh, paddleY
    mov dl, paddleX
    call Gotoxy
    
    ; Draw left edge in white
    mov eax, PADDLE_EDGE_COLOR
    call SetTextColor
    mov al, 219        ; Solid block character
    call WriteChar
    
    ; Draw middle part in cyan
    mov eax, PADDLE_COLOR
    call SetTextColor
    mov ecx, PADDLE_WIDTH - 2  ; Middle section width
drawPaddleMiddle:
    mov al, 219
    call WriteChar
    loop drawPaddleMiddle
    
    ; Draw right edge in white
    mov eax, PADDLE_EDGE_COLOR
    call SetTextColor
    mov al, 219
    call WriteChar
    
    popad
    ret
drawPaddle ENDP

updatePaddle PROC
    pushad
    
    ; Clear the entire row where paddle moves (between borders)
    mov eax, black + (black * 16)
    call SetTextColor
    mov dh, paddleY
    mov dl, 13             ; Start after left border
    call Gotoxy
    mov ecx, 96          ; Width between borders
clearRow:
    mov al, ' '
    call WriteChar
    loop clearRow
    
    ; Redraw borders
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Left border
    mov dl, 11
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    ; Right border
    mov dl, 104
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    ; Draw new paddle
    call drawPaddle
    
    ; If ball not launched, update its position
    cmp isBallLaunched, 0
    jne skipBallRedraw
    
    ; Clear and update ball
    mov eax, black + (black * 16)
    call SetTextColor
    mov dh, paddleY
    dec dh                  ; Row above paddle
    mov dl, 13            ; Start after left border
    call Gotoxy
    mov ecx, 90            ; Clear entire width
clearBallRow:
    mov al, ' '
    call WriteChar
    loop clearBallRow
    
    ; Update ball position and draw
    mov al, paddleX
    add al, PADDLE_WIDTH/2
    mov ballX, al
    mov al, paddleY
    dec al
    mov ballY, al
    call drawBall
    
skipBallRedraw:
    popad
    ret
updatePaddle ENDP

initializeBricks PROC
    pushad
    
    mov ebx, 0                ; Array index
    mov dl, 4                 ; Starting Y position
    mov ecx, BRICK_ROWS       ; Number of rows
    
rowLoop:
    push ecx
    mov dh, 14               ; Starting X position for each row
    mov ecx, BRICKS_PER_ROW  ; Bricks per row
    
brickLoop:
    ; Store positions
    mov brickX[ebx], dh
    mov brickY[ebx], dl
    mov brickActive[ebx], 1
    
    ; Move to next position
    add dh, BRICK_WIDTH
    add dh, BRICK_GAP
    inc ebx
    
    loop brickLoop
    
    add dl, BRICK_HEIGHT    ; Move to next row
    add dl, BRICK_GAP
    
    pop ecx
    loop rowLoop
    
    popad
    ret
initializeBricks ENDP

drawBricks PROC
    pushad
    
    mov ebx, 0              ; Array index
    mov ecx, MAX_BRICKS     ; Total bricks to process
    xor esi, esi            ; Row counter
    
drawLoop:
    ; Check if brick is active
    cmp brickActive[ebx], 0
    je nextBrick
    
    ; Calculate if we're in an odd or even row
    mov eax, ebx
    mov edx, 0              ; Clear edx for division
    mov edi, BRICKS_PER_ROW
    div edi                 ; eax = row number (quotient), edx = position in row
    test eax, 1            ; Check if row number is odd
    jz evenRow
    
    ; Odd row - reverse the pattern
    test edx, 1            ; Check position in row
    jz oddRowEven
    mov eax, BRICK_COLOR1   ; Blue for odd position in odd row
    jmp colorSet
oddRowEven:
    mov eax, BRICK_COLOR2   ; Red for even position in odd row
    jmp colorSet
    
evenRow:
    ; Even row - normal pattern
    test edx, 1            ; Check position in row
    jz evenRowEven
    mov eax, BRICK_COLOR2   ; Red for odd position in even row
    jmp colorSet
evenRowEven:
    mov eax, BRICK_COLOR1   ; Blue for even position in even row
    
colorSet:
    call SetTextColor
    
    ; Get position
    mov dh, brickY[ebx]     ; Y position
    mov dl, brickX[ebx]     ; X position
    
    ; Draw the brick
    push ecx
    mov ecx, BRICK_HEIGHT   ; Height counter
    
heightLoop:
    push ecx
    push dx
    
    call Gotoxy
    mov ecx, BRICK_WIDTH
    mov al, 219            ; Solid block character
widthLoop:
    call WriteChar
    loop widthLoop
    
    pop dx
    inc dh                 ; Move down one row
    pop ecx
    loop heightLoop
    
    pop ecx
    
nextBrick:
    inc ebx                ; Move to next brick
    loop drawLoop
    
    popad
    ret
drawBricks ENDP

drawBall PROC
    pushad
    
    ; Set ball color to light red
    mov eax, BALL_COLOR    ; Using the constant we defined
    call SetTextColor
    
    ; Set ball position
    mov dh, ballY
    mov dl, ballX
    call Gotoxy
    
    ; Draw ball
    mov al, BALL_CHAR
    call WriteChar
    
    popad
    ret
drawBall ENDP

clearBall PROC
    pushad
    
    ; Clear old ball position
    mov eax, black + (black * 16)
    call SetTextColor
    mov dh, ballY
    mov dl, ballX
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    popad
    ret
clearBall ENDP

updateBall PROC
    pushad
    
    ; If ball not launched, keep it on paddle
    cmp isBallLaunched, 0
    je ballOnPaddle
    
    call clearBall
    
    ; Update X position
    mov al, ballX
    mov bl, ballDX
    add al, bl
    
    ; Check left boundary (add buffer)
    cmp al, LEFT_BOUNDARY
    jg checkRightBoundary
    mov al, LEFT_BOUNDARY
    add al, 1              ; Keep ball away from left border
    neg ballDX             ; Reverse direction
    jmp updateXPos
    
checkRightBoundary:
    ; Check right boundary (subtract ball width)
    cmp al, RIGHT_BOUNDARY
    jl updateXPos
    mov al, RIGHT_BOUNDARY
    sub al, 1              ; Keep ball away from right border
    neg ballDX             ; Reverse direction
    
updateXPos:
    mov ballX, al
    
    ; Update Y position
    mov al, ballY
    mov bl, ballDY
    add al, bl
    
    ; Check top boundary
    cmp al, 3              ; Top boundary after border
    jg checkPaddleCollision
    mov al, 4              ; Keep ball away from top border
    neg ballDY             ; Reverse Y direction
    jmp finishUpdate
    
checkPaddleCollision:
    ; Check if ball is at paddle height
    cmp al, paddleY
    jne checkBottomBoundary
    
    ; Check if ball is within paddle width
    mov bl, ballX
    cmp bl, paddleX
    jl checkBottomBoundary
    
    mov cl, paddleX
    add cl, PADDLE_WIDTH
    cmp bl, cl
    jg checkBottomBoundary
    
    ; Ball hit paddle - bounce
    sub al, 2              ; Move ball up more to prevent sticking
    neg ballDY             ; Reverse Y direction
    
    ; Add angle based on where ball hits paddle
    mov bl, ballX
    sub bl, paddleX        ; Get relative position on paddle
    cmp bl, PADDLE_WIDTH/3 ; Hit left third
    jl hitLeftSide
    cmp bl, (PADDLE_WIDTH*2)/3 ; Hit right third
    jg hitRightSide
    jmp finishUpdate       ; Hit middle - straight bounce
    
hitLeftSide:
    mov ballDX, -1         ; Move left
    jmp finishUpdate
    
hitRightSide:
    mov ballDX, 1          ; Move right
    jmp finishUpdate
    
checkBottomBoundary:
    cmp al, 27             ; Just before bottom border
    jl finishUpdate
    
    ; Ball hit bottom - lose a life
    dec lives              ; Decrease lives first
    call updateLivesDisplay    ; Update the display
    
    ; Check if game over
    cmp lives, 0
    je gameOver
    
    ; Reset ball position
    call clearBall
    mov isBallLaunched, 0
    jmp ballOnPaddle
    
finishUpdate:
    mov ballY, al
    
    ; Add brick collision check here
    call checkBrickCollision
    
    call drawBall
    jmp updateDone
    
ballOnPaddle:
    ; Position new ball on paddle center
    mov al, paddleX
    add al, PADDLE_WIDTH/2
    mov ballX, al
    mov al, paddleY
    dec al
    mov ballY, al
    call drawBall
    
updateDone:
    popad
    ret
updateBall ENDP

; Add this procedure to check brick collisions
checkBrickCollision PROC
    pushad
    
    mov ecx, MAX_BRICKS
    mov ebx, 0          ; Brick index
    
checkNextBrick:
    push ecx            ; Save loop counter
    
    ; Skip if brick is not active
    cmp brickActive[ebx], 0
    je nextBrick
    
    ; Check if ball position matches brick position
    movzx ax, ballX
    movzx dx, brickX[ebx]
    cmp ax, dx
    jl nextBrick        ; Ball is to the left of brick
    
    add dx, BRICK_WIDTH
    cmp ax, dx
    jg nextBrick        ; Ball is to the right of brick
    
    movzx ax, ballY
    movzx dx, brickY[ebx]
    cmp ax, dx
    jl nextBrick        ; Ball is above brick
    
    add dx, BRICK_HEIGHT
    cmp ax, dx
    jg nextBrick        ; Ball is below brick
    
    ; Collision detected!
    mov brickActive[ebx], 0    ; Deactivate brick
    
    ; Clear the brick visually
    mov dh, brickY[ebx]
    mov dl, brickX[ebx]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearBrick:
    mov al, ' '
    call WriteChar
    loop clearBrick
    
    ; Reverse ball direction
    neg ballDY
    
    ; Add points to score
    mov eax, BRICK_POINTS
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    ; Check if all bricks are destroyed
    call checkAllBricksDestroyed
    cmp eax, 1
    jne continueGame
    
    ; All bricks destroyed - show exit menu
    call showExitMenu
    
continueGame:
    pop ecx
    popad
    ret                     ; Return after collision
    
nextBrick:               ; Add this label for the loop
    pop ecx            ; Restore loop counter
    inc ebx
    dec ecx            ; Decrement counter manually
    jnz checkNextBrick ; Continue if not zero
    
    popad
    ret
checkBrickCollision ENDP

; Add the new HandleInput procedure
HandleInput PROC
    pushad
    
    ; Read key input
    call ReadKey
    jz noKeyPressed    ; If no key pressed, return
    
    ; Check for left arrow key
    cmp ah, KEY_LEFT
    je MoveLeft
    
    ; Check for right arrow key
    cmp ah, KEY_RIGHT
    je MoveRight
    
    ; Check for spacebar
    cmp ah, KEY_SPACE
    je LaunchBall
    
    ; Check for 'P' key
    cmp ah, KEY_P
    je pauseGame
    
noKeyPressed:
    popad
    ret

MoveLeft:
    ; Apply acceleration to the left (negative)
    movsx ax, paddleVelocity
    sub ax, PADDLE_ACCEL
    
    ; Check max speed
    cmp ax, -MAX_PADDLE_SPEED
    jge speedOkLeft
    mov ax, -MAX_PADDLE_SPEED
speedOkLeft:
    mov paddleVelocity, al
    
    ; Calculate new position
    movzx ax, paddleX
    movsx bx, paddleVelocity
    add ax, bx
    
    ; Check left boundary - add buffer to prevent going into border
    mov bx, LEFT_BOUNDARY
    add bx, 1              ; Add small buffer to prevent entering border
    cmp ax, bx
    jg updatePaddlePosLeft
    mov ax, bx             ; Stop at buffer position
    mov paddleVelocity, 0  ; Stop at boundary
updatePaddlePosLeft:
    mov paddleX, al
    call updatePaddle
    popad
    ret

MoveRight:
    ; Apply acceleration to the right (positive)
    movsx ax, paddleVelocity
    add ax, PADDLE_ACCEL
    
    ; Check max speed
    cmp ax, MAX_PADDLE_SPEED
    jle speedOkRight
    mov ax, MAX_PADDLE_SPEED
speedOkRight:
    mov paddleVelocity, al
    
    ; Calculate new position
    movzx ax, paddleX
    movsx bx, paddleVelocity
    add ax, bx
    
    ; Check right boundary - account for paddle width
    mov bx, RIGHT_BOUNDARY
    sub bx, PADDLE_WIDTH   ; Account for paddle width
    ;sub bx, 1              ; Add small buffer to prevent entering border
    cmp ax, bx
    jl updatePaddlePosRight
    mov ax, bx             ; Stop at boundary
    mov paddleVelocity, 0  ; Stop at boundary
updatePaddlePosRight:
    mov paddleX, al
    call updatePaddle
    popad
    ret

pauseGame:
    ; Toggle pause state
    mov al, isPaused
    xor al, 1
    mov isPaused, al
    
    ; If paused, display pause message
    cmp isPaused, 1
    jne resumeGame
    
    ; Display pause message
    mov dh, 15
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET pauseText
    call WriteString
    popad
    ret
    
resumeGame:
    ; Clear pause message (redraw that area)
    mov dh, 15
    mov dl, 45
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, 20              ; Adjust based on pause message length
    mov al, ' '
clearPause:
    call WriteChar
    loop clearPause
    
    popad
    ret
HandleInput ENDP

LaunchBall:
    cmp isBallLaunched, 0    ; Check if ball is already launched
    jne skipLaunch           ; If already launched, ignore
    mov isBallLaunched, 1    ; Set launch flag
skipLaunch:
    popad
    ret

; Add this procedure for the exit menu
showExitMenu PROC
    pushad
    
    ; Clear screen
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
drawExitMenu:
    ; Draw EXIT title without borders (moved more to the right)
    mov eax, yellow + (black * 16)
    call SetTextColor
    
    mov dh, 3
    mov dl, 45          ; Changed from 35 to 45 to move right
    call Gotoxy
    mov edx, OFFSET exitTitle1
    call WriteString
    
    mov dh, 4
    mov dl, 45          ; Changed from 35 to 45
    call Gotoxy
    mov edx, OFFSET exitTitle2
    call WriteString
    
    mov dh, 5
    mov dl, 45          ; Changed from 35 to 45
    call Gotoxy
    mov edx, OFFSET exitTitle3
    call WriteString
    
    mov dh, 6
    mov dl, 45          ; Changed from 35 to 45
    call Gotoxy
    mov edx, OFFSET exitTitle4
    call WriteString
    
    mov dh, 7
    mov dl, 45          ; Changed from 35 to 45
    call Gotoxy
    mov edx, OFFSET exitTitle5
    call WriteString
    
    ; Draw menu options box
    mov dh, 13
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Full block for border
    call WriteChar
    mov ecx, 45
fillMenuTop:
    call WriteChar
    loop fillMenuTop
    mov al, 219
    call WriteChar

    ; Restart Game option
    mov dh, 15
    mov dl, 40
    call Gotoxy
    mov al, 219        ; Left border
    call WriteChar
    
    mov eax, black + (black * 16)
    cmp exitSelection, 0
    jne notRestart
    mov eax, red + (red * 16)
notRestart:
    call SetTextColor
    mov ecx, 45
fillRestartBg:
    mov al, ' '
    call WriteChar
    loop fillRestartBg
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Right border
    call WriteChar

    ; Write Restart text
    mov dh, 15
    mov dl, 57
    call Gotoxy
    mov eax, lightGray + (black * 16)
    cmp exitSelection, 0
    jne notRestartText
    mov eax, yellow + (red * 16)
notRestartText:
    call SetTextColor
    mov edx, OFFSET restartText
    call WriteString

    ; Back to Main Menu option
    mov dh, 17
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Left border
    call WriteChar
    
    mov eax, black + (black * 16)
    cmp exitSelection, 1
    jne notMainMenu
    mov eax, red + (red * 16)
notMainMenu:
    call SetTextColor
    mov ecx, 45
fillMainMenuBg:
    mov al, ' '
    call WriteChar
    loop fillMainMenuBg
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Right border
    call WriteChar

    ; Write Main Menu text
    mov dh, 17
    mov dl, 56
    call Gotoxy
    mov eax, lightGray + (black * 16)
    cmp exitSelection, 1
    jne notMainMenuText
    mov eax, yellow + (red * 16)
notMainMenuText:
    call SetTextColor
    mov edx, OFFSET mainMenuText
    call WriteString

    ; High Scores option
    mov dh, 19
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Left border
    call WriteChar
    
    mov eax, black + (black * 16)
    cmp exitSelection, 2
    jne notHighScores
    mov eax, red + (red * 16)
notHighScores:
    call SetTextColor
    mov ecx, 45
fillHighScoresBg:
    mov al, ' '
    call WriteChar
    loop fillHighScoresBg
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Right border
    call WriteChar

    ; Write High Scores text
    mov dh, 19
    mov dl, 56
    call Gotoxy
    mov eax, lightGray + (black * 16)
    cmp exitSelection, 2
    jne notHighScoresText
    mov eax, yellow + (red * 16)
notHighScoresText:
    call SetTextColor
    mov edx, OFFSET viewScoreText
    call WriteString

    ; Exit Game option
    mov dh, 21
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Left border
    call WriteChar
    
    mov eax, black + (black * 16)
    cmp exitSelection, 3
    jne notExit
    mov eax, red + (red * 16)
notExit:
    call SetTextColor
    mov ecx, 45
fillExitBg:
    mov al, ' '
    call WriteChar
    loop fillExitBg
    
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Right border
    call WriteChar

    ; Write Exit text
    mov dh, 21
    mov dl, 57
    call Gotoxy
    mov eax, lightGray + (black * 16)
    cmp exitSelection, 3
    jne notExitText
    mov eax, yellow + (red * 16)
notExitText:
    call SetTextColor
    mov edx, OFFSET exitGameText
    call WriteString

    ; Draw bottom border
    mov dh, 23
    mov dl, 40
    call Gotoxy
    mov eax, cyan + (cyan * 16)
    call SetTextColor
    mov al, 219        ; Full block for border
    call WriteChar
    mov ecx, 45
fillMenuBottom:
    call WriteChar
    loop fillMenuBottom
    mov al, 219
    call WriteChar

    ; Rest of the procedure remains the same...

menuInputLoop:
    call ReadKey
    jz menuInputLoop
    
    ; Check for up/down arrows
    cmp ah, 48h        ; Up arrow
    je moveUp
    cmp ah, 50h        ; Down arrow
    je moveDown
    cmp ah, 1Ch        ; Enter key
    je processSelection
    jmp menuInputLoop
    
moveUp:
    mov al, exitSelection
    cmp al, 0
    je menuInputLoop
    dec exitSelection
    jmp drawExitMenu
    
moveDown:
    mov al, exitSelection
    cmp al, exitMenuCount-1
    je menuInputLoop
    inc exitSelection
    jmp drawExitMenu
    
processSelection:
    mov al, exitSelection
    cmp al, 0
    je doRestart
    cmp al, 1
    je doMainMenu
    cmp al, 2
    je doHighScores
    cmp al, 3
    je doExit
    jmp menuInputLoop
    
doRestart:
    ; Reset game variables
    mov lives, 3
    mov currentScore, 0
    
    ; Check which level to restart
    mov al, currentLevel
    cmp al, 1              ; Check if Level 2
    je restartLevel2
    cmp al, 2              ; Check if Level3
    je restartLevel3
    
    ; Restart Level 1
    call displayGameScreen
    popad
    ret
    
restartLevel2:
    ; Restart Level 2
    call displayGameScreen2
    popad
    ret
    
restartLevel3:
    ; Restart Level 3
    call displayGameScreen3
    popad
    ret
    
doMainMenu:
    call showMainMenu
    popad
    ret
    
doHighScores:
    call handleLeaderboard
    jmp drawExitMenu
    
doExit:
    ; Show game over screen before exiting
    call showGameOverScreen
    exit
    
showExitMenu ENDP

gameOver:
    call showExitMenu
    ret

; Add this procedure to update lives display
updateLivesDisplay PROC
    pushad
    
    ; Position cursor for lives display
    mov dh, 0
    mov dl, 75
    call Gotoxy

    ; Check current lives to decide what to display
    mov eax, [lives]
    cmp eax, 2
    je showTwoLives
    cmp eax, 1
    je showOneLife
    cmp eax, 0
    je showNoLives
    
    ; Show full lives (3 lives)
    mov edx, OFFSET livesText
    call WriteString
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET heartSymbol
    call WriteString
    mov al, ' '
    call WriteChar
    mov edx, OFFSET heartSymbol
    call WriteString
    mov al, ' '
    call WriteChar
    mov edx, OFFSET heartSymbol
    call WriteString
    jmp displayDone

showTwoLives:
    ; Clear the area first
    mov ecx, 15
    mov al, ' '
clearArea2:
    call WriteChar
    loop clearArea2
    
    ; Return to position and show two hearts
    mov dh, 0
    mov dl, 75
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET heartSymbol
    call WriteString
    mov al, ' '
    call WriteChar
    mov edx, OFFSET heartSymbol
    call WriteString
    jmp displayDone

showOneLife:
    ; Clear the area first
    mov ecx, 15
    mov al, ' '
clearArea1:
    call WriteChar
    loop clearArea1
    
    ; Return to position and show one heart
    mov dh, 0
    mov dl, 75
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET heartSymbol
    call WriteString
    jmp displayDone

showNoLives:
    ; Clear the entire area
    mov ecx, 15
    mov al, ' '
clearArea0:
    call WriteChar
    loop clearArea0

displayDone:
    ; Reset text color
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    popad
    ret
updateLivesDisplay ENDP

; Add this new procedure before END main
showGameOverScreen PROC
    pushad
    
    ; Clear screen
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Draw shadow effect (offset by 1,1)
    mov eax,Gray + (black * 16)
    call SetTextColor
    
    ; Draw GAME shadow (moved 10 columns right)
    mov dh, 11
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle1
    call WriteString
    
    mov dh, 12
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle2
    call WriteString
    
    mov dh, 13
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle3
    call WriteString
    
    mov dh, 14
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle4
    call WriteString
    
    mov dh, 15
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle5
    call WriteString
    
    ; Draw OVER!!! shadow (moved 10 columns right)
    mov dh, 17
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle6
    call WriteString
    
    mov dh, 18
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle7
    call WriteString
    
    mov dh, 19
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle8
    call WriteString
    
    mov dh, 20
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle9
    call WriteString
    
    mov dh, 21
    mov dl, 36        ; Changed from 26 to 36
    call Gotoxy
    mov edx, OFFSET gameOverTitle10
    call WriteString
    
    ; Draw main text in red (moved 10 columns right)
    mov eax, lightRed + (black * 16)
    call SetTextColor
    
    ; Draw GAME
    mov dh, 10
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle1
    call WriteString
    
    mov dh, 11
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle2
    call WriteString
    
    mov dh, 12
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle3
    call WriteString
    
    mov dh, 13
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle4
    call WriteString
    
    mov dh, 14
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle5
    call WriteString
    
    ; Draw OVER!!!
    mov dh, 16
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle6
    call WriteString
    
    mov dh, 17
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle7
    call WriteString
    
    mov dh, 18
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle8
    call WriteString
    
    mov dh, 19
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle9
    call WriteString
    
    mov dh, 20
    mov dl, 35        ; Changed from 25 to 35
    call Gotoxy
    mov edx, OFFSET gameOverTitle10
    call WriteString
    
    ; Add "Press any key to exit..." message (centered)
    mov dh, 23
    mov dl, 45        ; Adjusted to center with new position
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET exitMsg
    call WriteString
    
    ; Wait for key press
    call ReadChar
    
    popad
    ret
showGameOverScreen ENDP

; Add new procedure for Level 2
displayGameScreen2 PROC
    ; Clear screen
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Hide cursor
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov consoleHandle, eax
    mov cursorInfo.dwSize, 100
    mov cursorInfo.bVisible, 0
    INVOKE SetConsoleCursorInfo, consoleHandle, ADDR cursorInfo
    
    ; Display status bar at top
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Display Level
    mov dh, 0
    mov dl, 12
    call Gotoxy
    mov edx, OFFSET levelText
    call WriteString
    mov eax, 2          ; Level 2
    call WriteDec
    
    ; Display Score
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    ; Display Lives
    mov dh, 0
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET livesText
    call WriteString
    
    ; Display hearts with red color
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov ecx, [lives]
displayHearts2:
    mov edx, OFFSET heartSymbol
    call WriteString
    mov al, ' '
    call WriteChar
    loop displayHearts2
    
    ; Draw game boundary with thick borders in yellow
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Top border - make it thicker and longer
    mov dh, 2          ; Start below status bar
    mov dl, 11        ; Start one column earlier
    call Gotoxy
    mov ecx, 95       ; Increased width by 2
fillTopBorder2:
    mov al, 219        ; Solid block character
    call WriteChar
    loop fillTopBorder2
    
    ; Draw side borders - make them thicker
    mov ecx, 25        ; Height of game area
    mov dh, 3         ; Start below top border
drawSideBorders2:
    push ecx
    
    ; Left border (two blocks wide)
    mov dl, 11          ; Start one column earlier
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    ; Right border (two blocks wide)
    mov dl, 104        ; Keep right border position
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    inc dh
    pop ecx
    loop drawSideBorders2
    
    ; Bottom border - make it thicker and longer
    mov dh, 28         ; Bottom row
    mov dl, 11         ; Start one column earlier
    call Gotoxy
    mov ecx, 95       ; Increased width by 2
fillBottomBorder2:
    mov al, 219        ; Solid block character
    call WriteChar
    loop fillBottomBorder2
    
    ; Initialize and draw bricks with different pattern
    call initializeBricks2
    call drawBricks2
    
    ; Initialize paddle position
    mov paddleX, PADDLE_START_X
    mov paddleY, 26
    
    ; Clear paddle area first
    call clearPaddle2
    
    ; Draw initial paddle with shorter width
    mov dh, paddleY
    mov dl, paddleX
    call Gotoxy
    
    ; Draw left edge
    mov eax, PADDLE_EDGE_COLOR
    call SetTextColor
    mov al, 219
    call WriteChar
    
    ; Draw middle part
    mov eax, PADDLE_COLOR
    call SetTextColor
    mov ecx, PADDLE_WIDTH_L2 - 2
    mov al, 219
initialPaddleDraw:
    call WriteChar
    loop initialPaddleDraw
    
    ; Draw right edge
    mov eax, PADDLE_EDGE_COLOR
    call SetTextColor
    mov al, 219
    call WriteChar
    
    ; Initialize ball position
    mov al, paddleX
    add al, PADDLE_WIDTH_L2/2
    mov ballX, al
    mov al, paddleY
    dec al
    mov ballY, al
    mov isBallLaunched, 0
    call drawBall
    
gameLoop2:
    ; Reduce delay for smoother movement
    mov eax, 5
    call Delay
    
    ; Call input handler
    call HandleInput2
    
    ; Check for ESC key
    call ReadKey
    jz updateBallPos2
    cmp al, 27
    je exitGame2
    jmp updateBallPos2
    
updateBallPos2:
    inc ballDelayCounter
    mov al, ballDelayCounter
    cmp al, BALL_DELAY
    jl continueGameLoop2
    
    mov ballDelayCounter, 0
    call updateBall2
    
continueGameLoop2:
    jmp gameLoop2
    
exitGame2:
    ; Show cursor before exit
    mov cursorInfo.bVisible, 1
    INVOKE SetConsoleCursorInfo, consoleHandle, ADDR cursorInfo
    ret
displayGameScreen2 ENDP

; Add new brick initialization for Level 2
initializeBricks2 PROC
    pushad
    
    mov ebx, 0
    mov dl, 4
    mov ecx, BRICK_ROWS
    
rowLoop2:
    push ecx
    mov dh, 14
    mov ecx, BRICKS_PER_ROW
    
brickLoop2:
    mov brickX[ebx], dh
    mov brickY[ebx], dl
    mov brickActive[ebx], 1
    
    ; Check if this is Level 3
    mov al, currentLevel
    cmp al, 2              ; Level 3 (index 2)
    jne normalBrick
    
    ; For Level 3, check if this is the magical brick position
    cmp ebx, MAGICAL_BRICK_INDEX
    je magicalBrick
    
    ; For Level 3, set hits to 3
    mov BRICK_HITS_L3[ebx], 3
    jmp nextBrick
    
magicalBrick:
    mov BRICK_HITS_L3[ebx], 1    ; Magical brick needs only 1 hit
    jmp nextBrick
    
normalBrick:
    mov BRICK_HITS[ebx], 2       ; Normal Level 2 brick needs 2 hits
    
nextBrick:
    add dh, BRICK_WIDTH
    add dh, BRICK_GAP
    inc ebx
    
    loop brickLoop2
    
    add dl, BRICK_HEIGHT
    add dl, BRICK_GAP
    
    pop ecx
    loop rowLoop2
    
    popad
    ret
initializeBricks2 ENDP

; Add new brick drawing for Level 2 with different pattern
drawBricks2 PROC
    pushad
    
    mov ebx, 0              ; Array index
    mov ecx, MAX_BRICKS     ; Total bricks to process
    xor esi, esi            ; Row counter
    
drawLoop2:
    ; Check if brick is active
    cmp brickActive[ebx], 0
    je nextBrick2
    
    ; Calculate row and column position
    mov eax, ebx
    mov edx, 0              ; Clear edx for division
    mov edi, BRICKS_PER_ROW
    div edi                 ; eax = row number, edx = column position
    
    ; Check if this is Level 3
    mov al, currentLevel
    cmp al, 2              ; Level 3 (index 2)
    jne normalBrickColor   ; If not Level 3, use normal alternating pattern
    
    ; For Level 3 - check if this is the power-up brick first
   
   
   
    cmp ebx, POWERUP_BRICK_INDEX
    jne drawGreyBrick
    mov eax, 10 + (10 * 16)    ; Force light green color (10 = light green)
    jmp colorSet2


    drawGreyBrick:
    cmp ebx , 10
    jne checkMagicalBrick2 
    mov eax, 7 + (7 * 16)    ; Light grey color
    jmp colorSet2

checkMagicalBrick2:
    ; Check if magical brick
    cmp ebx, MAGICAL_BRICK_INDEX
    jne checkMiddleColumn
    mov eax, BRICK_COLOR_MAGICAL    ; Brown for magical brick
    jmp colorSet2
    
checkMiddleColumn:
    ; Check if middle column
    cmp edx, 4             ; Middle column
    jne normalBrickColor
    mov eax, BRICK_COLOR_UNBREAKABLE ; Gray for unbreakable
    jmp colorSet2
    
normalBrickColor:
    ; Get row and column for alternating pattern
    mov eax, ebx
    mov edx, 0
    div edi                ; eax = row number, edx = column position
    
    ; Check if we're in an odd or even row
    test eax, 1            ; Test row number
    jz evenRow
    
    ; Odd row
    test edx, 1            ; Test column position
    jz oddRowEvenCol
    mov eax, 9 + (9 * 16)  ; Light blue for odd columns in odd rows
    jmp colorSet2
oddRowEvenCol:
    mov eax, Red + (Red * 16)  ; Red for even columns in odd rows
    jmp colorSet2
    
evenRow:
    ; Even row
    test edx, 1            ; Test column position
    jz evenRowEvenCol
    mov eax, Red + (Red * 16)  ; Red for odd columns in even rows
    jmp colorSet2
evenRowEvenCol:
    mov eax, 9 + (9 * 16)  ; Light blue for even columns in even rows
    
colorSet2:
    call SetTextColor
    
    ; Get position
    mov dh, brickY[ebx]     ; Y position
    mov dl, brickX[ebx]     ; X position
    
    ; Draw the brick
    push ecx
    mov ecx, BRICK_HEIGHT   ; Height counter
    
heightLoop2:
    push ecx
    push dx
    
    call Gotoxy
    mov ecx, BRICK_WIDTH
    mov al, 219            ; Solid block character
widthLoop2:
    call WriteChar
    loop widthLoop2
    
    pop dx
    inc dh                 ; Move down one row
    pop ecx
    loop heightLoop2
    
    pop ecx
    
nextBrick2:
    inc ebx                ; Move to next brick
    dec ecx                ; Decrement counter manually
    jnz drawLoop2          ; Use jnz instead of loop
    
    popad
    ret
drawBricks2 ENDP

; Add new ball update for Level 2 (can be modified for different behavior)
updateBall2 PROC
    pushad
    
    ; If ball not launched, keep it on paddle
    cmp isBallLaunched, 0
    je ballOnPaddle2
    
    ; Ball is launched - handle normal ball movement
    call clearBall
    
    ; Update X position
    mov al, ballX
    mov bl, ballDX
    add al, bl
    
    ; Check boundaries
    cmp al, LEFT_BOUNDARY
    jg checkRightBoundary2
    mov al, LEFT_BOUNDARY
    add al, 2
    neg ballDX
    jmp updateXPos2
    
checkRightBoundary2:
    cmp al, RIGHT_BOUNDARY
    jl updateXPos2
    mov al, RIGHT_BOUNDARY
    sub al, 2
    neg ballDX
    
updateXPos2:
    mov ballX, al
    
    ; Update Y position
    mov al, ballY
    mov bl, ballDY
    add al, bl
    
    ; Check top boundary
    cmp al, 3
    jg checkPaddleCollision2
    mov al, 4
    neg ballDY
    jmp finishUpdate2
    
checkPaddleCollision2:
    ; Check if ball is at paddle height
    cmp al, paddleY
    jne checkBottomBoundary2
    
    ; Check if ball is within paddle width
    mov bl, ballX
    cmp bl, paddleX
    jl checkBottomBoundary2
    
    mov cl, paddleX
    add cl, PADDLE_WIDTH_L2  ; Use shorter paddle width
    cmp bl, cl
    jg checkBottomBoundary2
    
    ; Ball hit paddle - bounce
    sub al, 2
    neg ballDY
    jmp finishUpdate2
    
checkBottomBoundary2:
    cmp al, 27
    jl checkBricks2          ; Jump to brick collision check
    
    ; Ball hit bottom - lose a life
    dec lives
    call updateLivesDisplay
    
    ; Check if game over
    cmp lives, 0
    je gameOver
    
    ; Reset ball position
    call clearBall
    mov isBallLaunched, 0
    jmp ballOnPaddle2
    
checkBricks2:                ; Add this new section
    mov ballY, al           ; Save current Y position
    call checkBrickCollision2  ; Check for brick collisions
    jmp finishUpdate2
    
finishUpdate2:
    mov ballY, al
    call drawBall
    jmp updateDone2
    
ballOnPaddle2:
    ; Clear old ball position
    call clearBall
    
    ; Update ball position to paddle center
    mov al, paddleX
    add al, PADDLE_WIDTH_L2/2
    mov ballX, al
    mov al, paddleY
    dec al
    mov ballY, al
    call drawBall
    
updateDone2:
    popad
    ret
updateBall2 ENDP

; Add new input handler for Level 2 (can be modified for different controls)
HandleInput2 PROC
    pushad
    
    ; Read key input
    call ReadKey
    jz noKeyPressed2    ; If no key pressed, return
    
    ; Check for left arrow key
    cmp ah, KEY_LEFT
    je MoveLeft2
    
    ; Check for right arrow key
    cmp ah, KEY_RIGHT
    je MoveRight2
    
    ; Check for spacebar
    cmp ah, KEY_SPACE
    je LaunchBall2
    
    ; Check for 'P' key
    cmp ah, KEY_P
    je pauseGame2
    
noKeyPressed2:
    popad
    ret

MoveLeft2:
    ; First clear the ball if not launched
    cmp isBallLaunched, 0
    jne skipBallClearLeft
    call clearBall2
skipBallClearLeft:
    
    ; Then clear and move paddle
    call clearPaddle2
    mov al, paddleX
    sub al, PADDLE_SPEED
    
    ; Add buffer space for left border
    mov bl, LEFT_BOUNDARY
    add bl, 1              ; Add buffer to prevent touching border
    cmp al, bl
    jge updatePaddleLeft2
    mov al, bl             ; Stop at buffer position
updatePaddleLeft2:
    mov paddleX, al
    
    ; Update ball position before drawing if not launched
    cmp isBallLaunched, 0
    jne skipBallUpdateLeft
    mov al, paddleX
    add al, PADDLE_WIDTH_L2/2
    mov ballX, al
skipBallUpdateLeft:
    
    ; Draw paddle and ball in new positions
    call drawPaddle2
    cmp isBallLaunched, 0
    jne skipBallDrawLeft
    call drawBall
skipBallDrawLeft:
    popad
    ret

MoveRight2:
    ; First clear the ball if not launched
    cmp isBallLaunched, 0
    jne skipBallClearRight
    call clearBall2
skipBallClearRight:
    
    ; Then clear and move paddle
    call clearPaddle2
    mov al, paddleX
    add al, PADDLE_SPEED
    mov bl, RIGHT_BOUNDARY
    sub bl, PADDLE_WIDTH_L2  ; Use shorter paddle width for boundary check
    cmp al, bl
    jle updatePaddleRight2
    mov al, bl
updatePaddleRight2:
    mov paddleX, al
    
    ; Update ball position before drawing if not launched
    cmp isBallLaunched, 0
    jne skipBallUpdateRight
    mov al, paddleX
    add al, PADDLE_WIDTH_L2/2
    mov ballX, al
skipBallUpdateRight:
    
    ; Draw paddle and ball in new positions
    call drawPaddle2
    cmp isBallLaunched, 0
    jne skipBallDrawRight
    call drawBall
skipBallDrawRight:
    popad
    ret

LaunchBall2:
    cmp isBallLaunched, 0
    jne skipLaunch2
    mov isBallLaunched, 1
skipLaunch2:
    popad
    ret

pauseGame2:
;    call pauseGame
    popad
    ret

HandleInput2 ENDP

; Add this new procedure for drawing the shorter paddle
drawPaddle2 PROC
    pushad
    
    ; Set position
    mov dh, paddleY
    mov dl, paddleX
    call Gotoxy
    
    ; Draw left edge in white
    mov eax, PADDLE_EDGE_COLOR
    call SetTextColor
    mov al, 219        ; Solid block character
    call WriteChar
    
    ; Draw middle part in cyan
    mov eax, PADDLE_COLOR
    call SetTextColor
   mov ecx, PADDLE_WIDTH_L2 - 2  ; Use shorter width
   mov cl, currentPaddleWidth
   sub cl, 2  ; Middle section width
   movzx ecx, cl
drawPaddleMiddle2:
    mov al, 219
    call WriteChar
    loop drawPaddleMiddle2
    
    ; Draw right edge in white
    mov eax, PADDLE_EDGE_COLOR
    call SetTextColor
    mov al, 219
    call WriteChar
    
    popad
    ret
drawPaddle2 ENDP

; Add this new procedure to clear the paddle
clearPaddle2 PROC
    pushad
    
    ; Set position
    mov dh, paddleY
    mov dl, paddleX
    call Gotoxy
    
    ; Set black background color
    mov eax, black + (black * 16)
    call SetTextColor
    
    ; Clear the entire paddle width
   mov ecx, PADDLE_WIDTH_L2
   movzx ecx, currentPaddleWidth
clearPaddleLoop:
    mov al, ' '
    call WriteChar
    loop clearPaddleLoop
    
    popad
    ret
clearPaddle2 ENDP

; Add this new procedure to clear the ball for Level 2
clearBall2 PROC
    pushad
    
    ; Get current ball position
    mov dh, ballY
    mov dl, ballX
    call Gotoxy
    
    ; Clear the ball with a space character
    mov eax, black + (black * 16)
    call SetTextColor
    mov al, ' '
    call WriteChar
    
    popad
    ret
clearBall2 ENDP

; Add this procedure to check if all bricks are destroyed
checkAllBricksDestroyed PROC
    pushad
    
    mov ecx, MAX_BRICKS
    mov ebx, 0
    
checkNextBrick:
    ; Skip if this is Level 3 and middle column (unbreakable)
    mov al, currentLevel
    cmp al, 2              ; Check if Level 3
    jne normalCheck
    
    ; Calculate column position
    mov eax, ebx
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi                ; edx contains column number
    cmp edx, 4             ; Check if middle column
    je skipUnbreakable     ; Skip checking unbreakable bricks
    
normalCheck:
    cmp brickActive[ebx], 1    ; Check if any brick is still active
    je bricksRemain            ; If found active brick, exit
    
skipUnbreakable:
    inc ebx
    loop checkNextBrick
    
    ; If we get here, no active bricks found (except unbreakable in Level 3)
    popad
    mov eax, 1                 ; Return 1 to indicate all breakable bricks destroyed
    ret
    
bricksRemain:
    popad
    mov eax, 0                 ; Return 0 to indicate bricks remain
    ret
checkAllBricksDestroyed ENDP

; Add new brick collision procedure for Level 2
checkBrickCollision2 PROC
    pushad
    
    mov ecx, MAX_BRICKS
    mov esi, 0
    
checkNextBrick2:
    push ecx
    
    ; Skip if brick is not active
    cmp brickActive[esi], 0
    je skipBrick2
    
    ; Get ball and brick positions
    movzx ax, ballY    ; Current ball Y position
    movzx bx, ballX    ; Current ball X position
    movzx dx, brickY[esi]  ; Brick Y position
    movzx cx, brickX[esi]  ; Brick X position
    
    ; Check if ball is above or below brick
    cmp ax, dx
    jl skipBrick2          ; Ball is above brick
    
    add dx, BRICK_HEIGHT
    cmp ax, dx
    jg skipBrick2          ; Ball is below brick
    
    ; Check if ball is left or right of brick
    cmp bx, cx
    jl skipBrick2          ; Ball is left of brick
    
    add cx, BRICK_WIDTH
    cmp bx, cx
    jg skipBrick2          ; Ball is right of brick
    
    ; We have a collision!
    ; First bounce the ball
    neg ballDY             ; Always reverse vertical direction on brick hit
    
    ; Then handle brick damage
    dec BRICK_HITS[esi]    ; Decrease hit counter
    jnz damageBrick2       ; If not zero, just damage the brick
    
    ; Destroy brick on second hit
    mov brickActive[esi], 0
    
    ; Clear the brick
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearLoop2:
    mov al, ' '
    call WriteChar
    loop clearLoop2
    jmp addScore2
    
damageBrick2:
    ; Change brick color based on row and position
    mov eax, esi          ; Use esi instead of ebx for brick index
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi                 ; eax = row number, edx = position in row
    
    ; Check position in row for alternating pattern
    test edx, 1            ; Check if position is odd/even
    jz evenPosDamage2
    
    ; Odd position
    test eax, 1            ; Check if row is odd/even
    jz oddPosEvenRowDamage2
    mov eax, BRICK_COLOR1_DAMAGED   ; Light cyan for damaged cyan brick
    jmp colorBrick2
oddPosEvenRowDamage2:
    mov eax, BRICK_COLOR2_DAMAGED   ; Light red for damaged red brick
    jmp colorBrick2
    
evenPosDamage2:
    ; Even position
    test eax, 1            ; Check if row is odd/even
    jz evenPosEvenRowDamage2
    mov eax, BRICK_COLOR2_DAMAGED   ; Light red for damaged red brick
    jmp colorBrick2
evenPosEvenRowDamage2:
    mov eax, BRICK_COLOR1_DAMAGED   ; Light cyan for damaged cyan brick
    
colorBrick2:
    ; Draw damaged brick
    call SetTextColor
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov ecx, BRICK_WIDTH
drawLoop2:
    mov al, 219
    call WriteChar
    loop drawLoop2
    
addScore2:
    ; Add points
    mov eax, BRICK_POINTS
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    ; Check if all bricks are destroyed
    call checkAllBricksDestroyed
    cmp eax, 1              ; If eax=1, all bricks are destroyed
    jne continueGame2
    
    ; All bricks destroyed - show exit menu
    call showExitMenu
    
continueGame2:
    pop ecx
    popad
    ret                     ; Return after collision
    
    ; ... (rest of the procedure remains the same)
    
skipBrick2:
    pop ecx
    inc esi
    dec ecx
    jnz checkNextBrick2
    
    popad
    ret
checkBrickCollision2 ENDP

displayGameScreen3 PROC
    ; Clear screen
    mov eax, black + (black * 16)
    call SetTextColor
    call ClrScr
    
    ; Hide cursor
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov consoleHandle, eax
    mov cursorInfo.dwSize, 100
    mov cursorInfo.bVisible, 0
    INVOKE SetConsoleCursorInfo, consoleHandle, ADDR cursorInfo
    
    ; Display status bar at top
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Display Level
    mov dh, 0
    mov dl, 12
    call Gotoxy
    mov edx, OFFSET levelText
    call WriteString
    mov eax, 3          ; Level 3
    call WriteDec
    
    ; Display Score
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    ; Display Lives
    mov dh, 0
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET livesText
    call WriteString
    
    ; Display hearts with red color
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov ecx, [lives]
displayHearts3:
    mov edx, OFFSET heartSymbol
    call WriteString
    mov al, ' '
    call WriteChar
    loop displayHearts3
    
    ; Draw game boundary with thick borders in yellow
    mov eax, lightGray + (black * 16)
    call SetTextColor
    
    ; Top border - make it thicker and longer
    mov dh, 2          ; Start below status bar
    mov dl, 11         ; Start one column earlier
    call Gotoxy
    mov ecx, 95       ; Increased width by 2
fillTopBorder3:
    mov al, 219        ; Solid block character
    call WriteChar
    loop fillTopBorder3
    
    ; Draw side borders - make them thicker
    mov ecx, 25        ; Height of game area
    mov dh, 3         ; Start below top border
drawSideBorders3:
    push ecx
    
    ; Left border (two blocks wide)
    mov dl, 11        ; Start one column earlier
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    ; Right border (two blocks wide)
    mov dl, 104        ; Keep right border position
    call Gotoxy
    mov al, 219
    call WriteChar
    mov al, 219
    call WriteChar
    
    inc dh
    pop ecx
    loop drawSideBorders3
    
    ; Bottom border - make it thicker and longer
    mov dh, 28         ; Bottom row
    mov dl, 11         ; Start one column earlier
    call Gotoxy
    mov ecx, 95       ; Increased width by 2
fillBottomBorder3:
    mov al, 219        ; Solid block character
    call WriteChar
    loop fillBottomBorder3
    
    ; Initialize and draw bricks
    call initializeBricks2    ; Reuse Level 2's brick initialization
    call drawBricks2          ; Reuse Level 2's brick drawing
    
    ; Initialize paddle position
    mov paddleX, PADDLE_START_X
    mov paddleY, 26
    
    ; Draw initial paddle
    call drawPaddle2          ; Reuse Level 2's paddle
    
    ; Initialize ball position
    mov al, paddleX
    add al, PADDLE_WIDTH_L2/2
    mov ballX, al
    mov al, paddleY
    dec al
    mov ballY, al
    mov isBallLaunched, 0
    call drawBall
    
    ; After drawing initial bricks, color middle bricks gray
    mov ebx, 4              ; Start with middle column
colorGrayBricks:
    cmp ebx, MAX_BRICKS
    jge doneColoring
    
    ; Color this brick gray
    mov dh, brickY[ebx]
    mov dl, brickX[ebx]
    call Gotoxy
    mov eax, BRICK_COLOR_UNBREAKABLE
    call SetTextColor
    mov ecx, BRICK_WIDTH
drawGrayInit:
    mov al, 219
    call WriteChar
    loop drawGrayInit
    
    add ebx, BRICKS_PER_ROW  ; Move to next row's middle brick
    cmp ebx, MAX_BRICKS
    jl colorGrayBricks
    
doneColoring:
    
    mov al, PADDLE_WIDTH_L2
    mov currentPaddleWidth, al
    
gameLoop3:
    ; Faster delay for Level 3
    mov eax, 1              ; Even faster than Level 2 (was 5 in Level 2)
    call Delay
    
    ; Call input handler
    call HandleInput2       ; Reuse Level 2's input handling
    
    ; Check for ESC key
    call ReadKey
    jz updateBallPos3
    cmp al, 27
    je exitGame3
    jmp updateBallPos3
    
updateBallPos3:
    inc ballDelayCounter
    mov al, ballDelayCounter
    cmp al, BALL_DELAY_L3    ; Use faster delay for Level 3 (defined as 3 in data section)
    jl continueGameLoop3
    
    mov ballDelayCounter, 0
    call updateBall3         ; Use Level 3's ball update
    
continueGameLoop3:
    jmp gameLoop3
    
exitGame3:
    ; Show cursor before exit
    mov cursorInfo.bVisible, 1
    INVOKE SetConsoleCursorInfo, consoleHandle, ADDR cursorInfo
    ret
displayGameScreen3 ENDP

updateBall3 PROC
    pushad
    
    ; If ball not launched, keep it on paddle
    cmp isBallLaunched, 0
    je ballOnPaddle3
    
    call clearBall
    
    ; Update X position
    mov al, ballX
    mov bl, ballDX
    add al, bl
    
    ; Check boundaries
    cmp al, LEFT_BOUNDARY
    jg checkRightBoundary3
    mov al, LEFT_BOUNDARY
    add al, 2
    neg ballDX
    jmp updateXPos3
    
checkRightBoundary3:
    cmp al, RIGHT_BOUNDARY
    jl updateXPos3
    mov al, RIGHT_BOUNDARY
    sub al, 2
    neg ballDX
    
updateXPos3:
    mov ballX, al
    
    ; Update Y position
    mov al, ballY
    mov bl, ballDY
    add al, bl
    
    ; Check top boundary
    cmp al, 3
    jg checkPaddleCollision3
    mov al, 4
    neg ballDY
    jmp finishUpdate3
    
checkPaddleCollision3:
    ; Check if ball is at paddle height
    cmp al, paddleY
    jne checkBottomBoundary3
    
    ; Check if ball is within paddle width
    mov bl, ballX
    cmp bl, paddleX
    jl checkBottomBoundary3
    
    mov cl, paddleX
    add cl, currentPaddleWidth
    cmp bl, cl
    jg checkBottomBoundary3
    
    ; Ball hit paddle - bounce
    sub al, 2
    neg ballDY
    jmp finishUpdate3
    
checkBottomBoundary3:
    cmp al, 27
    jl checkBricks3
    
    ; Ball hit bottom - lose a life
    dec lives
    call updateLivesDisplay
    
    ; Check if game over
    cmp lives, 0
    je gameOver
    
    ; Reset ball position
    call clearBall
    mov isBallLaunched, 0
    jmp ballOnPaddle3
    
checkBricks3:
    mov ballY, al
    call checkBrickCollision3
    jmp finishUpdate3
    
finishUpdate3:
    mov ballY, al
    call drawBall
    jmp updateDone3
    
ballOnPaddle3:
    ; Position ball on paddle center
    mov al, paddleX
    add al, PADDLE_WIDTH_L2/2
    mov ballX, al
    mov al, paddleY
    dec al
    mov ballY, al
    call drawBall
    
updateDone3:
    popad
    ret
updateBall3 ENDP

checkBrickCollision3 PROC
    pushad
    
    mov ecx, MAX_BRICKS
    mov esi, 0          ; Use esi for brick index
    
checkNextBrick3:
    push ecx
    
    ; Skip if brick is not active
    cmp brickActive[esi], 0
    je skipBrick3
    
    ; Check collision
    movzx ax, ballY
    movzx bx, ballX
    movzx dx, brickY[esi]
    movzx cx, brickX[esi]
    
    ; Check vertical collision
    cmp ax, dx
    jl skipBrick3
    add dx, BRICK_HEIGHT
    cmp ax, dx
    jg skipBrick3
    
    ; Check horizontal collision
    cmp bx, cx
    jl skipBrick3
    add cx, BRICK_WIDTH
    cmp bx, cx
    jg skipBrick3
    
    ; Collision detected - bounce ball
    neg ballDY
    
    ; Check if it's middle column (unbreakable)
    mov eax, esi
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi             ; edx contains column number
    cmp edx, 4          ; Middle column
    je skipBrick3       ; If middle column, just bounce
    
    ; Check if it's the power-up brick
    cmp esi, POWERUP_BRICK_INDEX
    jne checkgreybrick   ; If not power-up brick, check if magical
 
    ; Handle power-up brick collision
    mov brickActive[esi], 0    ; Remove power-up brick
    
    ; Clear the power-up brick visually
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearPowerupBrick:
    mov al, ' '
    call WriteChar
    loop clearPowerupBrick
    
    ; Extend paddle width
    mov al, PADDLE_WIDTH_EXTENDED
    mov currentPaddleWidth, al
    
    ; Add power-up points
    mov eax, POWERUP_POINTS
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    jmp skipBrick3
    checkgreybrick : 
    cmp esi , 10 
    jne checkMagicalBrick
    mov brickActive[esi], 0 
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH

    cleargreyBrick:
     mov al, ' '
    call WriteChar
    loop cleargreyBrick
    jmp skipBrick3
    mov eax, 30
    add currentScore, eax
     mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    jmp skipBrick3
    
checkMagicalBrick:
    ; Check if it's the magical brick
    cmp esi, MAGICAL_BRICK_INDEX
    jne normalBrickHit
    
    ; Handle magical brick collision
    mov brickActive[esi], 0    ; Remove magical brick
    
    ; Clear the magical brick visually
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearMagicalBrick:
    mov al, ' '
    call WriteChar
    loop clearMagicalBrick
    
    ; Trigger magical effect
    call handleMagicalBrickEffect
    
    ; Add points
    mov eax, BRICK_POINTS
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    jmp skipBrick3
    
normalBrickHit:
    ; Handle normal brick collision
    dec BRICK_HITS_L3[esi]
    mov al, BRICK_HITS_L3[esi]
    
    ; Check hits remaining
    cmp al, 0
    je destroyBrick3
    cmp al, 1
    je secondHit3
    
    ; First hit - determine brick type and color
    mov eax, esi
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi             ; eax = row number, edx = column position
    
    test eax, 1        ; Check if row is odd/even
    jz evenRow3
    
    ; Odd row
    test edx, 1        ; Check if column is odd/even
    jz oddRowEvenCol3
    mov eax, BRICK_COLOR1_DAMAGED1_L3  ; Odd column in odd row
    jmp updateColor3
oddRowEvenCol3:
    mov eax, BRICK_COLOR2_DAMAGED1_L3  ; Even column in odd row
    jmp updateColor3
    
evenRow3:
    ; Even row
    test edx, 1        ; Check if column is odd/even
    jz evenRowEvenCol3
    mov eax, BRICK_COLOR2_DAMAGED1_L3  ; Odd column in even row
    jmp updateColor3
evenRowEvenCol3:
    mov eax, BRICK_COLOR1_DAMAGED1_L3  ; Even column in even row
    jmp updateColor3
    
secondHit3:
    ; Second hit - determine brick type and color
    mov eax, esi
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi             ; eax = row number, edx = column position
    
    test eax, 1        ; Check if row is odd/even
    jz evenRowSecond3
    
    ; Odd row
    test edx, 1        ; Check if column is odd/even
    jz oddRowEvenColSecond3
    mov eax, BRICK_COLOR1_DAMAGED2_L3  ; Odd column in odd row
    jmp updateColor3
oddRowEvenColSecond3:
    mov eax, BRICK_COLOR2_DAMAGED2_L3  ; Even column in odd row
    jmp updateColor3
    
evenRowSecond3:
    ; Even row
    test edx, 1        ; Check if column is odd/even
    jz evenRowEvenColSecond3
    mov eax, BRICK_COLOR2_DAMAGED2_L3  ; Odd column in even row
    jmp updateColor3
evenRowEvenColSecond3:
    mov eax, BRICK_COLOR1_DAMAGED2_L3  ; Even column in even row
    
updateColor3:
    call SetTextColor
    
    ; Redraw brick with new color
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov ecx, BRICK_WIDTH
drawDamagedBrick3:
    mov al, 219
    call WriteChar
    loop drawDamagedBrick3
    jmp skipBrick3
    
destroyBrick3:
    ; Remove the brick
    mov brickActive[esi], 0
    
    ; Clear the brick visually
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearDestroyedBrick3:
    mov al, ' '
    call WriteChar
    loop clearDestroyedBrick3
    
    ; Add points
    mov eax, BRICK_POINTS
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    ; Check if it's the grey brick (brick 13)
    cmp esi, 10
    jne checkNormalBrick
    call handleGreyBrickCollision
    jmp skipBrick3

checkNormalBrick:
    ; Check if one-hit mode is active
    cmp oneHitModeActive, 1
    je oneHitDestroy
    
    ; Normal multi-hit logic
    dec BRICK_HITS_L3[esi]
    mov al, BRICK_HITS_L3[esi]
    cmp al, 0
    je destroyBrick3
    
    ; Only change brick color if NOT in one-hit mode
    mov eax, esi
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi             ; eax = row number, edx = column position
    
    ; ... rest of your normal brick color logic ...
    jmp skipBrick3

oneHitDestroy:
    ; In one-hit mode, destroy brick immediately without color changes
    mov brickActive[esi], 0
    
    ; Clear the brick visually
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearOneHitBrick:
    mov al, ' '
    call WriteChar
    loop clearOneHitBrick
    
    ; Add points
    mov eax, BRICK_POINTS
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    jmp skipBrick3

    ; ... rest of your code ...
    
skipBrick3:
    pop ecx
    inc esi
    dec ecx
    jnz checkNextBrick3
    
    popad
    ret
checkBrickCollision3 ENDP

; Add new procedure to handle magical brick effect
handleMagicalBrickEffect PROC
    pushad
    
    ; First, identify removable bricks (not middle column, not power-up brick, and active)
    mov ecx, MAX_BRICKS
    mov esi, 0
    mov ebx, 0          ; Count of removable bricks
    
identifyRemovable:
    ; Skip if brick is not active
    cmp brickActive[esi], 0
    je nextIdentify
    
    ; Skip if it's in middle column
    mov eax, esi
    mov edx, 0
    mov edi, BRICKS_PER_ROW
    div edi             ; edx contains column number
    cmp edx, 4          ; Skip middle column
    je nextIdentify
    
    ; Skip if it's the power-up brick
    cmp esi, POWERUP_BRICK_INDEX
    je nextIdentify
    
    ; This brick can be removed
    mov REMOVABLE_BRICKS[esi], 1
    inc ebx             ; Increment count of removable bricks
    
nextIdentify:
    inc esi
    loop identifyRemovable
    
    ; Now randomly select 5 bricks to remove
    mov ecx, 5          ; We want to remove 5 bricks
    
removeLoop:
    push ecx
    
    ; Generate random number between 0 and number of removable bricks
    mov eax, ebx        ; Number of removable bricks
    call RandomRange    ; Get random number in eax
    
    ; Find the nth removable brick
    mov ecx, eax        ; Target count
    mov esi, 0          ; Start from first brick
    
findBrick:
    cmp REMOVABLE_BRICKS[esi], 1
    jne nextFind
    dec ecx
    js foundBrick       ; If we counted down to -1, we found our brick
nextFind:
    inc esi
    cmp esi, MAX_BRICKS
    jl findBrick
    
foundBrick:
    ; Remove the found brick
    mov brickActive[esi], 0
    mov REMOVABLE_BRICKS[esi], 0  ; Mark as not removable anymore
    dec ebx                       ; Decrease count of removable bricks
    
    ; Clear the brick visually
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearRandomBrick:
    mov al, ' '
    call WriteChar
    loop clearRandomBrick
    
    ; Add 30 points for each brick removed by magical effect
    mov eax, 30
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    pop ecx
    dec ecx
    jnz removeLoop
    
    popad
    ret
handleMagicalBrickEffect ENDP

WritePlayerScores PROC
    ; Create/Open scores file
    mov edx, OFFSET scoresFile
    call CreateOutputFile
    mov fileHandle, eax
    
    ; Check if file was created successfully
    cmp eax, INVALID_HANDLE_VALUE
    je write_error

    ; Write scores
    mov edx, OFFSET scores
    mov ecx, 10          ; Size of scores array
    mov eax, fileHandle
    call WriteToFile
    jc write_error

    ; Write levels
    mov edx, OFFSET levels
    mov ecx, 5           ; Size of levels array
    mov eax, fileHandle
    call WriteToFile
    jc write_error

    ; Close the file
    mov eax, fileHandle
    call CloseFile
    ret

write_error:
    ret
WritePlayerScores ENDP

ReadPlayerScores PROC
    ; Open existing scores file
    mov edx, OFFSET scoresFile
    call OpenInputFile
    mov fileHandle, eax

    ; Check if file opened successfully
    cmp eax, INVALID_HANDLE_VALUE
    je read_error

    ; Read scores
    mov edx, OFFSET scores
    mov ecx, 10          ; Size of scores array
    mov eax, fileHandle
    call ReadFromFile
    jc read_error

    ; Read levels
    mov edx, OFFSET levels
    mov ecx, 5           ; Size of levels array
    mov eax, fileHandle
    call ReadFromFile
    jc read_error

    ; Close the file
    mov eax, fileHandle
    call CloseFile
    ret

read_error:
    ret
ReadPlayerScores ENDP

handleGreyBrickCollision PROC
    pushad
    
    ; Activate one-hit mode
    mov oneHitModeActive, 1
    mov oneHitTimer, 0         ; Reset timer
    
    ; Clear the grey brick
    mov brickActive[esi], 0    ; Remove grey brick
    mov dh, brickY[esi]
    mov dl, brickX[esi]
    call Gotoxy
    mov eax, black + (black * 16)
    call SetTextColor
    mov ecx, BRICK_WIDTH
clearGreyBrick:
    mov al, ' '
    call WriteChar
    loop clearGreyBrick
    
    ; Add points
    mov eax, 30               ; Points for grey brick
    add currentScore, eax
    
    ; Update score display
    mov dh, 0
    mov dl, 45
    call Gotoxy
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mov edx, OFFSET scoreText
    call WriteString
    mov eax, currentScore
    call WriteDec
    
    popad
    ret
handleGreyBrickCollision ENDP

; Add this procedure to update the one-hit mode timer
updateOneHitMode PROC
    pushad
    
    ; Check if one-hit mode is active
    cmp oneHitModeActive, 0
    je exitUpdate
    
    ; Update timer
    inc oneHitTimer
    mov eax, oneHitTimer
    cmp eax, ONE_HIT_DURATION
    jl exitUpdate
    
    ; Time's up - disable one-hit mode
    mov oneHitModeActive, 0
    mov oneHitTimer, 0
    
exitUpdate:
    popad
    ret
updateOneHitMode ENDP
END main 