module Djikstra (djikstraPath) where

import Data.Heap
import Data.List
import Graphics.Gloss

import Map
import Types

calcCaminho :: Mapa -> [MultValor] -> Point -> MinPrioHeap Float MultValor -> (MultValor, MinPrioHeap Float MultValor)
calcCaminho mapa visitados posInicial heap = do
    let Just ((pesoSelecionado, (selecionado, paiSelecionado)), heapPop) = view heap
    let adjsLivres = (freeAdjsPoints selecionado) \\ map (\(filho, _) -> filho) visitados
    let novaHeap = foldl (\heap adj -> insereHeap (adj, selecionado) ((mapa !! point2Index adj) + pesoSelecionado) heap) heapPop adjsLivres
    ((selecionado, paiSelecionado), novaHeap)

djikstra :: Point -> Point -> [MultValor] -> MinPrioHeap Float MultValor -> [MultValor]
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

insereHeap :: MultValor -> Float -> MinPrioHeap Float MultValor -> MinPrioHeap Float MultValor
insereHeap (posicao, pai) peso  heap =
    Data.Heap.insert (peso, (posicao, pai)) heap

menorCaminho :: Point -> Point -> [MultValor]
menorCaminho posInicial posFinal
    | posInicial == posFinal = [(posFinal, posFinal)]
    | otherwise = caminho
    where
        heap = insereHeap (posInicial, posInicial) 0 (empty :: MinPrioHeap Float MultValor)
        caminho = djikstra posInicial posFinal [] heap

djikstraPath :: Point -> Point -> Point
djikstraPath posInicial posFinal = generateNext (reverse caminho) posInicial
    where
        caminho = menorCaminho posInicial posFinal
