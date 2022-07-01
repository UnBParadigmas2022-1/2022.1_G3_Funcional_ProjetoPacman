module Bfs (bShortestPath) where

import Graphics.Gloss
import Data.List

import Map
import Types

type Valor = (Point, Point)

bShortestPath:: Point -> Point -> Point
bShortestPath posInicial posFinal = posProx
    where
        caminho = bfs [] (posInicial, posInicial) posFinal [(posInicial, posInicial)]
        posProx = geraProximo caminho posInicial

geraProximo :: [Valor] -> Point -> Point
geraProximo [] inicial = inicial
geraProximo [(f,p)] _ = f
geraProximo [(f,p), _] _ = f
geraProximo ((f,p):t) inicial = proximo t inicial p

proximo :: [Valor] -> Point -> Point -> Point
proximo ((f,p):t) inicial anterior
    | p == inicial && f == anterior = f
    | f == anterior = proximo t inicial p
    | otherwise = proximo t inicial anterior

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
        filaAdj = map (\pos -> (pos, posAtual)) adjs
        novosVisitados = (posAtual, posAnterior):visitados