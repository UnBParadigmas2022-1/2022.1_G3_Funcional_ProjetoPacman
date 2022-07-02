module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.Random

import Startup
import Game
import Types
import Menu
import End

window :: Display
window = InWindow title (iwidth, iheight) (0, 0)
    where
        iwidth  = round Startup.width
        iheight = round Startup.height


main :: IO ()
main = do
    assets <- Startup.loadAssets
    let coinSeed = mkStdGen 777
    let game = Startup.loadGame assets MENU SOLO DFS coinSeed

    play
        window
        Startup.background
        Startup.fps
        game
        drawingFunc
        inputHandler
        updateFunc


drawingFunc :: Game -> Picture
drawingFunc (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) =
    translate Startup.startX Startup.startY (drawGame (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME))
drawingFunc (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = drawMenu width title state


updateFunc :: Float -> Game -> Game
updateFunc dt (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) =
    Game.updateGame dt (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) 
updateFunc dt game = game


inputHandler :: Event -> Game -> Game
inputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) =
    gameInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME)
inputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) =
    menuInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state)
