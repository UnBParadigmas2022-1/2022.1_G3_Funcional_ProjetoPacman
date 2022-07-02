module Djikstra (djikstraPath) where

import Data.Heap
import Data.List
import Graphics.Gloss

import Map
import Types

type Valor = (Point, Point)

calcCaminho :: Mapa -> [Valor] -> Point -> MinPrioHeap Float Valor -> (Valor, MinPrioHeap Float Valor)
calcCaminho mapa visitados posInicial heap = do
    let Just ((pesoSelecionado, (selecionado, paiSelecionado)), heapPop) = view heap
    let adjsLivres = (freeAdjsPoints selecionado) \\ map (\(filho, _) -> filho) visitados
    let novaHeap = foldl (\heap adj -> insereHeap (adj, selecionado) ((mapa !! point2Index adj) + pesoSelecionado) heap) heapPop adjsLivres
    ((selecionado, paiSelecionado), novaHeap)

djikstra :: Point -> Point -> [Valor] -> MinPrioHeap Float Valor -> [Valor]
djikstra posInicial posFinal visitados heap
    | selecionado == posFinal = novosVisitados
    | not isVazia = djikstra selecionado posFinal novosVisitados novaHeap
    | otherwise = error "Caminho nao encontrado"
    where
        isVazia = Data.Heap.null heap 
        ((selecionado, paiSelecionado), novaHeap) = calcCaminho mapaAtual visitados posInicial heap
        novosVisitados 
            | not (selecionado `elem` map (\(filho, _) -> filho) visitados) = visitados ++ [(selecionado, paiSelecionado)] 
            | otherwise = visitados

insereHeap :: Valor -> Float -> MinPrioHeap Float Valor -> MinPrioHeap Float Valor
insereHeap (posicao, pai) peso  heap =
    Data.Heap.insert (peso, (posicao, pai)) heap

menorCaminho :: Point -> Point -> [Valor]
menorCaminho posInicial posFinal
    | posInicial == posFinal = [(posFinal, posFinal)]
    | otherwise = caminho
    where
        heap = insereHeap (posInicial, posInicial) 0 (empty :: MinPrioHeap Float Valor)
        caminho = djikstra posInicial posFinal [] heap

proximo :: [Valor] -> Point -> Point -> Point
proximo ((f,p):t) inicial anterior
    | p == inicial && f == anterior = f
    | f == anterior = proximo t inicial p
    | otherwise = proximo t inicial anterior

geraProximo :: [Valor] -> Point -> Point
geraProximo [] inicial = inicial
geraProximo [(f,p)] _ = f
geraProximo [(f,p), _] _ = f
geraProximo ((f,p):t) inicial = proximo t inicial p

djikstraPath :: Point -> Point -> Point
djikstraPath posInicial posFinal = geraProximo (reverse caminho) posInicial
    where
        caminho = menorCaminho posInicial posFinal
