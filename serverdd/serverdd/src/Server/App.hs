{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE NamedFieldPuns#-}

module Server.App(
  App(..),
  Env(..),
  runApp,
  runServer,
  defaultSocket
) where

import Network.Socket
import Extra.ReaderT
import Control.Monad.Reader.Class(MonadReader, asks)
import Control.Monad.IO.Class(MonadIO, liftIO)
import Server.ConnectionHandler(runConn)

newtype App a = App
  {unApp :: ReaderT Env IO a} 
  deriving newtype 
    (Functor, 
    Applicative, 
    Monad,
    MonadReader Env,
    MonadIO
    )

-- Enviroment for the app --
data Env = Env {
  socketConfig :: SocketConfig
}

data SocketConfig = SocketConfig {
  socketFamily ::Family,
  socketType :: SocketType,
  socketProtoN :: ProtocolNumber,
  socketAddress :: SockAddr
}

runApp :: Env -> App a -> IO a
runApp e r = runReaderT (unApp r) e

defaultSocket :: SocketConfig 
defaultSocket = SocketConfig {
  socketFamily  = AF_INET, 
  socketType    = Stream,
  socketProtoN  = defaultProtocol,
  socketAddress = SockAddrInet port host
}
  where
    port = 8080
    host = tupleToHostAddress(127,0,0,1)

runServer :: App ()
runServer = do
  sock <- buildSocket
  startSocket sock
  mainLoop sock

------ Helper Function ------
buildSocket :: App Socket
buildSocket = do
  SocketConfig{
    socketFamily,
    socketType,
    socketProtoN} <- asks socketConfig
  liftIO $ socket socketFamily socketType socketProtoN


startSocket :: Socket -> App ()
startSocket sock = do 
  SocketConfig{socketAddress} <- asks socketConfig
  liftIO $ bind sock socketAddress
  let maxConn = 2
  liftIO $ listen sock maxConn

mainLoop :: Socket -> App()
mainLoop sock = do
  conn <- liftIO $ accept sock
  liftIO $ runConn conn
  liftIO $ putStrLn "connection found"
  mainLoop sock

