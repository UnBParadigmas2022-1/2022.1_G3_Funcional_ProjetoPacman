module Main where

import Graphics.Gloss
    ( Picture, translate, play, Display(InWindow) )
import Graphics.Gloss.Interface.Pure.Game ( Event )
import System.Random ( mkStdGen )

import Game.Startup ( 
    width, 
    height, 
    loadAssets, 
    loadGame, 
    background, 
    fps, 
    startY, 
    startX,
    title)
import Game.Game ( updateGame, drawGame, gameInputHandler )
import Types
    ( Algorithm(DFS), Game, GameMode(SOLO), State(END, MENU, GAME) )
import Screens.Menu ( drawMenu, menuInputHandler )
import Screens.End ( drawEnd, endInputHandler )

window :: Display
window = InWindow title (iwidth, iheight) (0, 0)
    where
        iwidth  = round width
        iheight = round height


main :: IO ()
main = do
    assets <- loadAssets
    let coinSeed = mkStdGen 777
    let game = loadGame assets MENU SOLO DFS coinSeed

    play
        window
        background
        fps
        game
        drawingFunc
        inputHandler
        updateFunc


drawingFunc :: Game -> Picture
drawingFunc (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) =
    translate startX startY (drawGame (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME))
drawingFunc (cellSize, width, height, mapa, assets, player, ghosts, coin, score, END) = drawEnd width score
drawingFunc (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = drawMenu width title state


updateFunc :: Float -> Game -> Game
updateFunc dt (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) =
    updateGame dt (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) 
updateFunc dt game = game


inputHandler :: Event -> Game -> Game
inputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME) =
    gameInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, GAME)
inputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, END) =
    endInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, END)
inputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) =
    menuInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state)
