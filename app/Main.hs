module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Game

title  = "Pacman"

fps = 5

width       = 800       :: Float
height      = 600       :: Float
cellSize    = 20        :: Float

startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0


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
    Game.game
    drawingFunc
    Game.inputHandler
    Game.updateGame


drawingFunc :: Game -> Picture
drawingFunc game = translate startX startY (Game.drawGame game)
