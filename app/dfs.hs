module Dfs where

import Graphics.Gloss
import Data.List

import Map
import Types

dfsShortestPath :: Point -> Point -> Point
dfsShortestPath initialPos goalPos = nextPos
    where
        path = dfs [] (initialPos, initialPos) goalPos [(initialPos, initialPos)]
        nextPos = generateNext path initialPos

dfs :: [MultValor] -> MultValor -> Point -> [MultValor] -> [MultValor]
dfs path (initialPos, _) goalPos stack
    | currentPos == goalPos = generalPath
    | not (null adjStack) = dfs generalPath nextPos goalPos adjStack
    | otherwise = error "There's no corresponding solution path"
    where
        ((currentPos, previousPos):tail) = stack
        nextPos = (currentPos, previousPos)
        valors2Points = map (\(pos, pos1) -> pos) path
        adjs = ((freeAdjsPoints currentPos) \\ valors2Points)
        adjStack = map (\pos -> (pos, currentPos)) adjs ++ tail
        generalPath = ((currentPos, previousPos):path)
