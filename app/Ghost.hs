module Ghost where

import Graphics.Gloss
import Types
import Bfs

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, orangeGhost] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost

updateGhost :: Ghost -> Ghost
updateGhost (x,y) = (newX,-newY)
    where
        (newX, newY) = Bfs.bShortestPath (x,abs(y)) (26,29)
