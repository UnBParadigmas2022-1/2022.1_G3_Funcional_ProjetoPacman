module Types where

import Graphics.Gloss
import Data.List


type CellSize = Float
type Width    = Float
type Height   = Float

type Cell = Float
type Mapa = [Cell]

type Assets = [Picture]

type Ghost = (Float, Float)
type Coin = Point
type Score = Int

type Game = (CellSize, Width, Height, Mapa, Assets, Ghost, Score)
