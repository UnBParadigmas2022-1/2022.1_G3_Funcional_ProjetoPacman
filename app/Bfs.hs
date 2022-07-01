module Bfs (bShortestPath) where

import Graphics.Gloss
import Data.List

import Map
import Types

type Valor = (Point, Point)

bfs:: [Valor] -> Valor -> Point -> [Valor] -> [Valor]
bfs visitados (posInicial, _) posFinal fila
    | posAtual == posFinal = novosVisitados
    | not (null filaAdj) = bfs novosVisitados posProx posFinal filaAdj
    | otherwise = error "Sem solucao"
    where
        ((posAtual, posAnterior):cauda) = fila
        posProx = (posAtual, posAnterior)
        valors2Points = map (\(pos, _) -> pos) visitados
        adjs = ((freeAdjsPoints posAtual) \\ valors2Points)
        filaAdj = cauda ++ map (\pos -> (pos, posAtual)) adjs
        novosVisitados = visitados ++ [(posAtual, posAnterior)]