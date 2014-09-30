module Standards where

-- Standard
type Standard = { id        : Int
                , standard  : String
                , tags      : [String]
                }

-- Hierarchy
data Hierarchy = RootNode
               | HierarchyNode { id             : Int
                               , parent_id      : Int
                               , name           : String
                               , tags           : [String]
                               , subhierarchies : [Hierarchy]
                               }

nextSiblingOf : Hierarchy -> Hierarchy -> Int
nextSiblingOf root target =
  1
  -- findPost root target [root]

findPost : Hierarchy -> Hierarchy -> [Hierarchy] -> Hierarchy
findPost node target queue =
  if   isEmpty queue
  then node
  else case target of
       (RootNode) -> node
       otherwise  ->
         case node
         (RootNode) -> findPost (head queue) target (tail queue)
         otherwise  ->
           if node.id == target.id
           then head queue
           else findPost (head queue) target ((tail queue) ++ node.subhierarchies)


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
  in State 0 RootNode [standard1, standard2, standard3]
