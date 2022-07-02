module Types where

import Graphics.Gloss
import Data.List
import System.Random


type CellSize = Float
type Width    = Float
type Height   = Float

type Cell = Float
type Mapa = [Cell]
type Player = (Point, Point)

type Assets = [Picture]

type Ghost = (Float, Float)
type Coin = (Point, StdGen)
type Score = Int

type Game = (CellSize, Width, Height, Mapa, Assets, Player, Ghost, Coin, Score)
