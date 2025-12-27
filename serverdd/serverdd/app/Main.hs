module Main where

import Server.App

main :: IO()
main = do 
  let config = defaultConfig
  run defaultConfig
