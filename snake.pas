Program snakePascal;

Uses wincrt, crt;


type gameState = (starting, playing, over, exit);


Var 
    game : gameState;
    gameSpeed : byte;
    snakeLength, foodX, foodY : integer;
    dotX, dotY : array[1..50] of Shortint;
    movingFace : 0..5;

const 
    UP_KEY = 'i';
    DOWN_KEY = 'k';
    LEFT_KEY = 'j';
    RIGTH_KEY = 'l';
    EXIT_KEY = 'e';
    dotChar = '?';
    headChar = '@';
    foodChar = '*';
    password = '0000';
	
Function input(text:string):string; 
Var incoming: string;
Begin
    Write(text);
	Readln(incoming);
	input := incoming;
End;

Procedure onPressedKey(key:char);
Begin
    If game = playing Then
        Begin
            If key = UP_KEY Then
                movingFace := 1
            Else
            If key = DOWN_KEY Then
                movingFace := 2
            Else
            If key = LEFT_KEY Then
                movingFace := 3
            Else
            If key = RIGTH_KEY Then
                movingFace := 4;
        End;
    If key = EXIT_KEY Then
        game := exit;
End;    


Procedure NewFood;
Begin
    foodX := random(119) + 1;
    foodY := random(29) + 1;
end;

Procedure MainGame;
Var i : integer;
	pw : string;
Begin
    randomize;
    game := starting;

	pw := input('Enter game password : ');
	while (pw <> password) do
        Begin
            writeln('Password incorrect !');
            pw := input('Enter game password again : ');
    End;
    clrscr;
    writeln('Welcome to snake pascal !!');
    gotoxy(1, 3);
    writeln('How to play :');
    gotoxy(1, 5);
    writeln('I : UP');
    writeln('K : DOWN');
    writeln('L : RIGTH');
    writeln('J : LEFT');
    gotoxy(1, 10);
    writeln('E : EXIT');
    gotoxy(1, 13);
    write('Press any key to play . . .');
    readkey;

	gameSpeed := 80;
    movingFace := 4;
    snakeLength := 5;
    dotX[1] := 70;
    dotY[1] := 15;
	For i := 2 To length(dotX) Do
        Begin
            dotX[i] := dotX[i - 1] - 1;
            dotY[i] := dotY[i];
        End;
    NewFood;
    game := playing;
End;

Procedure GameOver;
Begin
    game := over;
    gotoxy(1, 1);
    writeln('Game Over :(');
    writeln('Your score is ', snakeLength/2:2:2);

End;

Procedure DrawGame;
Var i : integer;
Begin
    gotoxy(foodX, foodY);
    write(foodChar);
    gotoxy(dotX[1], dotY[1]);
    write(headChar);
    For i := 2 To snakeLength Do
        Begin
            gotoxy(dotX[i], dotY[i]);
            write(dotChar);
        End;
End;

Procedure SnakeMoving;
Var i : integer;
Begin
    For i := snakeLength Downto  2 Do
        Begin
            dotX[i] := dotX[i - 1];
            dotY[i] := dotY[i - 1];
        End;
    If movingFace = 1 Then
        dotY[1] -= 1
    Else
    If movingFace = 2 Then
        dotY[1] += 1
    Else
    If movingFace = 3 Then
        dotX[1] -= 1
    Else
    If movingFace = 4 Then
        dotX[1] += 1;

    If (dotX[1] < 1) or (dotX[1] > 120) or (dotY[1] < 1) or (dotY[1] > 30) Then
        GameOver;

    For i := snakeLength Downto  2 Do
        Begin
            If (dotX[1] = dotX[i]) and (dotY[1] = dotY[i]) Then
                GameOver;
        End;
    
End;


Procedure CheckTouchFood;
Begin
    If ((dotX[1] = foodX) and (dotY[1] = foodY)) then
        Begin
            snakeLength += 2;
            NewFood;
        End;
End;

Procedure MainLoop;
Begin
    If game = playing Then
        Begin
			clrscr;
            DrawGame;
            SnakeMoving;
            CheckTouchFood;
        End;
End;
	

Begin
    MainGame;
	While(game <> exit) Do
    Begin
        Delay(gameSpeed);
        If KeyPressed Then
			onPressedKey(readkey);
        MainLoop;
    End;
End.
