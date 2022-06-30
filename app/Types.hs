module Types where

import Graphics.Gloss


type CellSize = Float
type Width    = Float

type Cell = Float
type Mapa = [Cell]

type Assets = [Picture]

type Coin = Point

type Game = (CellSize, Width, Mapa, Assets, Coin)
type Height   = Float
