module Ghost where

import Graphics.Gloss

import Types
import AEstrela
import Map

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, _, orangeGhost] cellSize (x,y, _) =
    translate (cellSize*x) (cellSize*y) orangeGhost


updateGhost :: Player -> Ghost -> Ghost
updateGhost ((px, py), (_, _)) (x, y, slow) = (newX, -newY, slow)
    where
        (newX, newY) = AEstrela.aStar (x,abs y) (px, abs py)


drawGhosts :: Ghosts -> Assets -> CellSize -> Picture 
drawGhosts ghosts assets cellsize = pictures $ map (drawGhost assets cellsize) ghosts


updateGhosts :: Ghosts -> Player -> Ghosts
updateGhosts ghosts player = map (updateGhostSlow player) ghosts


updateGhostSlow :: Player -> Ghost -> Ghost
updateGhostSlow player (x, y, slow)
    | actualValue == 1, slow == 0  = Ghost.updateGhost player (x, y, -1)
    | actualValue > 1, slow < 0 = (x, y, actualValue)
    | slow > 0 = (x, y, slow - 1)
    | otherwise = Ghost.updateGhost player (x, y, slow)
    where   
        actualValue = getCellValue(x,y)
