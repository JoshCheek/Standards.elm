module Standards where


-- Standard
type Standard = { id        : Int
                , standard  : String
                , tags      : [String]
                }


--   Hierarchy             id  parentId name   tags     subhierarchies
data Hierarchy = Hierarchy Int Int      String [String] [Hierarchy]

hierarchyName : Hierarchy -> String
hierarchyName h = case h of Hierarchy i p n t s -> n

--   Path                   left        up   right       current
data Path      = Top | Node [Hierarchy] Path [Hierarchy] Hierarchy

zipper : Hierarchy -> Path
zipper root = case root of Hierarchy i p n t s -> Node s Top [] root

unzip2 : Path -> Hierarchy
unzip2 zipper = case zipper of Node l u r hierarchy -> hierarchy

zipDown : Path -> Path
zipDown zipper =
  case zipper of
  Node l u r (Hierarchy i p n t (nxt::children)) ->
  Node [] zipper children nxt

zipRight : Path -> Path
zipRight zipper =
  case zipper of
  Top -> zipper
  Node left       up (nxt::right) crnt ->
  Node (crnt::[]) up right        nxt

zipLeft : Path -> Path
zipLeft zipper =
  case zipper of
  Node (nxt::left) up right         crnt ->
  Node left        up (crnt::right) nxt

zipUp : Path -> Path
zipUp zipper =
  case zipper of
  Top -> zipper
  Node left up right crnt -> up

-- State
type State = { zipper        : Path
             , rootHierarchy : Hierarchy
             , standards     : [Standard]
             }

-- 2----4---5
-- |    |   |
-- 1-3  6   7-8-9
--              |
--              a-b-c

defaultStandardsState =
  let standard1     = Standard 1 "The first standard"  ["tag1", "tag2"]
      standard2     = Standard 2 "The second standard" ["tag1", "tag3"]
      standard3     = Standard 3 "The third standard"  ["tag2", "tag3"]
      root          = Hierarchy 0 -1 "root" [] [h2, h4, h5]

      h2            = Hierarchy 2  0 "h2"   [] [h1, h3]
      h4            = Hierarchy 4  0 "h4"   [] [h6]
      h5            = Hierarchy 5  0 "h5"   [] [h7, h8, h9]

      h1            = Hierarchy 1  2 "h1"   [] []
      h3            = Hierarchy 3  2 "h3"   [] []
      h6            = Hierarchy 6  4 "h6"   [] []
      h7            = Hierarchy 7  5 "h7"   [] []
      h8            = Hierarchy 8  5 "h8"   [] []
      h9            = Hierarchy 9  5 "h9"   [] [ha, hb, hc]

      ha            = Hierarchy 10 9 "ha"   [] []
      hb            = Hierarchy 11 9 "hb"   [] []
      hc            = Hierarchy 12 9 "hc"   [] []

  in State (zipper root) root [standard1, standard2, standard3]

main =
  let goZipping = (zipper defaultStandardsState.rootHierarchy)
                |> zipDown
                |> zipDown
                |> zipRight
                |> zipLeft
                |> zipUp
                |> unzip2
  in asText goZipping
