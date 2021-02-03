import Xmobar

config :: Config
config
  = defaultConfig
  { font              = "xft:FiraCode Nerd Font-8,monospace-14"
  , additionalFonts   = ["xft:FiraCode Nerd Font-8:style=Bold,monospace-14"]
  , overrideRedirect  = True
  , bgColor           = "#191919"
  , fgColor           = "#bdc3c7"
  , alpha             = 255
  , position          = Bottom
  , textOffset        = -1
  , iconOffset        = -1
  , lowerOnStart      = True
  , pickBroadest      = False
  , persistent        = False
  , hideOnStart       = False
  , iconRoot          = "."
  , allDesktops       = True
  , sepChar           = "%"
  , alignSep          = "}{"
  , template          = "\
                        \%UnsafeStdinReader%\
                        \}\

                        \<fc=white>%date%</fc>\

                        \{\
                        \<fc=white,#292929>\
                        \<action=`xdotool key super+ctrl+n` button=1>\
                        \<box type=Bottom width=2 color=white>\
                        \ %dynnetwork% \
                        \</box></action></fc>\
                        \ \

                        \<fc=white,#292929><action=`notify_max_cpu` button=1>\
                        \<box type=Bottom width=2 color=#787878> %cpu% </box>\
                        \</action></fc>\
                        \ \

                        \<fc=white,#292929><action=`notify_max_mem` button=1>\
                        \<box type=Bottom width=2 color=#787878>\
                        \ %memory% \
                        \</box></action></fc>\
                        \ \
                        \<fc=white,#292929>\
                        \<action=`pactl set-sink-mute @DEFAULT_SINK@ toggle` button=1>\
                        \<box type=Bottom width=2 color=#787878>\
                        \ %sound% \
                        \</box></action></fc>\
                        \ \

                        \<fn=1><fc=#000000,#9b59b6>\
                        \<action=`notify_tmux_ls` button=1>\
                        \ \xf120 %tmuxls% \
                        \</action></fc></fn>\
                        \ \

                        \<fc=white,#292929>\
                        \<box type=Bottom width=2 color=#4cd137>\
                        \ %battery% \
                        \</box></fc>"
  , commands          = [
      -- network activity monitor (dynamic interface resolution)
      Run $ DynNetwork  [ "--template" , "<dev>: \xf063 <rx>kb/s \xf062 <tx>kb/s"
                      , "--Low"      , "1000"
                      , "--High"     , "5000"
                      , "--low"      , "#4cd137,#292929"
                      , "--normal"   , "#ffdd59,#292929"
                      , "--high"     , "#cc6666,#292929"
                      ] 10

    -- cpu activity monitor
    , Run $ Cpu         [ "--template" , "\xf108  <total>%"
                      , "--Low"      , "25"
                      , "--High"     , "65"
                      , "--low"      , "#4cd137,#292929"
                      , "--normal"   , "#ffdd59,#292929"
                      , "--high"     , "#cc6666,#292929"
                      ] 10

    -- memory usage monitor
    , Run $ Memory      [ "--template" ,"\xf233  <usedratio>%"
                      , "--Low"      , "25"
                      , "--High"     , "65"
                      , "--low"      , "#4cd137,#292929"
                      , "--normal"   , "#ffdd59,#292929"
                      , "--high"     , "#cc6666,#292929"
                      ] 10

    -- battery monitor
    , Run $ Battery     [ "--template" , "<acstatus>"
                      , "--Low"      , "22"
                      , "--High"     , "80"
                      , "--low"      , "#cc6666,#292929"
                      , "--normal"   , "#ffdd59,#292929"
                      , "--high"     , "#4cd137,#292929"
                      , "--"
                      , "-o", "<left>% <fc=#ffdd59,#292929>(<timeleft>)</fc>"
                      , "-O", "<left>% <fc=#ffdd59,#292929>\xf0e7</fc>"
                      , "-i", "<left>% <fc=#4cd137,#292929>\xf0e7</fc>"
                      ] 10
    , Run $ Date        "\xf073  %a, %b %d %H:%M" "date" 600
    , Run $ Com         "sh" ["/home/lycuid/.config/xmobar/scripts/tmuxls.sh"] "tmuxls" 10
    , Run $ Com         "sh" ["/home/lycuid/.config/xmobar/scripts/sound.sh"] "sound" 1
    , Run $ UnsafeStdinReader
  ]
}

main :: IO ()
main = xmobar config
