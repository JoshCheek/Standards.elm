module FrontEnd where

import Standards
import Window
import Keyboard
import Text
import Char

-- Named Values
standardsBG    = rgb 60 100 60
standardWidth  = 200
standardHeight = 200

-- views
standardView message =
  group [ filled standardsBG (rect standardWidth standardHeight)
        , toForm <| plainText message
        ]

display : Standards.State -> Element
display state =
  let positionFor n           = move (0, 60*n)
      displayStandards svs n  = if | isEmpty svs -> []
                                   | otherwise   -> (positionFor n <| head svs) :: (displayStandards (tail svs) (n+1))
      standardViews           = map standardView state.standards
  in  collage 500 500 <| [move (0, -60 * 3) (group <| displayStandards standardViews 0)]

defaultStandardsState =
  let defaultStandards = ["omg1", "omg2", "omg3", "omg4"]
  in  lift (Standards.State defaultStandards 0) Keyboard.lastPressed

main = lift display defaultStandardsState
