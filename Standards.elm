module GameSkeleton where

import Window
import Keyboard
import Text
import Char

-- collage gameWidth gameHeight
-- toForm (if state == Play then spacer 1 1 else identity msg)
display standardsState =
  let pongGreen                  = rgb 60 100 60
      displayStandard message    = group [ filled pongGreen (rect 200 50)
                                         , toForm message
                                         ]
      displayStandards ss n      = if | isEmpty ss -> []
                                      | otherwise  -> (move (0, 60*n) (displayStandard <| head ss)) :: (displayStandards (tail ss) (n+1))
      strings                    = map plainText (.standards standardsState)
  in  collage 500 500 ((move (0, -60) (toForm <| asText (.currentIndex standardsState))) :: (displayStandards strings 0))

type StandardsState = { standards:[String]
                      , currentIndex:Int
                      , lastPressed:Int
                      }

defaultStandardsState = let defaultStandards = [ "omg1"
                                               , "omg2"
                                               , "omg3"
                                               , "omg4"
                                               ]
                        in lift (StandardsState defaultStandards 0) Keyboard.lastPressed

main = lift display defaultStandardsState


-- -----  Part 1: Model the user input
-- type Input = {space:Bool, paddle1:Int, paddle2:Int, delta:Time}


-- ------ Part 2: Model the game
-- type Object a  = { a | x:Float, y:Float, vx:Float, vy:Float }
-- type Ball      = Object {}
-- type Player    = Object { score:Int }
-- data State     = Play | Pause
-- type Game      = { state:State, ball:Ball, player1:Player, player2:Player }

-- (gameWidth,gameHeight) = (600,400)
-- (halfWidth,halfHeight) = (300,200)

-- player : Float -> Player
-- player x = { x=x, y=0, vx=0, vy=0, score=0 }

-- defaultGame : Game
-- defaultGame =
--   { state   = Pause
--   , ball    = { x=0, y=0, vx=200, vy=200 }
--   , player1 = player (20-halfWidth)
--   , player2 = player (halfWidth-20)
--   }


-- ------ Part 3: Update the game
-- -- are n and m near each other?
-- -- specifically are they within c of each other?
-- near : Float -> Float -> Float -> Bool
-- near n c m = m >= n-c && m <= n+c

-- -- is the ball within a paddle?
-- within ball player = (ball.x |> near player.x 8) && (ball.y |> near player.y 20)

-- ------ change the direction of a velocity based on collisions
-- stepV : Float -> Bool -> Bool -> Float
-- stepV v lowerCollision upperCollision =
--   if | lowerCollision -> abs v
--      | upperCollision -> 0 - abs v
--      | otherwise      -> v

-- -- step the position of an object based on its velocity and a timestep
-- stepObj : Time -> Object a -> Object a
-- stepObj t ({x,y,vx,vy} as obj) =
--     { obj | x <- x + vx * t
--           , y <- y + vy * t }

-- -- move a ball forward, detecting collisions with either paddle
-- stepBall : Time -> Ball -> Player -> Player -> Ball
-- stepBall t ({x,y,vx,vy} as ball) player1 player2 =
--   if not (ball.x |> near 0 halfWidth)
--   then { ball | x <- 0, y <- 0 }
--   else
--     let vx' = stepV vx (ball `within` player1) (ball `within` player2)
--         vy' = stepV vy (y < 7-halfHeight) (y > halfHeight-7)
--     in
--         stepObj t { ball | vx <- vx', vy <- vy' }

-- -- step a player forward, making sure it does not fly off the court
-- stepPlyr : Time -> Int -> Int -> Player -> Player
-- stepPlyr t dir points player =
--   let player' = stepObj t { player | vy <- toFloat dir * 200 }
--       y'      = clamp (22-halfHeight) (halfHeight-22) player'.y
--       score'  = player.score + points
--   in
--       { player' | y <- y', score <- score' }


-- stepGame : Input -> Game -> Game
-- stepGame {space,paddle1,paddle2,delta}
--          ({state,ball,player1,player2} as game) =
--   let score1 = if ball.x >  halfWidth then 1 else 0
--       score2 = if ball.x < -halfWidth then 1 else 0
--       state' = if | space            -> Play
--                   | score1 /= score2 -> Pause
--                   | otherwise        -> state
--       ball' = if state == Pause then ball else
--                   stepBall delta ball player1 player2
--       player1' = stepPlyr delta paddle1 score1 player1
--       player2' = stepPlyr delta paddle2 score2 player2
--   in
--       { game | state   <- state'
--              , ball    <- ball'
--              , player1 <- player1'
--              , player2 <- player2' }


-- ------ Part 4: Display the game
-- -- helper values
-- pongGreen = rgb 60 100 60
-- textGreen = rgb 160 200 160
-- txt f     = leftAligned << f << monospace << Text.color textGreen << toText
-- msg       = "SPACE to start, WS and &uarr;&darr; to move"

-- -- shared function for rendering objects
-- displayObj : Object a -> Shape -> Form
-- displayObj obj shape =
--     move (obj.x,obj.y) (filled white shape)

-- -- display a game state
-- -- display : (Int,Int) -> Game -> Element
-- -- display (w,h) {state,ball,player1,player2} =
-- --   let scores : Element
-- --       scores = txt (Text.height 50) <|
-- --                show player1.score ++ "  " ++ show player2.score
-- --   in
-- --       container w h middle <|
-- --       collage gameWidth gameHeight
-- --        [ filled pongGreen   (rect gameWidth gameHeight)
-- --        , displayObj ball    (oval 15 15)
-- --        , displayObj player1 (rect 10 40)
-- --        , displayObj player2 (rect 10 40)
-- --        , toForm scores
-- --            |> move (0, gameHeight/2 - 40)
-- --        , toForm (if state == Play then spacer 1 1 else identity msg)
-- --            |> move (0, 40 - gameHeight/2)
-- --        ]
-- --


-- ------ The following code puts it all together and shows it on screen.
-- input : Signal Input
-- input =
--   let delta = inSeconds <~ fps 35
--   in sampleOn delta <| Input <~ Keyboard.space
--                               ~ lift .y Keyboard.wasd
--                               ~ lift .y Keyboard.arrows
--                               ~ delta
-- gameState : Signal Game
-- gameState = foldp stepGame defaultGame input
-- -- main      = lift2 display Window.dimensions gameState

