module Types where

import Graphics.Gloss
import Data.List


type CellSize = Float
type Width    = Float

type Cell = Float
type Mapa = [Cell]

type Assets = [Picture]

type Game = (CellSize, Width, Mapa, Assets)
