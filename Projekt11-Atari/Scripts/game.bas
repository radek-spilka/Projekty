  player0x = 25
  player0y = 50
  b = 1
 
  player1x = 135
  player1y = 50
  a = 1

  score = 0
  scorecolor = $0B
  c = 3 ; zivoty
  d = 3 ; zivoty

  h = 1 ; moznosti, co se deje v mainmenu | h = 1 Proti sobe | h = 2 Spolecne

  ballx = 50
  bally = 50
  ballheight = 7
  e = 1
  f = 1

  i = 0 ; i = 0 nemuze, i = 1 muze strilet
  j = 0

  rem MENU
  k = 0 ; k = 0 nemuze, l = 1 muze ovladat menu
  l = 0
  m = 0 ; blikani tlacitek v menu

  player0:
  %10001001
  %10001001
  %10101001
  %11011011
  %10001001
end
  
  player1:
  %10001011
  %10001010
  %10101011
  %11011001
  %10001011
end


;-------------------------------------MAIN MENU-------------------------------------

mainmenu
    playfield:
    ....X...X..XXX..X...X..X..X.....
    ....XX.XX..X....XX..X..X..X.....
    ....X.X.X..XXX..X.X.X..X..X.....
    ....X...X..X....X..XX..X..X.....
    ....X...X..XXX..X...X...XX......
    ................................
    ......XXXXXXXXXXXXXXXXXXX.......
    ......XX...............XX.......
    ......XX...............XX.......
    ......XX...............XX.......
    ......XXXXXXXXXXXXXXXXXXX.......
end

    COLUPF = $FC

    rem $0A - neoznaceno
    rem $1E - oznaceno

    NUSIZ0=$15
    NUSIZ1=$15

    missile0height = 6
    missile1height = 6

    CTRLPF = $31

    scorecolor = 0

    player0x = 70
    player0y = 65

    player1x = 70
    player1y = 75

    ballx = 0
    bally = 0

    l = l + 1
    if l > 50 then k = 1 : l = 51

    if joy0up || joy1up then h = h - 1 : m = 26
    if joy0down || joy1down then h = h + 1 : m = 26

    if h = 1 && joy0fire && k = 1 then player0x = 25 : player0y = 50 : player1x = 125 : player1y = 50 : score = 300003 : goto proti_sobe
    if h = 1 && joy1fire && k = 1 then player0x = 25 : player0y = 50 : player1x = 125 : player1y = 50 : score = 300003 : goto proti_sobe 

    if h = 2 && joy0fire && k = 1 then player0x = 76 : player0y = 30 : player1x = 76 : player1y = 60 : ballx = 20 : bally = 30 : goto spolecne
    if h = 2 && joy1fire && k = 1 then player0x = 76 : player0y = 30 : player1x = 76 : player1y = 60 : ballx = 20 : bally = 30 : goto spolecne 

    if h = 0 then h = 1
    if h = 3 then h = 2

    if h = 1 then missile0x = 65 : missile0y = 66 : missile1x = 94 : missile1y = 66
    if h = 2 then missile0x = 65 : missile0y = 76 : missile1x = 94 : missile1y = 76


    if m > 0 && m < 25 && h = 1 then COLUP0 = $00 
    if m > 25 && m < 50 && h = 1 then COLUP0 = $1E
    if h = 1 then COLUP1 = $0A 

    if m > 0 && m < 25 && h = 2 then COLUP1 = $00
    if m > 25 && m < 50 && h = 2 then COLUP1 = $1E 
    if h = 2 then COLUP0 = $0A

    m = m + 1
    if m = 51 then m = 1

    

    drawscreen
    goto mainmenu


;-------------------------------------PROTI SOBE-------------------------------------


proti_sobe
    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end 
   player0:
   %11011000
   %10010000
   %10000000
   %00000000
   %01001011
   %11011110
   %11000110
   %00000011
   %11110000
   %10000000
   %10010000
   %11100000
end

   player1:
   %00011011
   %00001001
   %00000001
   %00000000
   %11010010
   %01111011
   %01100011
   %11000000
   %00001111
   %00000001
   %00001001
   %00000111
end

    COLUPF = $0A
    COLUP0 = $86
    COLUP1 = $46

    NUSIZ0=$20
    NUSIZ1=$20

    CTRLPF = $33

    scorecolor = $0B

    missile0height = 2
    missile1height = 2

    rem STRILENI
    j = j + 1

    if j > 50 then i = 1 : j = 51

    rem PRVNI HRAC - OVLADANI (VLEVO)
    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 1
    if joy0left then player0x = player0x - 1
    if joy0right then player0x = player0x + 1
 
    rem PRVNI HRAC - KOLIZE
    if player0y < 20 then player0y = 20
    if player0y > 80 then player0y = 80
    if player0x < 22 then player0x = 22
    if player0x > 72 then player0x = 72
    if collision(missile1,player0) then player0x = player0x - 10 : a=1 : score = score - 100000 : c = c - 1

    rem PRVNI HRAC - STRILENI
    if joy0fire && b=1 && i = 1 then missile0x = player0x+10 : missile0y = player0y-5 : b=2
    if b=1 then missile0x = 0 : missile0y = 0  
    if b=2 then missile0x = missile0x + 2
    if b=2 && missile0x > 150 then b=1

    rem DRUHY HRAC - OVLADANI (VPRAVO)
    if joy1up then player1y = player1y - 1
    if joy1down then player1y = player1y + 1
    if joy1left then player1x = player1x - 1
    if joy1right then player1x = player1x + 1
 
    rem DRUHY HRAC - KOLIZE 
    if player1y < 20 then player1y = 20
    if player1y > 80 then player1y = 80
    if player1x < 80 then player1x = 80
    if player1x > 132 then player1x = 132
    if collision(missile0,player1) then player1x = player1x + 10 : b=1 : score = score - 1 : d = d - 1
  
    rem DRUHY HRAC - STRILENI
    if joy1fire && a=1 && i = 1 then missile1x = player1x-1 : missile1y = player1y-5 : a=2
    if a=1 then missile1x = 0 : missile1y = 0  
    if a=2 then missile1x = missile1x - 2
    if a=2 && missile1x < 10 then a=1

    if d = 0 then hracvlevovyhral
    if c = 0 then hracvpravovyhral

    drawscreen
    goto proti_sobe

