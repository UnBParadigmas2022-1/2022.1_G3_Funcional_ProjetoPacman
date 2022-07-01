module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map

import Scoreboard
import Coin ( drawCoin )

-- type Game = (CellSize, Width, Height, Mapa, Score)

drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa, assets, (x, y), score) = 
    pictures 
    $ (Map.drawMapa assets cellSize width mapa (0, 0) 
    ++ [Scoreboard.drawScoreboard height score])
    ++ coin
    
    where
        coin = drawCoin cellSize (x, y)

updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, (x, y), score) = 
    (cellSize, 
        width, 
        height,
        mapa,
        assets,
        (x + 1, y), 
        (score+1) `mod` 255)

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
