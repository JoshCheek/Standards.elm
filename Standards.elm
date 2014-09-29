module Standards where

type Standard = { id        : Int
                , standard  : String
                , tags      : [String]
                }

type State = { standards    : [Standard]
             , currentIndex : Int
             }
