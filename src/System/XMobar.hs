module System.XMobar where

import Xmobar qualified as XMobar
import XMonad.Hooks.DynamicLog   qualified as XMonad

import System.Colour qualified as System

xMonadStatusBarConfig :: XMonad.PP
xMonadStatusBarConfig = XMonad.def
  { XMonad.ppCurrent = XMonad.xmobarColor System.statusBarActiveWinStatusColor "" . XMonad.wrap "[" "]"
  , XMonad.ppTitle   = XMonad.xmobarColor System.statusBarWinTitleColor ""        . XMonad.shorten 40
  , XMonad.ppVisible = XMonad.wrap "(" ")"
  , XMonad.ppUrgent  = XMonad.xmobarColor System.statusBarSensorHigh System.statusBarSensorAboveNormal
  }
  
xMobarConfig :: XMobar.Config
xMobarConfig = XMobar.defaultConfig
  { XMobar.borderWidth = 1
  , XMobar.border      = XMobar.BottomB
  , XMobar.borderColor = "black"
  , XMobar.bgColor     = System.statusBarBgColor
  , XMobar.fgColor     = System.statusBarFgColor
  , XMobar.alpha       = 255
  , XMobar.position    = XMobar.TopH 27
  
  , XMobar.font             = "xft:mononoki-13"
  , XMobar.additionalFonts  = []
  , XMobar.textOutputFormat = XMobar.Ansi
  , XMobar.textOffset       = -1
  , XMobar.iconOffset       = -1
  
  , XMobar.lowerOnStart = True
  , XMobar.pickBroadest = False
  , XMobar.persistent   = False
  , XMobar.hideOnStart  = False
  
  , XMobar.iconRoot         = "."
  , XMobar.allDesktops      = True
  , XMobar.overrideRedirect = True
  , XMobar.sepChar          = "%"
  , XMobar.alignSep         = "}{"
  , XMobar.template         = "%XMonadLog% }{ %cpu% | %memory% * %swap% | %date% "
  , XMobar.commands =
      [ XMobar.Run XMobar.XMonadLog,
        
        XMobar.Run $ XMobar.Cpu
        [ "-L", "3", "-H", "50"
        , "--normal",  System.statusBarSensorNormal
        , "--high", System.statusBarSensorHigh
        ] 10
        
      , XMobar.Run $ XMobar.Memory [ "-t", "Mem: <usedratio>%" ] 10
        
      , XMobar.Run $ XMobar.Swap [] 10
      , XMobar.Run $ XMobar.Date "%a %b %_d %Y %H:%M:%S" "date" 10
      ]
  }
