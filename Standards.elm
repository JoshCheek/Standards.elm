module Standards where

type Standard = { id        : Int
                , standard  : String
                , tags      : [String]
                }

data Hierarchy = RootHierarchy
               | HierarchyNode { id             : Int
                               , parent_id      : Int
                               , name           : String
                               , tags           : [String]
                               , subhierarchies : Hierarchy
                               }

type State = { currentIndex  : Int
             , rootHierarchy : Hierarchy
             , standards     : [Standard]
             }

defaultStandardsState =
  let standard1    = Standard 1 "The first standard"  ["tag1", "tag2"]
      standard2    = Standard 2 "The second standard" ["tag1", "tag3"]
      standard3    = Standard 3 "The third standard"  ["tag2", "tag3"]
  in State 0 RootHierarchy [standard1, standard2, standard3]