;-------------------------------------HRAC VLEVO VYHRAL-------------------------------------

hracvlevovyhral
    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X..............................X
    X...XX.X...X..X.X.XX.XX....X...X
    X...XX.X..X.X..X..XX.XX...XX...X
    X...X..X..XXX..X..X..X.X...X...X
    X...X..XX.X.X..X..XX.X.X...X...X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end 

    player1:
    %00011011
    %00001001
    %00000001
    %00000000
    %11010010
    %01111011
    %01000000
    %11010001
    %00001010
    %00000100
    %00001010
    %00010001
end

    COLUPF = $86
    COLUP0 = $86
    COLUP1 = $46

    CTRLPF = $07

    player0x = 35
    player0y = 65
    player1x = 115
    player1y = 65

    m = m + 1
    if m > 250+250 then reboot

    drawscreen
    goto hracvlevovyhral

;-------------------------------------HRAC VPRAVO VYHRAL-------------------------------------

hracvpravovyhral
    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X..............................X
    X..XX.X...X..X.X.XX.XX...XX....X
    X..XX.X..X.X..X..XX.XX.....X...X
    X..X..X..XXX..X..X..X.X...X....X
    X..X..XX.X.X..X..XX.X.X..XXXX..X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end 

    player0:
    %00011011
    %00001001
    %00000001
    %00000000
    %11010010
    %01111011
    %01000000
    %11010001
    %00001010
    %00000100
    %00001010
    %00010001
end

    COLUPF = $46
    COLUP0 = $86
    COLUP1 = $46

    CTRLPF = $07

    player0x = 35
    player0y = 65
    player1x = 115
    player1y = 65

    m = m + 1
    if m > 250+250 then reboot

    drawscreen
    goto hracvpravovyhral



;-------------------------------------SPOLECNE-------------------------------------

spolecne
    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end 

   player0:
   %11011000
   %10010000
   %10000000
   %00000000
   %01010000
   %11010000
   %11010000
   %00000000
   %11110000
   %10000000
   %10010000
   %11100000
end

   player1:
   %11011000
   %10010000
   %10000000
   %00000000
   %01010000
   %11010000
   %11010000
   %00000000
   %11110000
   %10000000
   %10010000
   %11100000
end

    COLUPF = $0A
    COLUP0 = $86
    COLUP1 = $46

    scorecolor = $0B

    missile0x = 0
    missile0y = 0
    missile1x = 0
    missile1y = 0

    rem PRVNI HRAC - OVLADANI (VLEVO)
    if joy0up && c = 3 then player0y = player0y - 1
    if joy0down && c = 3 then player0y = player0y + 1

    rem PRVNI HRAC - KOLIZE
    if player0y < 20 then player0y = 20
    if player0y > 80 then player0y = 80

    rem DRUHY HRAC - OVLADANI (VPRAVO)
    if joy1up && d = 3 then player1y = player1y - 1
    if joy1down && d = 3 then player1y = player1y + 1

    rem DRUHY HRAC - KOLIZE
    if player1y < 20 then player1y = 20
    if player1y > 80 then player1y = 80



    rem BALON
    ballx = ballx + e + r
    bally = bally + f + r

    if ballx > 150 then e = -e
    if ballx < 5 then e = -e
    if bally > 78 then f = -f
    if bally < 15 then f = -f

    score = score + 1

    if collision(ball,player0) then c = 0
    if collision(ball,player1) then d = 0

    if c = 0 then player0x = 0 : player0y = 0
    if d = 0 then player1x = 0 : player1y = 0

    if c = 0 && d = 0 then goto konecspolecne

    drawscreen
    goto spolecne


konecspolecne
    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    ................................
    ....XXXXX..X..XX.XX..XXX........
    ......X....X..X.X.X..X....XX....
    ......X....X..X.X.X..XXX........
    ......X....X..X...X..X....XX....
    ......X....X..X...X..XXX........
    ................................
    ................................
    ................................
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end 
    
    COLUPF = $FC

    player0x = 0
    player0y = 0
    player1x = 0
    player1y = 0

    ballx = 0
    bally = 0

    missile0x = 0
    missile0y = 0
    missile1x = 0
    missile1y = 0

    m = m + 1

    if m > 250+250 then reboot

    drawscreen
    goto konecspolecne












