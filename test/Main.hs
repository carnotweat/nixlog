{-# LANGUAGE TemplateHaskell #-}

module Main where

import Hedgehog
import Hedgehog.Main
import Blog

prop_test :: Property
prop_test = property $ do
  doBlog === "Blog"

main :: IO ()
main = defaultMain [checkParallel $$(discover)]
