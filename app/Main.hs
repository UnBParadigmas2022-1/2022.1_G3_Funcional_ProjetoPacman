module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Game
import Types
import Map

title  = "Pacman"

fps = 5

cellSize    = 25                     :: CellSize
width       = mapaWidth*cellSize     :: Width
height      = mapaHeight*cellSize    :: Float
player      = ((13, 17), (1, 0))     :: Player
ghost       = (1, -1, -1)            :: Ghost
ghosts      = [(1, -1, -1), (26, -1, -1)] :: Ghosts

startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0

assetsName = ["wall", "gold", "diamond", "nether", "player", "orange-ghost"]


window :: Display
window = (InWindow title (iwidth, iheight) (0, 0))
    where
        iwidth  = round width
        iheight = round height


main :: IO ()
main = do
    assets <- loadAssets
    let game = (cellSize, width, Map.mapaAtual, assets, player, ghosts) :: Game

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
