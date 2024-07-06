# Tic Tac Toe

A gesture-driven Tic Tac Toe game for two players on iOS. 

## Author 

Yutong Sun  
milktaro798@gmail.com   

## Features

- Game board grid drawn using UIBezierPath in a custom GridView
- Nine transparent UIViews to detect interactions on each grid square
- Draggable X and O game pieces using UIPanGestureRecognizer 
- Custom InfoView to display instructions and game outcome
- Animations for piece placement, invalid moves, game end, and new game start
- Grid model to track game state and determine winner

## Gameplay

1. X goes first. The current player's piece is highlighted and animated.
2. Drag a piece to an open square. The piece snaps into place if valid.
3. If the move is invalid, the piece animates back to its start position. 
4. The game ends when there is a winner or a tie.
5. The InfoView animates in to display the outcome. Tap to dismiss.
6. All pieces fade out and a new game begins with X's turn.

## Screenshots

![](https://github.com/MilkTaro798/Tic-Tac-Toe/blob/main/Simulator%20Screenshot-1.png)

![](https://github.com/MilkTaro798/Tic-Tac-Toe/blob/main/Simulator%20Screenshot-2.png)

![](https://github.com/MilkTaro798/Tic-Tac-Toe/blob/main/Simulator%20Screenshot-3.png)

## Icon Source

https://www.icons101.com/icon/id_75826/setid_2529/Brain_Games_by_QuizAnswers/TicTacToeGame
