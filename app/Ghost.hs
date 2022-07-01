module Ghost where

import Graphics.Gloss
import Types
import AEstrela

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, orangeGhost] cellSize (x,y, _)= color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost

updateGhost :: Ghost -> Ghost
updateGhost (x, y, slow) = (newX, -newY, slow)
    where
        (newX, newY) = AEstrela.aStar (x,abs(y)) (26,29)
