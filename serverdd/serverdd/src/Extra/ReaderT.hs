{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Extra.ReaderT(
  ReaderT,
  runReaderT,
  ask,
  lift
) where 
import Control.Monad.Reader.Class(MonadReader, ask, local)
import Control.Monad.Trans.Class(MonadTrans, lift)
import Control.Monad.IO.Class(MonadIO, liftIO)

newtype ReaderT e m a =  
  ReaderT {runReaderT :: e -> m a}
instance Functor m => Functor (ReaderT e m) 
  where 
    fmap f (ReaderT res) = 
      ReaderT $ \env -> fmap f (res env)
instance Applicative m => Applicative (ReaderT e m)
  where 
    pure a = ReaderT $ \_ -> pure a 
    ReaderT f <*> ReaderT a = ReaderT $ \env -> 
      f env <*> a env
instance Monad m => Monad (ReaderT e m)
  where 
  -- funcA : e -> m a
  -- t: a -> (e -> m b)
  -- return. ReaderT e -> m b
  ReaderT funcA >>= t = 
    ReaderT $ \env ->
      let fstRes = funcA env
      in fstRes >>= \x -> runReaderT (t x) env
instance Monad m => MonadReader e (ReaderT e m)
  where 
    ask = ReaderT return
    local modE (ReaderT res1) = ReaderT $ res1 . modE
instance MonadTrans (ReaderT a)
  where 
      lift res = ReaderT $ const res
instance MonadIO (ReaderT e IO)
  where 
    liftIO = lift

