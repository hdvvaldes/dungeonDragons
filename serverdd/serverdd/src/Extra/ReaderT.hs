module Extra.ReaderT(
  ReaderT,
  runReaderT,
  ask,
  asks, 
  lift
) where 

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

-- Return Enviroment
ask :: Monad m => ReaderT e m e
ask = ReaderT return

asks :: Monad m => (e -> a) -> ReaderT e m a
asks f = fmap f ask

lift :: Monad m => m a -> ReaderT e m a
lift m = ReaderT $ const m 

