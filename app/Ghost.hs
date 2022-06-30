module Ghost where

import Graphics.Gloss
import Types

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, diamond, _] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ diamond

updateGhost :: Ghost -> Ghost
updateGhost (x,y) = (x+1,y)
