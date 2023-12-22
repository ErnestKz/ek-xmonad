module System.Bindings where

import XMonad ( XConfig, X )
import XMonad qualified

import XMonad.StackSet        qualified as XMonad hiding (focus)
import XMonad.Actions.CycleWS qualified as XMonad

import KeyCodes qualified as X11

import Data.Map (Map)
import Data.Map qualified as Map

import Data.Bits ((.|.))

import System.Exit qualified as IO 


xMonadKeyBindings
  :: IO ()
  -> XConfig layout
  -> Map (XMonad.KeyMask, XMonad.KeySym) (X ())
  
xMonadKeyBindings
  shutdownHandle 
  xMonadConfig@(XMonad.XConfig { XMonad.modMask = modMask }) =
  let unMasked = 0 in
  Map.fromList
    [ ((unMasked, X11.xF86XK_AudioMute) , XMonad.spawn "pamixer -t")
    , ((modMask, X11.xF86XK_AudioMute)  , XMonad.spawn "pavucontrol")
    
    , ((unMasked, X11.xF86XK_AudioLowerVolume), XMonad.spawn "pamixer -d 5")
    , ((unMasked, X11.xF86XK_AudioRaiseVolume), XMonad.spawn "pamixer -i 5")
    
    , ((unMasked, X11.xF86XK_AudioMicMute')
      , XMonad.spawn $
        "pamixer --source " <>
        "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source -t")
    
    , ((unMasked, X11.xF86XK_MonBrightnessDown) , XMonad.spawn "light -U 5")
    , ((unMasked, X11.xF86XK_MonBrightnessUp)   , XMonad.spawn "light -A 5")
    , ((unMasked, X11.xF86XK_Display)           , XMonad.spawn "")
    , ((unMasked, X11.xF86XK_WLAN)              , XMonad.spawn "")
    , ((unMasked, X11.xF86XK_Favorites)         , XMonad.spawn "")
    
    , ((modMask .|. X11.shiftMask, X11.xK_Return), XMonad.spawn $ XMonad.terminal xMonadConfig)
    
    , ((modMask, X11.xK_o)                   , XMonad.spawn "flameshot gui")
    , ((modMask, X11.xK_p)                   , XMonad.spawn "rofi -show run")
    , ((modMask .|. X11.shiftMask, X11.xK_p) , XMonad.spawn "rofi -show window")
    , ((modMask, X11.xK_semicolon)           , XMonad.spawn "minmacs")
    , ((modMask, X11.xK_8)                   , XMonad.spawn "chromium")
    
    , ((modMask .|. X11.shiftMask, X11.xK_c) , XMonad.kill)
    , ((modMask, X11.xK_r)                   , do
          XMonad.broadcastMessage XMonad.ReleaseResources
          display <- XMonad.asks XMonad.display
          XMonad.io $ XMonad.flush display
          XMonad.writeStateToFile
          XMonad.io $ shutdownHandle >> IO.exitSuccess)

    , ((modMask, X11.xK_space) , XMonad.sendMessage XMonad.NextLayout)
    , ((modMask, X11.xK_k)     , XMonad.windows XMonad.focusDown)
    , ((modMask, X11.xK_j)     , XMonad.windows XMonad.focusUp)
    , ((modMask, X11.xK_n)     , XMonad.nextScreen)
    
    , ((modMask, X11.xK_y)     , XMonad.windows XMonad.swapDown)
    , ((modMask, X11.xK_h)     , XMonad.sendMessage XMonad.Shrink)
    , ((modMask, X11.xK_l)     , XMonad.sendMessage XMonad.Expand)
    , ((modMask, X11.xK_t)     , XMonad.withFocused $ XMonad.windows . XMonad.sink)
    
    , ((modMask, X11.xK_m)     , XMonad.shiftToPrev >> XMonad.prevWS)
    , ((modMask, X11.xK_comma) , XMonad.shiftToNext >> XMonad.nextWS)
    
    , ((modMask, X11.xK_u)     , XMonad.prevWS)
    , ((modMask, X11.xK_i)     , XMonad.nextWS)
    ]

xMonadMouseBindings
  :: XConfig layout
  -> Map (XMonad.KeyMask, XMonad.Button) (XMonad.Window -> X ())
  
xMonadMouseBindings
  (XMonad.XConfig { XMonad.modMask = modMask }) =
  Map.fromList
  [ ( (modMask, X11.button1)
    , \xMonadWindow -> do
        XMonad.focus xMonadWindow
        XMonad.mouseMoveWindow xMonadWindow
        XMonad.windows XMonad.shiftMaster )
    
  , ( (modMask, X11.button3),
      \xMonadWindow -> do
        XMonad.focus xMonadWindow
        XMonad.mouseResizeWindow xMonadWindow
        XMonad.windows XMonad.shiftMaster
    )
  ]

