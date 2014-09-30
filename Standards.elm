module Standards where

-- Standard
type Standard = { id        : Int
                , standard  : String
                , tags      : [String]
                }

-- Hierarchy               id  parentId name   tags     subhierarchies
data Hierarchy = Hierarchy Int Int      String [String] [Hierarchy]

data Path     = Top | Node [Hierarchy] Path [Hierarchy]
data Location = Location Hierarchy Path

traverser : Hierarchy -> Location
traverser root = case root of Hierarchy i p n t s -> Location root (Node s Top [])



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
      root          = Hierarchy -1 -1 "root" [] []
  in State 0 root [standard1, standard2, standard3]
