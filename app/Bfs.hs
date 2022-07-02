module Bfs (bShortestPath) where

import Graphics.Gloss
import Data.List

import Map
import Types

bShortestPath :: Point -> Point -> Point
bShortestPath initialPos goalPos = nextPos
    where
        path = bfs [] (initialPos, initialPos) goalPos [(initialPos, initialPos)]
        nextPos = generateNext path initialPos

bfs :: [MultValor] -> MultValor -> Point -> [MultValor] -> [MultValor]
bfs path (initialPos, _) goalPos queue
    | currentPos == goalPos = generalPath
    | not (null adjQueue) = bfs generalPath nextPos goalPos adjQueue
    | otherwise = error "There's no corresponding solution path"
    where
        ((currentPos, previousPos):remainingQueue) = queue
        nextPos = (currentPos, previousPos)
        valors2Points = map (\(pos, _) -> pos) path
        adjs = ((freeAdjsPoints currentPos) \\ valors2Points)
        adjQueue = remainingQueue ++ map (\pos -> (pos, currentPos)) adjs
        generalPath = (currentPos, previousPos) : path
