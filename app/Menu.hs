module Menu where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Startup


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
    newGame
    where
        (newState, newAlgo, gameMode) = menuEventHandler event state
        newGame = Startup.loadGame assets newState gameMode
         

menuEventHandler :: Event -> State -> (State, Algorithm, GameMode)
menuEventHandler (EventKey (Char '1') Down _ _) MENU = (MENU_SOLO, BFS, SOLO)
menuEventHandler (EventKey (Char '2') Down _ _) MENU = (GAME, BFS, HARD)
menuEventHandler (EventKey (Char 'a') Down _ _) MENU_SOLO = (GAME, ASTAR, SOLO)
menuEventHandler (EventKey (Char 'b') Down _ _) MENU_SOLO = (GAME, BFS, SOLO)
menuEventHandler (EventKey (Char 'd') Down _ _) MENU_SOLO = (GAME, DFS, SOLO)
menuEventHandler (EventKey (Char 'k') Down _ _) MENU_SOLO = (GAME, DJK, SOLO)
menuEventHandler _ s = (s, BFS, SOLO)