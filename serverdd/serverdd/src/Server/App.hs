{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}

module Server.App(
  App,
  run,
) where

import qualified Network.Socket as NS
import Extra.ReaderT

newtype Env = Env {socket :: NS.Socket}

newtype App a = App
  {unApp :: ReaderT Env IO a} 
  deriving newtype 
    (Functor, Applicative, Monad);
 
scktAddr :: NS.SockAddr
scktAddr = NS.SockAddrInet port host
          where
            port = 8080 :: NS.PortNumber
            host = NS.tupleToHostAddress (127,0,0,1)

run :: Env -> App a -> IO a
run e r = runReaderT (unApp r) e

defaultSocket :: App a
defaultSocket = do 
  let ipv4 = NS.AF_INET
      stype = NS.Stream
    in 
      NS.socket ipv4 stype NS.defaultProtocol



-- run :: IO()
-- run = do
--   sock <-
--   bind sock scktAddr
--   let maxConn = 2
--     in listen sock maxConn
-- 
-- 
-- mainLoop :: Socket -> IO()
-- mainLoop sock = do
--   conn <- accept sock
--   runConn conn
--   mainLoop sock

