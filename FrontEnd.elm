module FrontEnd where

import Standards (..)
import Window
import Keyboard
import Text
import Char (KeyCode)

-- Named Values
standardsBG isCurrent = if | isCurrent -> rgb 80 130 80
                           | otherwise -> rgb 40 60 40
standardWidth  = 200
standardHeight = 50
standardOffset = 10

-- views
standardView : Bool -> Standard -> Form
standardView isCurrent standard =
  group [ filled (standardsBG isCurrent) (rect standardWidth standardHeight)
        , toForm (plainText standard.standard)
        ]

display : State -> Element
display state =
  let totalStandardHeight         = standardHeight+standardOffset
      positionFor n               = move (0, totalStandardHeight*n)
      positionStandards index svs = if | isEmpty svs -> []
                                       | otherwise   -> (positionFor index (head svs)) :: (positionStandards (index+1) (tail svs))
      standardViews               = indexedMap (\i s -> standardView (i==state.currentIndex) s) state.standards
      standardGroup               = group <| positionStandards 0 standardViews
      currentAtCenter             = -totalStandardHeight * state.currentIndex
  in  collage 500 500 [move (0, (toFloat currentAtCenter)) standardGroup]

-- Run
applyKey keyCode state =
  let upKey   = 38
      downKey = 40
  in if | keyCode == upKey   -> {state | currentIndex <- state.currentIndex + 1}
        | keyCode == downKey -> {state | currentIndex <- state.currentIndex - 1}
        | otherwise          -> state

main =
  let updatedState = foldp applyKey defaultStandardsState Keyboard.lastPressed
  in lift display updatedState
