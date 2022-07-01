module Ghost where

import Graphics.Gloss
import Types
import AEstrela
import Bfs

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, orangeGhost] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost

updateGhost :: Ghost -> Algorithm -> Ghost
updateGhost (x,y) algo = (newX, -newY)
    where
        point = (x,abs(y))
        (newX, newY)
            | algo == ASTAR = AEstrela.aStar point (26,29)
            | algo == BFS = Bfs.bShortestPath point (26,29)
            | otherwise = AEstrela.aStar point (26,29)

