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
