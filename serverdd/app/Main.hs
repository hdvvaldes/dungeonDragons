module Main where

import Server.App

main :: IO()
main = do 
  run defaultConfig   
