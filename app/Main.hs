module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.Random

import Startup
import Game
import Types
import Menu

window :: Display
window = InWindow title (iwidth, iheight) (0, 0)
    where
        iwidth  = round Startup.width
        iheight = round Startup.height


main :: IO ()
main = do
    assets <- Startup.loadAssets
    let coinSeed = mkStdGen 777
    let game = Startup.loadGame assets MENU SOLO DFS
    -- let game = (cellSize, width, height, Map.mapaAtual, assets, player, (1,-1), ((13, -11), coinSeed), 0) :: Game

    play
        window
        Startup.background
        Startup.fps
        game
        drawingFunc
        inputHandler
        updateFunc


drawingFunc :: Game -> Picture
drawingFunc (cellSize, width, mapa, assets, player, ghosts, GAME)  = translate Startup.startX Startup.startY (drawGame (cellSize, width, mapa, assets, player, ghosts, GAME))
drawingFunc (cellSize, width, mapa, assets, player, ghosts, state) = drawMenu width title state

updateFunc :: Float -> Game -> Game
updateFunc dt (cellSize, width, mapa, assets, player, ghosts, GAME) = Game.updateGame dt (cellSize, width, mapa, assets, player, ghosts, GAME) 
updateFunc dt game = game

inputHandler :: Event -> Game -> Game
inputHandler event (cellSize, width, mapa, assets, player, ghosts, GAME) = gameInputHandler event (cellSize, width, mapa, assets, player, ghosts, GAME)
inputHandler event (cellSize, width, mapa, assets, player, ghosts, state) = menuInputHandler event (cellSize, width, mapa, assets, player, ghosts, state)

