module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Coin


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, (x, y)) = 
    pictures $ (Map.drawMapa assets cellSize width mapa (0, 0)) ++ coin
    where
        coin = drawCoin cellSize (x, y)

updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, mapa, assets, (x, y)) = 
    (cellSize, width, mapa, assets, (x + 1, y))

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
