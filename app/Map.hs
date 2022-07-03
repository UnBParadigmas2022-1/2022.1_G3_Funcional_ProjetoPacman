module Map where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Data.Fixed

import Types


mapaWidth  = 28      :: Float
mapaHeight = 31      :: Float
mapaLength = round (mapaWidth * mapaHeight)

mapaAtual :: Mapa
mapaAtual = [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,
        0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 0 ,
        0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0 ,
        0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0 ,
        0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 ,
        0, 1, 1, 1, 7, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 10, 1, 1, 1, 0 ,
        0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0 ,
        0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0 ,
        1, 1, 3, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1 ,
        0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0 ,
        0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0 ,
        0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0 ,
        0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0 ,
        0, 1, 0, 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 7, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 3, 1, 0 ,
        0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 ,
        0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 ,
        0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 0, 0, 1, 1, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 3, 1, 1, 1, 1, 0, 0, 1, 1, 1, 7, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 7, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0 ,
        0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 10, 1, 1, 0 ,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    ]


-- Draw

imageCell :: Cell -> Assets -> CellSize -> Picture
imageCell 0 (wall:_) _ = wall
imageCell 1 _ cellSize = color black $ rectangleSolid cellSize cellSize
imageCell 3 [_, gold, _, _, _, _, _, _, _, _] _    = gold
imageCell 7 [_, _, diamond, _, _, _, _, _, _, _] _ = diamond
imageCell 10 [_, _, _, nether, _, _, _, _, _, _] _  = nether

drawMapaCell :: Assets -> CellSize -> Float -> Float -> Cell -> Picture
drawMapaCell assets cellSize x y cell = translate x y $ imageCell cell assets cellSize

drawMapa :: Assets -> CellSize -> Width -> Mapa -> Point -> [Picture]
drawMapa _ _ _ [] _ = []
drawMapa assets cellSize width (h:t) (x, y) = drawMapaCell assets cellSize x y h : drawMapa assets cellSize width t nextPoint
    where
        newLine = mod' (x + cellSize) width == 0
        nextPoint = (nextX, nextY)
        nextX
            | newLine = 0
            | otherwise = x + cellSize
        nextY
            | newLine = y - cellSize
            | otherwise = y


-- Utils

point2Index :: Point -> Int
point2Index (x, y) = round (mapaWidth * (abs y) + x)

isCellFree :: Point -> Bool
isCellFree (x, y)
    | index < 0 || index >= mapaLength = False
    | otherwise = mapaAtual !! index > 0
    where
        index = point2Index (x, y)

getCellValue :: Point -> Float
getCellValue point = mapaAtual !! point2Index point

adjs :: [Point]
adjs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

freeAdjsPoints :: Point -> [Point]
freeAdjsPoints (x, y) = filter isCellFree points
    where
        points = map (\(i, j) -> (x+i, y+j)) adjs

isWallCell :: Point -> Bool
isWallCell point = getCellValue point == 0

generateNext :: [MultValor] -> Point -> Point
generateNext [] initial = initial
generateNext [(f,p)] _ = f
generateNext [(f,p), _] _ = f
generateNext ((f,p):t) initial = next t initial p

next :: [MultValor] -> Point -> Point -> Point
next ((f,p):t) initial previous
    | p == initial && f == previous = f
    | f == previous = next t initial p
    | otherwise = next t initial previous

isTunnel :: Point -> Bool
isTunnel (x, y) = not (isWallCell (x, y))
    && (x == mapaWidth-1 || y == mapaHeight-1 || x == 0 || y == 0 )
