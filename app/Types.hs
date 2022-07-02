module Types where

import Graphics.Gloss
import Data.List


type CellSize = Float
type Width    = Float
type MultValor = (Point, Point)

type Cell = Float
type Mapa = [Cell]
type Player = (Point, Point)
type Ghost = (Float, Float)

type Assets = [Picture]

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

type Game = (CellSize, Width, Mapa, Assets, Player, Ghost, State, Algorithm)
