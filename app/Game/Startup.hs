module Game.Startup where

import Graphics.Gloss ( Picture, black, loadBMP, Color )
import Graphics.Gloss.Interface.Pure.Game ()

import Types
    ( Algorithm(DJK, ASTAR, BFS),
      Assets,
      CellSize,
      Coins,
      Game,
      GameMode(..),
      Ghost,
      Ghosts,
      Player,
      State,
      Width,
      Score )
import Game.Map ( mapaHeight, mapaWidth, mapaAtual )
import System.Random ( StdGen, mkStdGen )

title :: [Char]
title = "Pacman"

fps :: Int
fps = 5 :: Int

cellSize :: CellSize
cellSize    = 25                        :: CellSize

width :: Width
width       = mapaWidth*cellSize    :: Width

height :: Float
height      = mapaHeight*cellSize   :: Float

background :: Color
background  = black                     :: Color

player :: Player
player      = ((13, 17), (1, 0), 0)     :: Player

ghost :: Ghost
ghost       = (1, -1, -1, ASTAR)        :: Ghost

ghosts :: Ghosts
ghosts      = [(1, -1, -1, ASTAR), (26, -1, -1, BFS), (26, -29, -1, DJK)] :: Ghosts

coins :: Coins
coins       = [
                ((13, -11), mkStdGen 777), 
                ((21, -25), mkStdGen 888), 
                ((12, -25), mkStdGen 555),
                ((7, -6), mkStdGen 444),
                ((6, -26), mkStdGen 222),
                ((23, -5), mkStdGen 111)] :: Coins

score :: Score
score       = 0



startX :: CellSize
startX = (cellSize - width)  / 2.0

startY :: Float
startY = (height - cellSize) / 2.0

assetsName :: [[Char]]
assetsName = ["wall", "gold", "diamond", "nether", "player", "orange-ghost", "coin", "pink-ghost", "blue-ghost"]


loadGame :: Assets -> State -> GameMode -> Algorithm -> StdGen -> Game
loadGame assets state HARD _ coinSeed = 
    (cellSize, width, height, mapaAtual, assets, player, ghosts, coins, score, state)
loadGame assets state SOLO algo coinSeed = 
    (cellSize, width, height, mapaAtual, assets, player, [newGhost], coins, score, state)
    where
        (gx, gy, s, _) = ghost
        newGhost = (gx, gy, s, algo)


loadAssets :: IO [Picture]
loadAssets = mapM load assetsName
    where
        load image = loadBMP ("assets/" ++ image ++ ".bmp")
