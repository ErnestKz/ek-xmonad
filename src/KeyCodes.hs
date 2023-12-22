module KeyCodes
  ( button1 , button2 , button3
  
  , shiftMask , mod4Mask

  , xK_Return
  , xK_comma
  , xK_semicolon
  , xK_space 
  
  , xK_a , xK_b , xK_c , xK_d
  , xK_e , xK_f , xK_g , xK_h
  , xK_i , xK_j , xK_k , xK_l
  , xK_m , xK_n , xK_o , xK_p
  , xK_q , xK_r , xK_s , xK_t
  , xK_u , xK_v , xK_w , xK_x
  , xK_y , xK_z
  
  , xK_0 , xK_1
  , xK_2 , xK_3
  , xK_4 , xK_5
  , xK_6 , xK_7
  , xK_8 , xK_9

  , xF86XK_ModeLock
  , xF86XK_MonBrightnessUp
  , xF86XK_MonBrightnessDown
  , xF86XK_KbdLightOnOff
  , xF86XK_KbdBrightnessUp
  , xF86XK_KbdBrightnessDown
  , xF86XK_Standby
  , xF86XK_AudioLowerVolume
  , xF86XK_AudioMute
  , xF86XK_AudioRaiseVolume

  , xF86XK_Favorites
  , xF86XK_Display
  , xF86XK_Phone
  , xF86XK_WLAN
  , xF86XK_AudioMicMute
  , xF86XK_AudioMicMute'
  )
where

import XMonad
import Graphics.X11.ExtraTypes.XF86

xF86XK_AudioMicMute' :: KeySym
xF86XK_AudioMicMute' = 0x1008ffb2

