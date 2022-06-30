module Types where

import Graphics.Gloss


type CellSize = Float
type Width    = Float

type Cell = Float
type Mapa = [Cell]

type Assets = [Picture]

type Coin = Point

type Score = Int

type Game = (CellSize, Width, Height, Mapa, Assets, Coin, Score)
type Height   = Float
