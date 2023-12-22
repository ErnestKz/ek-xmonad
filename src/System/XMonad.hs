module System.XMonad where

import XMonad ( XConfig )
import XMonad qualified

import XMonad.Layout ( Choose, Full, Mirror, Tall )
import XMonad.Layout.LayoutModifier ( ModifiedLayout )

import XMonad.Hooks.ManageDocks ( AvoidStruts )
import XMonad.Hooks.ManageDocks  qualified as XMonad

import XMonad.Hooks.EwmhDesktops qualified as XMonad
import XMonad.Hooks.StatusBar    qualified as XMonad

import KeyCodes qualified as X11

import System.Bindings qualified as System
import System.Hooks    qualified as System
import System.XMobar   qualified as System

type AvoidStruts' l = ModifiedLayout AvoidStruts l
type SystemLayout = (Choose Tall (Choose (Mirror Tall) Full))

xMonadConfig
  :: IO ()
  -> XConfig (AvoidStruts' SystemLayout)
xMonadConfig shutdownHandle
  = XMonad.ewmhFullscreen
  $ XMonad.withSB (XMonad.statusBarProp "xmobar" $ pure System.xMonadStatusBarConfig)
  $ XMonad.ewmh
  $ XMonad.docks
  $ XMonad.def
  { XMonad.terminal = "urxvt"
  
  , XMonad.focusFollowsMouse = True
  , XMonad.clickJustFocuses  = False
  
  , XMonad.borderWidth = 0
  , XMonad.workspaces  = fmap show ([1 .. 9] :: [Int])
  
  , XMonad.modMask       = X11.mod4Mask
  , XMonad.keys          = System.xMonadKeyBindings shutdownHandle
  , XMonad.mouseBindings = System.xMonadMouseBindings

  -- Actions to run when a new window is opened.
  , XMonad.manageHook    = System.xMonadManageHook

  -- Available layouts.
  , XMonad.layoutHook = XMonad.avoidStruts $ XMonad.layoutHook XMonad.def
  }
