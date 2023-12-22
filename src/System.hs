module System where

import System.XMobar qualified as System
import System.XMonad qualified as System

import Xmobar qualified as XMobar
import XMonad qualified
import XMonad.Util.Replace qualified as XMonad

import Control.Monad qualified as Monad

import Control.Concurrent.MVar qualified as MVar
import Control.Concurrent      qualified as Concurrent

xMobarRun :: IO ()
xMobarRun = XMobar.xmobar System.xMobarConfig

xMonadRun :: IO () -> IO ()
xMonadRun shutdownHandle = do
  directories <- XMonad.getDirectories 
  XMonad.replace >> XMonad.launch (System.xMonadConfig shutdownHandle) directories

systemRestart :: XMonad.X ()
systemRestart = XMonad.writeStateToFile

withShutdownHandleForkIO :: (IO () -> IO ()) -> IO ()
withShutdownHandleForkIO program = do
  shutdownSignal <- MVar.newEmptyMVar @()
  let executeShutdown = MVar.putMVar shutdownSignal ()
  threadId <- Concurrent.forkIO $ Monad.void $ program executeShutdown
  MVar.takeMVar shutdownSignal >> Concurrent.killThread threadId

binaryPath :: String
binaryPath = "/home/ek/system-new/system-projects/system-xmonad/dist-newstyle/build/x86_64-linux/ghc-9.4.5/system-xmonad-0.1.0.0/x/system-xmonad-exe/build/system-xmonad-exe/system-xmonad-exe"
    
systemRun :: IO ()
systemRun = do
  withShutdownHandleForkIO $ \shutdownHandle -> do
    Monad.void $ Concurrent.forkIO xMobarRun
    Monad.void $ xMonadRun shutdownHandle
