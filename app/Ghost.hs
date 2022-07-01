module Ghost where

import Graphics.Gloss
import Types
import AEstrela

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, orangeGhost] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost

updateGhost :: Ghost -> Algorithm -> Ghost
updateGhost (x,y) algo = (newX, -newY)
    where
        (newX, newY)
            | algo == ASTAR = AEstrela.aStar (x,abs(y)) (26,29)
            | otherwise = AEstrela.aStar (x,abs(y)) (26,29)

