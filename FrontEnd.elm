module FrontEnd where

import Standards (Standard, State)
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
standardView : Standard -> Form
standardView standard =
  group [ filled standardsBG (rect standardWidth standardHeight)
        , toForm (plainText standard.standard)
        ]

display : State -> Element
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
  let standard1             = Standard 1 "The first standard"  ["tag1", "tag2"]
      standard2             = Standard 2 "The second standard" ["tag1", "tag3"]
      standard3             = Standard 3 "The third standard"  ["tag2", "tag3"]
      defaultStandards      = [standard1, standard2, standard3]
      currentIndex          = 0
      defaultStandardsState = lift (State defaultStandards currentIndex) Keyboard.lastPressed
  in lift display defaultStandardsState
