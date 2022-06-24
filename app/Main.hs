module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Game
import Types
import Map

title  = "Pacman"

fps = 5

cellSize    = 25                    :: CellSize
width       = mapWidth*cellSize     :: Width
height      = mapHeight*cellSize    :: Float

startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0


game :: Game
game = (cellSize, width, Map.mapaAtual)


window :: Display
window = (InWindow title (iwidth, iheight) (0, 0))
    where
        iwidth  = round width
        iheight = round height


main :: IO ()
main = play
    window
    white
    fps
    game
    drawingFunc
    Game.inputHandler
    Game.updateGame


drawingFunc :: Game -> Picture
drawingFunc game = translate startX startY (Game.drawGame game)
