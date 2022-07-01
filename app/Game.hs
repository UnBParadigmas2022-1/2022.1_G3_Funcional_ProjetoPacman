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
        uGhost = updateGhostSlow ghost
        
getSlow 2 = 3
getSlow 3 = 7
getSlow 4 = 10
getSlow 5 = 13

updateGhostSlow (x, y, slow)
    | actualValue == 1, slow == 0  = Ghost.updateGhost (x, y, -1)
    | actualValue > 1, slow < 0 = (x, y, getSlow actualValue)
    | slow > 0 = (x, y, slow - 1)
    | otherwise = Ghost.updateGhost (x, y, slow)
    where   
        actualValue = getCellValue(x,y)

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
