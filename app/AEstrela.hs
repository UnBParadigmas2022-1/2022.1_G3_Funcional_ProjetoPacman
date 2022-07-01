module AEstrela (aStar) where

import Data.Heap
import Data.List
import Graphics.Gloss

import Types
import Map
import Types


type Valor = (Int, Point)

aStar posInicial posFinal
    | posInicial == posFinal = posInicial
    | otherwise = (menorCaminho posInicial posFinal) !! 1

insereHeap :: Point -> Float -> Int -> MinPrioHeap Float Valor -> MinPrioHeap Float Valor
insereHeap posInicial valorF valorG heap =
    Data.Heap.insert (valorF, (valorG, posInicial)) heap

menorCaminho :: Point -> Point -> [Point]
menorCaminho posInicial posFinal = caminho
    where
        mapa = mapaAtual
        heap = insereHeap posInicial 0 0 (empty :: MinPrioHeap Float Valor)
        caminho = aEstrela mapa [] [] posInicial posFinal heap

calcDist :: Point -> Point -> Mapa -> Float
calcDist (xInicial, yInicial) (xFinal, yFinal) mapa =
    ((xFinal - xInicial) ^ 2) + ((yFinal - yInicial) ^ 2) + getCellValue (xInicial, yInicial)

calcCaminho :: Mapa -> [Point] -> Point -> Point -> MinPrioHeap Float Valor -> (Point, MinPrioHeap Float Valor)
calcCaminho mapa visitados posInicial posFinal heap = do
    let Just ((_, (gAtual, selecionado)), heapPop) = view heap
    let adjsLivres = (freeAdjsPoints posInicial) \\ visitados
    let novaHeap = foldl (\heap adj -> insereHeap adj (calcDist adj posFinal mapa) (gAtual + 1) heap) heapPop adjsLivres
    (selecionado, novaHeap)

aEstrela :: Mapa -> [Point] -> [Point] -> Point -> Point -> MinPrioHeap Float Valor -> [Point]
aEstrela mapa caminho visitados posInicial posFinal heap
    | selecionado == posFinal = novoCaminho
    | not isVazia = aEstrela mapa novoCaminho novoVisitados selecionado posFinal novaHeap
    | otherwise = error "Caminho impossivel de ser encontrado"
    where
        isVazia = Data.Heap.null heap
        (selecionado, novaHeap) = calcCaminho mapa visitados posInicial posFinal heap
        novoCaminho
            | not (selecionado `elem` caminho) = caminho ++ [selecionado]
            | otherwise = caminho
        novoVisitados = selecionado : visitados
