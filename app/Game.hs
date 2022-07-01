module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Ghost


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, ghosts) = pictures $ (Map.drawMapa assets cellSize width mapa (0, 0)) ++ [dGhost]
    where 
        dGhost = Ghost.drawGhosts ghosts assets cellSize

updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, mapa, assets, ghosts) = (cellSize, width, mapa, assets, uGhosts)
    where 
        uGhosts = updateGhosts ghosts

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
