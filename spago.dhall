{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "test-ps"
, dependencies =
  [ "arrays"
  , "canvas"
  , "console"
  , "effect"
  , "foldable-traversable"
  , "math"
  , "prelude"
  , "psci-support"
  , "random"
  , "web-html"
  ]
, packages = ./packages.dhall

, sources = [ "src/**/*.purs", "test/**/*.purs" ]

}
