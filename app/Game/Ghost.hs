module Game.Ghost where

import Graphics.Gloss

import Types
import Algorithms.AEstrela ( aStar )
import Algorithms.Bfs ( bShortestPath )
import Algorithms.Djikstra ( djikstraPath )
import Algorithms.Dfs ( dfsShortestPath )
import Game.Map

ghostImage :: Assets -> Algorithm -> Picture
ghostImage [_, _, _, _, _, orangeGhost, _, _, _] BFS = orangeGhost
ghostImage [_, _, _, _, _, _, _, pinkGhost, _] ASTAR =  pinkGhost
ghostImage [_, _, _, _, _, _, _, _, blueGhost] DJK = blueGhost
ghostImage [_, _, _, _, _, orangeGhost, _, _, _] DFS = orangeGhost

drawGhost :: Assets -> Float -> Ghost -> Picture
drawGhost assets cellSize (x,y, _, algo) = translate (cellSize*x) (cellSize*y) (ghostImage assets algo)

updateGhost :: Player -> Ghost -> Ghost
updateGhost ((px, py), (_, _), _) (x,y, slow, algo) = (newX, -newY, slow, algo)
    where
        point = (x,abs(y))
        (newX, newY)
            | algo == ASTAR = aStar point (px, py)
            | algo == BFS = bShortestPath point (px, py)
            | algo == DJK = djikstraPath point (px, py)
            | algo == DFS = dfsShortestPath point (px, py)
            | otherwise = aStar point (px, py)


drawGhosts :: Ghosts -> Assets -> CellSize -> Picture 
drawGhosts ghosts assets cellsize = pictures $ map (drawGhost assets cellsize) ghosts


updateGhosts :: Ghosts -> Player -> Ghosts
updateGhosts ghosts player = map (updateGhostSlow player) ghosts


updateGhostSlow :: Player -> Ghost -> Ghost
updateGhostSlow player (x, y, slow, algo)
    | actualValue == 1, slow == 0 = updateGhost player (x, y, -1, algo)
    | actualValue > 1, slow < 0 = (x, y, actualValue, algo)
    | slow > 0 = (x, y, slow - 1, algo)
    | otherwise = updateGhost player (x, y, slow, algo)
    where   
        actualValue = getCellValue(x,y)
