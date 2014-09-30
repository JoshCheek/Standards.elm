module Standards where

-- Standard
type Standard = { id        : Int
                , standard  : String
                , tags      : [String]
                }

-- Hierarchy
data Hierarchy = Hierarchy { id             : Int
                           , parentId       : Int
                           , name           : String
                           , tags           : [String]
                           , subhierarchies : [Hierarchy]
                           }

-- State
type State = { currentIndex  : Int
             , rootHierarchy : Hierarchy
             , standards     : [Standard]
             }

-- add some hierarchies in here
defaultStandardsState =
  let standard1     = Standard 1 "The first standard"  ["tag1", "tag2"]
      standard2     = Standard 2 "The second standard" ["tag1", "tag3"]
      standard3     = Standard 3 "The third standard"  ["tag2", "tag3"]
      root          = Hierarchy {id = -1, parentId = -1, name = "root", tags = [], subhierarchies = []}
  in State 0 root [standard1, standard2, standard3]
