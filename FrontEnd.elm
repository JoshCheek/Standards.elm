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
boxView : Bool -> String -> Form
boxView isCurrent string =
  group [ filled (standardsBG isCurrent) (rect standardWidth standardHeight)
        , toForm (plainText string)
        ]

-- 2----4---5
-- |    |   |
-- 1-3  6   7-8-9
--              |
--              a-b-c
display : State -> Element
display state = collage 500 500 [boxView True (hierarchyName <| unzip2 state.zipper)]

  -- let totalStandardHeight         = standardHeight+standardOffset
  --     positionFor n               = move (0, totalStandardHeight*n)
  --     positionH index svs         = if | isEmpty svs -> []
  --                                      | otherwise   -> (positionFor index (head svs)) :: (positionStandards (index+1) (tail svs))
  --     standardViews               = indexedMap (\i s -> standardView (i==state.currentIndex) s) state.standards
  --     standardGroup               = group <| positionH 0 standardViews
  --     currentAtCenter             = -totalStandardHeight * state.currentIndex
  -- in  collage 500 500 [move (0, (toFloat currentAtCenter)) standardGroup]

-- Run
applyKey keyCode state =
  let upKey    = 38 -- if these move onto the state itself, then user can choose their own keymap!
      downKey  = 40
      leftKey  = 37
      rightKey = 39
  in if | keyCode == upKey    -> {state | zipper <- zipUp    state.zipper }
        | keyCode == downKey  -> {state | zipper <- zipDown  state.zipper }
        | keyCode == leftKey  -> {state | zipper <- zipLeft  state.zipper }
        | keyCode == rightKey -> {state | zipper <- zipRight state.zipper }
        | otherwise           -> state

main =
  let updatedState = foldp applyKey defaultStandardsState Keyboard.lastPressed
  in lift display updatedState
