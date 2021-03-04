module Sections.Network where

import Xmobar

templateNetwork :: String
templateNetwork = "<fc=white>\
                  \<action=`xdotool key super+ctrl+n` button=1>\
                  \ %dynnetwork% \
                  \</action></fc>"

commandNetwork :: Runnable
commandNetwork = Run $ DynNetwork
  [ "--template" , "<dev>: \xf063 <rx>kb/s \xf062 <tx>kb/s"
  , "--Low"      , "1000"
  , "--High"     , "5000"
  , "--low"      , "#4cd137"
  , "--normal"   , "#ffdd59"
  , "--high"     , "#cc6666"
  ] 20