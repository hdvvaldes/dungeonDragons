{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE NamedFieldPuns#-}

module Server.App(
  App(..),
  Env(..),
  runApp,
  runServer,
  dSocketConfig,
) where

import qualified Network.Socket as NS
import Extra.ReaderT

newtype App a = App
  {unApp :: ReaderT Env IO a} 
  deriving newtype 
    (Functor, Applicative, Monad);

data Env = Env {
  socketConfig :: SocketConfig,
  socketAddress :: NS.SockAddr
  }

data SocketConfig = SocketConfig {
  socketFamily ::NS.Family,
  socketType :: NS.SocketType,
  socketProtoN :: NS.ProtocolNumber,
  socketPort :: NS.PortNumber,
  socketHost :: NS.HostAddress
}

runApp :: Env -> App a -> IO a
runApp e r = runReaderT (unApp r) e

dSocketConfig :: SocketConfig 
dSocketConfig = SocketConfig {
  socketFamily = NS.AF_INET, 
  socketType   = NS.Stream,
  socketProtoN = NS.defaultProtocol,
  socketPort   = 8080,
  socketHost   = NS.tupleToHostAddress (127,0,0,1)
}

runServer :: App ()
runServer = do 
  SocketConfig{socketPort, socketHost} <- asks socketConfig
  let addr = NS.SockAddrInet socketPort socketHost
  sock <- buildSocket
  lift $ NS.bind sock addr 
  let maxConn = 2
    in lift $ NS.listen sock maxConn

------ Helper Functions ------
buildSocket :: App NS.Socket
buildSocket = do  
  SocketConfig{
    socketFamily, 
    socketType, 
    socketProtoN} <- asks socketConfig
  lift $ NS.socket socketFamily socketType socketProtoN
   



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

