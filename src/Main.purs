module Main where

import Prelude

import Data.Array ((..))
import Data.Foldable (fold)
import Data.Maybe (Maybe(..))
import Data.Traversable (for, traverse)
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (random)
import Graphics.Canvas (Context2D, arc, beginPath, fillRect, getCanvasElementById, getContext2D, setFillStyle, stroke)
import Math as Math

main :: Effect Unit
main = do
  log "Hello sailor!"
  maybeCanvas <- getCanvasElementById "paintme"
  maybeCtx <- traverse getContext2D maybeCanvas
  case maybeCtx of
    Nothing -> do
      log "Canvas not found!"
    Just ctx -> do
      beginPath ctx
      Path draw <- randomPath 25
      _ <- draw ctx {x: 250.0, y: 250.0}
      pure unit
  log "Done!"

type Position = { x :: Number, y :: Number}
data Path = Path (Context2D -> Position -> Effect Position)
type RelArc = {start :: Number, end :: Number, radius :: Number}

randomPath :: Int -> Effect Path
randomPath n = do
               ps <- for (1..n) (\_ -> arcPath <$> randomRelArc)
               pure (fold ps)

randomAngle :: Effect Number
randomAngle = pure (Math.tau*_) <*> random


randomRadius :: Effect Number
randomRadius = pure (50.0*_) <*> random

randomPosition :: Effect Number
randomPosition = pure (600.0*_) <*> random

randomRelArc :: Effect RelArc
randomRelArc = do
  start <- randomAngle
  end <- randomAngle
  radius <- randomRadius
  pure {
    start: start,
    end: end,
    radius: radius}


markPosition :: Context2D -> String -> Position -> Effect Unit
markPosition ctx color p = do
  beginPath ctx
  setFillStyle ctx color
  fillRect ctx {x: p.x-2.5, y: p.y-2.5, width: 5.0, height: 5.0}

arcPath :: RelArc -> Path
arcPath ra = Path (\ctx start -> do
          let dx = (Math.cos ra.start) * ra.radius
              dy = (Math.sin ra.start) * ra.radius
              x = start.x - dx
              y = start.y - dy
              end = {
                x: x + (Math.cos ra.end)*ra.radius,
                y: y + (Math.sin ra.end)*ra.radius
                }
          beginPath ctx
          markPosition ctx "blue" {x: x, y: y}
          markPosition ctx "red" start
          markPosition ctx "green" end
          arc ctx {
                x: x,
                y: y,
                start: ra.start,
                end: ra.end,
                radius: ra.radius}
          stroke ctx
          pure end
      )

appendPaths :: Path -> Path -> Path
appendPaths (Path drawPathL) (Path drawPathR) = Path (
  \ctx start -> do
    endL <- drawPathL ctx start
    endR <- drawPathR ctx endL
    pure endR
  )

instance pathSemigroup :: Semigroup Path where
  append = appendPaths

instance pathMonoid :: Monoid Path where
  mempty = Path \ctx start -> pure start
