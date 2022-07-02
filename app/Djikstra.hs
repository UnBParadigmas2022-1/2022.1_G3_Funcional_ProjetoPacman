import Data.Heap
import Data.List
import Graphics.Gloss

import Map
import Types

-- Insere nó e distância na Heap
insereHeap :: Point -> Float -> MinPrioHeap Float Point -> MinPrioHeap Float Point
insereHeap posicao peso  heap =
    Data.Heap.insert (peso, posicao) heap

menorCaminho :: Point -> Point -> [Point]
menorCaminho posInicial posFinal
    | posInicial == posFinal = [posFinal]
    | otherwise = caminho
    where
        heap = insereHeap posInicial 0 (empty :: MinPrioHeap Float Point)
        caminho = djikstra posInicial posFinal [] heap

djikstra :: Point -> Point -> [Point] -> MinPrioHeap Float Point -> [Point]
djikstra posInicial posFinal visitados heap
    | selecionado == posFinal = novosVisitados
    | not isVazia = djikstra selecionado posFinal novosVisitados novaHeap
    | otherwise = error "Caminho nao encontrado"
    where
        isVazia = Data.Heap.null heap 
        (selecionado, novaHeap) = calcCaminho mapaAtual visitados posInicial heap
        -- novosVisitados = visitados ++ [selecionado] 
        novosVisitados 
            | not (selecionado `elem` visitados) = visitados ++ [selecionado] 
            | otherwise = visitados



calcCaminho :: Mapa -> [Point] -> Point -> MinPrioHeap Float Point -> (Point, MinPrioHeap Float Point)
calcCaminho mapa visitados posInicial heap = do
    let Just ((pesoSelecionado, selecionado), heapPop) = view heap
    -- let adjsLivres = (freeAdjsPoints posInicial) \\ map (\(filho, _) -> filho) visitados
    let adjsLivres = (freeAdjsPoints posInicial) \\visitados
    let novaHeap = foldl (\heap adj -> insereHeap adj ((mapa !! point2Index adj) + pesoSelecionado) heap) heapPop adjsLivres
    (selecionado, novaHeap)