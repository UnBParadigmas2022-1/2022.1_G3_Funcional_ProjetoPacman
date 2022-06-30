module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Game
import Types
import Map
import Menu

title  = "Pacman"

fps = 5

cellSize    = 25                     :: CellSize
width       = mapaWidth*cellSize     :: Width
height      = mapaHeight*cellSize    :: Float

startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0

assetsName = ["wall", "gold", "diamond", "nether"]


window :: Display
window = (InWindow title (iwidth, iheight) (0, 0))
    where
        iwidth  = round width
        iheight = round height


main :: IO ()
main = do
    assets <- loadAssets
    let game = (cellSize, width, Map.mapaAtual, assets, MENU, BFS) :: Game

    play
        window
        black
        fps
        game
        drawingFunc
        inputHandler
        Game.updateGame


drawingFunc :: Game -> Picture
drawingFunc (cellSize, width, mapa, assets, MENU, algo) = drawMenu width title
drawingFunc (cellSize, width, mapa, assets, GAME, algo)  = translate startX startY (drawGame (cellSize, width, mapa, assets, GAME, algo))


loadAssets :: IO [Picture]
loadAssets = mapM load assetsName
    where
        load image = loadBMP ("assets/" ++ image ++ ".bmp")


inputHandler :: Event -> Game -> Game
inputHandler event (cellSize, width, mapa, assets, MENU, algo) = menuInputHandler event (cellSize, width, mapa, assets, MENU, algo)
inputHandler event (cellSize, width, mapa, assets, GAME, algo) = gameInputHandler event (cellSize, width, mapa, assets, GAME, algo)
