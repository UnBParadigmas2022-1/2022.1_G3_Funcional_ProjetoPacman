module Types where

import Graphics.Gloss
import Data.List
import System.Random


data State =
      MENU
    | MENU_SOLO
    | GAME
    | END
    deriving(Enum, Ord, Eq)

data Algorithm =
      BFS
    | DFS
    | DJK
    | ASTAR
    deriving(Enum, Ord, Eq)

data GameMode =
     SOLO
    | HARD
    deriving(Enum, Ord, Eq)

  
type CellSize = Float
type Width    = Float
type Height   = Float
type MultValor = (Point, Point)

type Cell = Float
type Mapa = [Cell]

type Player = (Point, Point)

type Assets = [Picture]

type Ghost = (Float, Float, Float, Algorithm)
type Ghosts = [Ghost]
type Coin = (Point, StdGen)
type Score = Int

type Game = (CellSize, Width, Height, Mapa, Assets, Player, Ghosts, Coin, Score, State)
