-- module AEstrela (menorCaminho) where
module AEstrela where

import Data.Heap
import Utils (mapaAtual, Pos, Mapa)

type Valor = (Int, Pos)

adjs :: [Pos]
adjs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

insereHeap :: Pos -> Int -> Int -> MinPrioHeap Int Valor -> MinPrioHeap Int Valor
insereHeap posInicial valorF valorG heap =
    insert (valorF, (valorG, posInicial)) heap

menorCaminho :: Pos -> Pos -> [Pos]
menorCaminho posInicial posFinal = caminho
    where
        mapa = mapaAtual
        heap = insereHeap posInicial 0 0 (empty :: MinPrioHeap Int Valor)
        caminho = aEstrela mapa [] [] posInicial posFinal heap
        -- caminho = []

-- TODO: essas funções são genéricas
mapaHeight = 31
mapaWidth = 28
mapaLength =
    mapaHeight * mapaWidth

coord2Index :: Pos -> Int
coord2Index (x, y) =
    mapaWidth * y + x

isCellFree :: Mapa -> [Pos] -> Pos -> Bool
isCellFree mapa visitados (x, y)
    -- | index < 0 || index >= mapaLength || pos `elem` visitados = False
    | index < 0 || index >= mapaLength = False
    | (x, y) `elem` visitados = False
    -- | otherwise = mapa !! index > 0
    | otherwise = mapa !! y !! x > 0
    where
        index = coord2Index (x, y)
        -- index = mapa !! fst pos !! snd pos

freeAdjs :: Mapa -> Pos -> [Pos] -> [Pos]
freeAdjs mapa (x, y) visitados =
    Prelude.filter (\coord -> isCellFree mapa visitados coord) $ map (\(i, j) -> (x+i, y+j)) adjs

calcDist :: Pos -> Pos -> Mapa -> Int
calcDist (xInicial, yInicial) (xFinal, yFinal) mapa =
    ((xFinal - xInicial) ^ 2) + ((yFinal - yInicial) ^ 2) + mapa !! yInicial !! xInicial

calcCaminho :: Mapa -> [Pos] -> [Pos] -> Pos -> Pos -> MinPrioHeap Int Valor -> (Pos, MinPrioHeap Int Valor)
calcCaminho mapa caminho visitados posInicial posFinal heap = do
    let Just ((_, (gAtual, selecionado)), heapPop) = view heap
    let adjsLivres = freeAdjs mapa posInicial visitados
    let novaHeap = foldl (\heap adj -> insereHeap adj (calcDist adj posFinal mapa) (gAtual + 1) heap) heapPop adjsLivres
    (selecionado, novaHeap)

aEstrela :: Mapa -> [Pos] -> [Pos] -> Pos -> Pos -> MinPrioHeap Int Valor -> [Pos]
aEstrela mapa caminho visitados posInicial posFinal heap
    | selecionado == posFinal = novoCaminho
    | not isVazia = aEstrela mapa novoCaminho novoVisitados selecionado posFinal novaHeap
    | otherwise = error "Caminho impossivel de ser encontrado"
    where
        isVazia = Data.Heap.null heap
        (selecionado, novaHeap) = calcCaminho mapa caminho visitados posInicial posFinal heap
        novoCaminho
            | not (selecionado `elem` caminho) = caminho ++ [selecionado]
            | otherwise = caminho
        novoVisitados = selecionado : visitados
