module FrontEnd where

import Standards
import Window
import Keyboard
import Text
import Char

display : Standards.StandardsState -> Element

display standardsState =
  let pongGreen               = rgb 60 100 60
      displayStandard message = group [ filled pongGreen (rect 200 50)
                                      , toForm message
                                      ]
      positionFor n           = move (0, 60*n)
      displayStandards ss n   = if | isEmpty ss -> []
                                   | otherwise  -> (positionFor n <| displayStandard <| head ss) :: (displayStandards (tail ss) (n+1))
      strings                 = map plainText (.standards standardsState)
  in  collage 500 500 <| [move (0, -60 * 3) (group <| displayStandards strings 0)]

defaultStandardsState =
  let defaultStandards = ["omg1", "omg2", "omg3", "omg4"]
  in  lift (Standards.StandardsState defaultStandards 0) Keyboard.lastPressed

main = lift display defaultStandardsState
