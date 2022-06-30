module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Ghost


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, ghost) = pictures $ (Map.drawMapa assets cellSize width mapa (0, 0)) ++ [dGhost]
    where 
        dGhost = Ghost.drawGhost assets cellSize ghost

updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, mapa, assets, ghost) = (cellSize, width, mapa, assets, uGhost)
    where 
        uGhost = Ghost.updateGhost ghost

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
