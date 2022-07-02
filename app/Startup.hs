module Startup where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map

title = "Pacman"

fps = 5 :: Int

cellSize    = 25                        :: CellSize
width       = Map.mapaWidth*cellSize    :: Width
height      = Map.mapaHeight*cellSize   :: Float
background  = black                     :: Color

player      = ((13, 17), (1, 0))        :: Player
ghost       = (1, -1, BFS)              :: Ghost


startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0

assetsName = ["wall", "gold", "diamond", "nether", "player", "orange-ghost"]


loadGame :: Assets -> State -> GameMode -> Algorithm -> Game
loadGame assets state HARD _ = (cellSize, width, Map.mapaAtual, assets, player, ghost, state)
loadGame assets state SOLO algo  = (cellSize, width, Map.mapaAtual, assets, player, newGhost, state)
    where
        (gx, gy, _) = ghost
        newGhost = (gx, gy, algo)


loadAssets :: IO [Picture]
loadAssets = mapM load assetsName
    where
        load image = loadBMP ("assets/" ++ image ++ ".bmp")
