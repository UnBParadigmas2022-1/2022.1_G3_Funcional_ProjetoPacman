module Ghost where

import Graphics.Gloss
import Types
import AEstrela
import Bfs

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost [_, _, _, _, _, orangeGhost] cellSize (x,y) = color yellow $ translate (cellSize*x) (cellSize*(y)) $ orangeGhost


updateGhost :: Ghost -> Player -> Algorithm -> Ghost
updateGhost (x,y) ((px, py), (_, _)) algo = (newX, -newY)
    where
        point = (x,abs(y))
        (newX, newY)
            | algo == ASTAR = AEstrela.aStar point (px, py)
            | algo == BFS = Bfs.bShortestPath point (px, py)
            | otherwise = AEstrela.aStar point (px, py)
