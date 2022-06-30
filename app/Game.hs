module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map

import Scoreboard

type Game = (CellSize, Width, Height, Mapa, Score)

drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa, (x, y), score) = 
    pictures 
    $ (Map.drawMapa cellSize width mapa (0, 0) 
        ++ coin
        ++ [Scoreboard.drawScoreboard height score])

updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, score) = 
    (cellSize, 
        width, 
        height,
        mapa, 
        (x + 1, y), 
        (score+1) `mod` 255)

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
