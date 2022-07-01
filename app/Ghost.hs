module Ghost where

import Graphics.Gloss
import Types
import AEstrela
import Map

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, orangeGhost] cellSize (x,y, _)= color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost

updateGhost :: Ghost -> Ghost
updateGhost (x, y, slow) = (newX, -newY, slow)
    where
        (newX, newY) = AEstrela.aStar (x,abs(y)) (26,29)

drawGhosts :: Ghosts -> Assets -> CellSize -> Picture 
drawGhosts ghosts assets cellsize = pictures (map (drawGhost assets cellsize) ghosts)

updateGhosts :: Ghosts -> Ghosts
updateGhosts ghosts = map (updateGhostSlow) ghosts

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