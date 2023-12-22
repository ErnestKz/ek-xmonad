module System.Hooks where

import XMonad.Core ( ManageHook )
import XMonad.ManageHook ( (<+>), (=?), (-->) )
import XMonad.ManageHook qualified as XMonad
import XMonad.Hooks.Place qualified as XMonad

xMonadManageHook :: ManageHook
xMonadManageHook = 
  XMonad.placeHook (XMonad.withGaps (16, 0, 16, 0)
                    (XMonad.smart (0.5, 0.5)))
  <+> XMonad.composeAll
  [ XMonad.title =? "pyui" --> XMonad.doFloat
  , XMonad.title =? "cg"   --> XMonad.doFloat

  , XMonad.className =? "MPlayer"           --> XMonad.doFloat
  , XMonad.className =? "Thunar"            --> XMonad.doFloat
  , XMonad.className =? "Gimp"              --> XMonad.doFloat
  , XMonad.className =? "feh"               --> XMonad.doFloat
  , XMonad.className =? "Computer Graphics" --> XMonad.doFloat
  , XMonad.className =? "OpenGL"            --> XMonad.doFloat
  , XMonad.className =? "Emacs"             --> XMonad.doFloat
    
  , XMonad.resource =? "desktop_window" --> XMonad.doIgnore
  , XMonad.resource =? "kdesktop"       --> XMonad.doIgnore

  , XMonad.appName =? "pavucontrol" --> XMonad.doFloat
  ]
