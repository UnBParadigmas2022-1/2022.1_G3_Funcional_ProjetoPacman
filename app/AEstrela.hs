module AEstrela (aStar) where

import Data.Heap
import Data.List
import Graphics.Gloss

import Map
import Types

type Valor = (Int, MultValor)

aStar posInicial posFinal = posProx
    where
        mapa = mapaAtual
        heap = insereHeap posInicial posInicial 0 0 (empty :: MinPrioHeap Float Valor)
        caminho = aEstrela mapa [] [] (posInicial, posInicial) posFinal heap
        posProx = geraProximo (reverse caminho) posInicial

insereHeap :: Point -> Point -> Float -> Int -> MinPrioHeap Float Valor -> MinPrioHeap Float Valor
insereHeap posInicial posPai valorF valorG heap =
    Data.Heap.insert (valorF, (valorG, (posInicial, posPai))) heap

calcDist :: Point -> Point -> Mapa -> Float
calcDist (xInicial, yInicial) (xFinal, yFinal) mapa =
    sqrt (((xFinal - xInicial) ^ 2) + ((yFinal - yInicial) ^ 2)) + getCellValue (xInicial, yInicial)

calcCaminho :: Mapa -> [Point] -> Point -> Point -> MinPrioHeap Float Valor -> (MultValor, MinPrioHeap Float Valor)
calcCaminho mapa visitados posInicial posFinal heap = do
    let Just ((_, (gAtual, selecionado)), heapPop) = view heap
    let adjsLivres = (freeAdjsPoints posInicial) \\ visitados
    let novaHeap = foldl (\heap adj -> insereHeap adj posInicial (calcDist adj posFinal mapa) (gAtual + 1) heap) heapPop adjsLivres
    (selecionado, novaHeap)

aEstrela :: Mapa -> [MultValor] -> [Point] -> MultValor -> Point -> MinPrioHeap Float Valor -> [MultValor]
aEstrela mapa caminho visitados (posInicial, _) posFinal heap
    | selecionado == posFinal = novoCaminho
    | not isVazia = aEstrela mapa novoCaminho novoVisitados (selecionado, posInicial) posFinal novaHeap
    | otherwise = error "Caminho impossivel de ser encontrado"
    where
        isVazia = Data.Heap.null heap
        ((selecionado, pai), novaHeap) = calcCaminho mapa visitados posInicial posFinal heap
        novoCaminho
            | not (selecionado `elem` map (\(pos, _) -> pos) caminho) = caminho ++ [(selecionado, pai)]
            | otherwise = caminho
        novoVisitados = selecionado : visitados
