module Ghost where

import Graphics.Gloss
import Types
import AEstrela

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, diamond, _] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ diamond

updateGhost :: Ghost -> Ghost
updateGhost (x,y) = (newX,-newY)
    where
        (newX, newY) = AEstrela.aStar (x,abs(y)) (26,29)
