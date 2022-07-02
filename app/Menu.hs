module Menu where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types


-- Draw
drawMenu :: Width -> String -> State -> Picture
drawMenu width title state =
    translate (-width/2 + 50) 100 
    $ pictures [dTitle, drawSubTitle width state]
    where
        dTitle = color red $ text title

drawSubTitle :: Width -> State -> Picture
drawSubTitle width state = 
    scale 0.2 0.2
    $ translate 50 (-200)
    $ color white 
    $ pictures $ dText : drawOptions (-200) options
    where
        options
            | state == MENU = ["1 - Modo Solo", "2 - Modo Dificil"]
            | state == MENU_SOLO = ["A - A* Search", "B - Breadth First Search", "D - Depth-first search", "K - Dijkstra"]
        dText = text "Escolha uma das opcoes abaixo:"

drawOptions :: Float -> [String] -> [Picture]
drawOptions _ [] = []
drawOptions height (h:t) = translate 100 height (text h) : drawOptions (height-150) t


-- Input
menuInputHandler :: Event -> Game -> Game
menuInputHandler event (cellSize, width, mapa, assets, player, ghost, state, algo) =
    (cellSize, width, mapa, assets, player, ghost, iState, iAlgo)
    where
        (iState, iAlgo) = menuEventHandler event state algo

menuEventHandler :: Event -> State -> Algorithm -> (State, Algorithm)
menuEventHandler (EventKey (Char '1') Down _ _) MENU algo = (MENU_SOLO, algo)
menuEventHandler (EventKey (Char '2') Down _ _) MENU algo = (GAME, algo)
menuEventHandler (EventKey (Char 'a') Down _ _) MENU_SOLO _ = (GAME, ASTAR)
menuEventHandler (EventKey (Char 'b') Down _ _) MENU_SOLO _ = (GAME, BFS)
menuEventHandler (EventKey (Char 'd') Down _ _) MENU_SOLO _ = (GAME, DFS)
menuEventHandler (EventKey (Char 'k') Down _ _) MENU_SOLO _ = (GAME, DJK)
menuEventHandler _ s a = (s, a)