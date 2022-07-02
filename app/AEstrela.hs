module AEstrela (aStar) where

import Data.Heap
import Data.List
import Graphics.Gloss

import Types
import Map
import Types

type Valor = (Int, MultValor)


aStar :: Point -> Point -> Point
aStar initialPos goalPos = nextPos
    where
        actualMap = mapaAtual
        heap = heapInsert initialPos initialPos 0 0 (empty :: MinPrioHeap Float Valor)
        path = aEstrela actualMap [] [] (initialPos, initialPos) goalPos heap
        nextPos = generateNext (reverse path) initialPos

heapInsert :: Point -> Point -> Float -> Int -> MinPrioHeap Float Valor -> MinPrioHeap Float Valor
heapInsert initialPos oldPos valueF valueG heap =
    Data.Heap.insert (valueF, (valueG, (initialPos, oldPos))) heap

calcDist :: Point -> Point -> Mapa -> Float
calcDist (initialX, initialY) (finalX, finalY) actualMap =
    sqrt (((finalX - initialX) ^ 2) + ((finalY - initialY) ^ 2)) + getCellValue (initialX, initialY)

calcPath :: Mapa -> [Point] -> Point -> Point -> MinPrioHeap Float Valor -> (MultValor, MinPrioHeap Float Valor)
calcPath actualMap visited initialPos goalPos heap = do
    let Just ((_, (actualG, selected)), heapPop) = view heap
    let freeAdjs = (freeAdjsPoints initialPos) \\ visited
    let newHealp = foldl (\heap adj -> heapInsert adj initialPos (calcDist adj goalPos actualMap) (actualG + 1) heap) heapPop freeAdjs
    (selected, newHealp)

aEstrela :: Mapa -> [MultValor] -> [Point] -> MultValor -> Point -> MinPrioHeap Float Valor -> [MultValor]
aEstrela actualMap path visited (initialPos, _) goalPos heap
    | selected == goalPos = newPath
    | not isHeapFree = aEstrela actualMap newPath currentVisited (selected, initialPos) goalPos newHealp
    | otherwise = error "Impossible to find the corresponding path"
    where
        isHeapFree = Data.Heap.null heap
        ((selected, oldPos), newHealp) = calcPath actualMap visited initialPos goalPos heap
        newPath
            | not (selected `elem` map (\(pos, _) -> pos) path) = path ++ [(selected, oldPos)]
            | otherwise = path
        currentVisited = selected : visited
