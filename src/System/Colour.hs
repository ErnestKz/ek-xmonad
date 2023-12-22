module System.Colour where

import Colour.Zenburn

statusBarBgColor :: String
statusBarBgColor = zenburnBgM1
statusBarFgColor :: String
statusBarFgColor = zenburnGreen

statusBarSensorNormal :: String
statusBarSensorNormal = zenburnGreenP5
statusBarSensorAboveNormal :: String
statusBarSensorAboveNormal = zenburnYellowM1
statusBarSensorHigh :: String
statusBarSensorHigh = zenburnRed

statusBarWinTitleColor :: String
statusBarWinTitleColor = zenburnBlueP1
statusBarActiveWinStatusColor :: String
statusBarActiveWinStatusColor = zenburnYellowM1
