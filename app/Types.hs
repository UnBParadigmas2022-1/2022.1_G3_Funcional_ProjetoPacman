module Types where

import Graphics.Gloss
import Data.List


type CellSize = Float
type Width    = Float

type Cell = Float
type Mapa = [Cell]

type Slow = Float
type Ghost = (Float, Float, Float)

type Assets = [Picture]

type Game = (CellSize, Width, Mapa, Assets, Ghost)
