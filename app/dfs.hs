module Dfs  where

import Graphics.Gloss
import Data.List

import Map
import Types

type Valor = (Point, Point)

-- Função que recebe um mapa e um ponto e devolve o valor do ponto
dfsShortestPath:: Point -> Point -> Point
dfsShortestPath posInicial posFinal = posProx
    where
        caminho = dfs [] (posInicial, posInicial) posFinal [(posInicial, posInicial)]
        posProx = pop caminho

-- Funcao que empilha os valores na pilha
-- push :: [Valor] -> Valor -> [Valor] ---> incorreto
push pilha x = pilha ++ [x]

-- Funcao que retorna o primeiro valor da pilha
-- top :: [Valor] -> Valor
top [x] = x
top  (x:xs) = top xs


-- Funcao que desempilha os valores da pilha
-- pop :: [Valor] -> [Valor]
pop [] = error "Pilha vazia"
pop (x:xs) | (x == top(x:xs)) = xs
           | otherwise = x:(pop xs)


-- Descrição da Funcao dfs
-- 1 Passo:
-- Pegar o ponto atual
-- 2 Passo:
-- Verificar se o ponto atual é o ponto final
-- 3 Passo:
-- Pegar os vizinhos do ponto atual
-- 4 Passo:
-- Add vizinho na pilha
-- 5 Passo:
-- Retornar a pilha
-- dfs :: [Valor] -> Valor -> Valor -> [Valor] -> [Valor]
dfs pilha (posAtual, posInicial) posFinal caminho
    | (posAtual == posFinal) = caminho
    | not (null filaAdj) = dfs pilha (posAtual,posInicial) posFinal caminho
    | otherwise = error "Sem solucao"
    where
        vizinhos = (freeAdjsPoints posAtual)
        pilha = push pilha map (\pos -> (pos, posAtual) vizinhos
        -- posFinal = (top pilha)
        caminho = pilha
























-- dfsShortestPath:: Point -> Point -> Point
-- dfsShortestPath posInicial posFinal = posProx
--     where
--         caminho = dfs [] (posInicial, posInicial) posFinal [(posInicial, posInicial)]
--         posProx = pop caminho

-- push :: [Valor] -> Point -> Point -> [Valor]
-- push pilha posInicial posFinal = (posInicial, posFinal) : pilha


-- -- push ::[Int] -> Int -> [Int]
-- push pilha x y = x:pilha



-- -- top :: [Int] -> Int
-- top [] = error "Pilha vazia"
-- top [x] = x
-- top (x:xs) = top xs

-- -- pop :: [Int] -> [Int]
-- pop [] = error "Pilha vazia"
-- pop (x:xs)
--     | (x == (top (x:xs))) = xs
--     | otherwise = x:(pop xs)

-- is_empty :: [(Point,Point)] -> Bool
-- is_empty []= True


-- dfs:: [Valor] -> Valor -> Point -> [Valor] -> [Valor]
-- dfs  (posInicial, _) posFinal pilha
--     | posAtual == posFinal = novosVisitados
--     | is_empty pilha = dfs  posProx posFinal pilha
--     | otherwise = error "Sem solucao"
--     whereLq

--         -- Posicao atual
           -- Busca adjacentes
           -- Adiciona na pilha o adjacente