module Types where

import Graphics.Gloss


type CellSize = Float
type Width    = Float

type Cell = Float
type Mapa = [Cell]

type Wall = Picture
type Assets = [Wall]

type Game = (CellSize, Width, Mapa, Assets)
