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

type Game = (CellSize, Width, Mapa, Assets, Player, Ghost)
