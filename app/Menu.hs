module Menu where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types


-- Draw
drawMenu :: Width -> String -> Picture
drawMenu width title = translate (-width/2 + 50) 100 $ pictures [dTitle, drawSubTitle width]
    where
        dTitle = color red $ text title

drawSubTitle :: Width -> Picture
drawSubTitle width = dScale $ dTranslate $ color white $ pictures $ dText : drawAlgorithms (-200) algos
    where
        algos = ["A - A* Search", "B - Breadth First Search", "D - Depth-first search", "K - Dijkstra"]
        dText = text "Escolha um dos algoritmos para comecar:"
        dScale = scale 0.2 0.2
        dTranslate = translate 50 (-200)

drawAlgorithms :: Float -> [String] -> [Picture]
drawAlgorithms _ [] = []
drawAlgorithms height (h:t) = translate 100 height (text h) : drawAlgorithms (height-150) t


-- Update
menuInputHandler :: Event -> Game -> Game
menuInputHandler (EventKey (Char 'a') Down _ _) (cellSize, width, mapa, assets, ghost, state, algo) = (cellSize, width, mapa, assets, ghost, GAME, ASTAR)
menuInputHandler (EventKey (Char 'b') Down _ _) (cellSize, width, mapa, assets, ghost, state, algo) = (cellSize, width, mapa, assets, ghost, GAME, BFS)
menuInputHandler (EventKey (Char 'd') Down _ _) (cellSize, width, mapa, assets, ghost, state, algo) = (cellSize, width, mapa, assets, ghost, GAME, DFS)
menuInputHandler (EventKey (Char 'k') Down _ _) (cellSize, width, mapa, assets, ghost, state, algo) = (cellSize, width, mapa, assets, ghost, GAME, DJK)
menuInputHandler _ g = g