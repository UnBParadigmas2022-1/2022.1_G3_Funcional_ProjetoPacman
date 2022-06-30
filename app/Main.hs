module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Game
import Types
import Map

title  = "Pacman"

fps = 5

cellSize    = 25                            :: CellSize
width       = mapaWidth*cellSize            :: Width
height      = (mapaHeight + 2)*cellSize     :: Height

startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0

background = black

game :: Game
game = (cellSize, width, height, Map.mapaAtual, 0)


window :: Display
window = (InWindow title (iwidth, iheight) (0, 0))
    where
        iwidth  = round width
        iheight = round height


main :: IO ()
main = do
    assets <- loadAssets
    let game = (cellSize, width, Map.mapaAtual, assets, (0, 0)) :: Game

    play
        window
        white
        fps
        game
        drawingFunc
        Game.inputHandler
        Game.updateGame


drawingFunc :: Game -> Picture
drawingFunc game = translate startX startY (Game.drawGame game)


loadAssets :: IO [Picture]
loadAssets = mapM load assetsName
    where
        load image = loadBMP ("assets/" ++ image ++ ".bmp")
