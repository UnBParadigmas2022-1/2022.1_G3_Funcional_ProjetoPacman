module Types where

import Graphics.Gloss
import Data.List


type CellSize = Float
type Width    = Float

type Cell = Float
type Mapa = [Cell]

type Assets = [Picture]

type Coin = Point

type Score = Int

type Game = (CellSize, Width, Height, Mapa, Assets, Score)
type Height   = Float
