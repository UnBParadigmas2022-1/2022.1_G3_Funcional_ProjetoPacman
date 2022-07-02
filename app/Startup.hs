module Startup where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import System.Random (StdGen)

title = "Pacman"



fps = 5 :: Int

cellSize    = 25                        :: CellSize
width       = Map.mapaWidth*cellSize    :: Width
height      = Map.mapaHeight*cellSize   :: Float
background  = black                     :: Color

player      = ((13, 17), (1, 0))     :: Player
ghost       = (1, -1, -1, ASTAR)            :: Ghost
ghosts      = [(1, -1, -1, ASTAR), (26, -1, -1, BFS), (26, -29, -1, DJK)] :: Ghosts
coins       = (13, -11)
score       = 0



startX = (cellSize - width)  / 2.0
startY = (height - cellSize) / 2.0

assetsName = ["wall", "gold", "diamond", "nether", "player", "orange-ghost", "coin"]


loadGame :: Assets -> State -> GameMode -> Algorithm -> StdGen -> Game
loadGame assets state HARD _ coinSeed = (cellSize, width, height, Map.mapaAtual, assets, player, ghosts, (coins, coinSeed), score, state)
loadGame assets state SOLO algo coinSeed = (cellSize, width, height, Map.mapaAtual, assets, player, [newGhost], (coins, coinSeed), score, state)
    where
        (gx, gy, s, _) = ghost
        newGhost = (gx, gy, s, algo)


loadAssets :: IO [Picture]
loadAssets = mapM load assetsName
    where
        load image = loadBMP ("assets/" ++ image ++ ".bmp")
