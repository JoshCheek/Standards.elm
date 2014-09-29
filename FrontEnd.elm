module FrontEnd where

import Standards
import Window
import Keyboard
import Text
import Char

-- Named Values
standardsBG    = rgb 60 100 60
standardWidth  = 200
standardHeight = 50
standardOffset = 10

-- views
standardView message =
  group [ filled standardsBG (rect standardWidth standardHeight)
        , toForm <| plainText message
        ]

display : Standards.State -> Element
display state =
  let totalStandardHeight         = standardHeight+standardOffset
      positionFor n               = move (0, totalStandardHeight*n)
      positionStandards index svs = if | isEmpty svs -> []
                                       | otherwise   -> (positionFor index (head svs)) :: (positionStandards (index+1) (tail svs))
      standardViews               = map standardView state.standards
      standardGroup               = group <| positionStandards 0 standardViews
      currentAtCenter             = -totalStandardHeight * state.currentIndex
  in  collage 500 500 [move (0, currentAtCenter) standardGroup]

-- Run
main =
  let defaultStandards      = ["omg1", "omg2", "omg3", "omg4"]
      currentIndex          = 0
      defaultStandardsState = lift (Standards.State defaultStandards currentIndex) Keyboard.lastPressed
  in  lift display defaultStandardsState
