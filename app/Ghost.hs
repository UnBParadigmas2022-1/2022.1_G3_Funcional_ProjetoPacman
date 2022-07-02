module Ghost where

import Graphics.Gloss
import Types
import AEstrela

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, _, orangeGhost] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost

updateGhost :: Ghost -> Player -> Ghost
updateGhost (x,y) ((px, py), (_, _)) = (newX,-newY)
    where
        (newX, newY) = AEstrela.aStar (x, abs(y)) (px, py)
