{-
The Zebra Puzzle
(from http://en.wikipedia.org/wiki/Zebra_puzzle):

 1. There are five houses.
 2. The Englishman lives in the red house.
 3. The Spaniard owns the dog.
 4. Coffee is drunk in the green house.
 5. The Ukrainian drinks tea.
 6. The green house is immediately to the right of the ivory house.
 7. The Old Gold smoker owns snails.
 8. Kools are smoked in the yellow house.
 9. Milk is drunk in the middle house.
10. The Norwegian lives in the first house.
11. The man who smokes Chesterfields lives in the house next to the man
    with the fox.
12. Kools are smoked in the house next to the house where the horse is
    kept. (should be "... a house ...")
13. The Lucky Strike smoker drinks orange juice.
14. The Japanese smokes Parliaments.
15. The Norwegian lives next to the blue house.

Now, who drinks water? Who owns the zebra? In the interest of clarity,
it must be added that each of the five houses is painted a different
color, and their inhabitants are of different national extractions, own
different pets, drink different beverages and smoke different brands of
American cigarets [sic]. One other thing: in statement 6, right means
your right.
-}


{- The data types. -}

-- A solution consists of a row of houses in a certain order.
data Solution = Solution House House House House House
  deriving (Show, Eq)

-- A house has a color, an inhabitant of a certain nationality, a pet,
-- a beverage and a cigarette associated with it.
data House = House {
  color :: Color
, compatriot :: Compatriot
, pet :: Pet
, beverage :: Beverage
, cigarette :: Cigarette
} deriving (Show, Eq)

data Color = Blue | Green | Ivory | Red | Yellow
  deriving (Show, Eq)

colors :: [Color]
colors = [Blue, Green, Ivory, Red, Yellow]

data Compatriot = Englishman | Japanese | Norwegian | Spaniard | Ukrainian
  deriving (Show, Eq)

compatriots :: [Compatriot]
compatriots = [Englishman, Japanese, Norwegian, Spaniard, Ukrainian]

data Pet = Dog | Fox | Horse | Snails | Zebra
  deriving (Show, Eq)

pets :: [Pet]
pets = [Dog, Fox, Horse, Snails, Zebra]

data Beverage = Coffee | Juice | Milk | Tea | Water
  deriving (Show, Eq)

beverages :: [Beverage]
beverages = [Coffee, Juice, Milk, Tea, Water]

data Cigarette = Chesterfields | Kools | Lucky_Strikes | Old_Gold | Parliaments
  deriving (Show, Eq)

cigarettes :: [Cigarette]
cigarettes = [Chesterfields, Kools, Lucky_Strikes, Old_Gold, Parliaments]


{- The predicates. -}

-- 0. In the interest of clarity, it must be added that each of the five
-- houses is painted a different color, and their inhabitants are of
-- different national extractions, own different pets, drink different
-- beverages and smoke different brands of American cigarets [sic].
spred0 :: Solution -> Bool
spred0 (Solution h1 h2 h3 h4 h5) = all ppred0 [(h1, h2), (h1, h3), (h1, h4), (h1, h5), (h2, h3), (h2, h4), (h2, h5), (h3, h4), (h3, h5), (h4, h5)]
  where ppred0 ((House a1 b1 c1 d1 e1), (House a2 b2 c2 d2 e2)) =
          and [a1 /= a2, b1 /= b2, c1 /= c2, d1 /= d2, e1 /= e2]

-- 1. There are five houses.
-- This is fulfilled by the definition of Solution.

-- 2. The Englishman lives in the red house.
hpred2 :: House -> Bool
hpred2 h = (compatriot h == Englishman) == (color h == Red)

-- 3. The Spaniard owns the dog.
hpred3 :: House -> Bool
hpred3 h = (compatriot h == Spaniard) == (pet h == Dog)

-- 4. Coffee is drunk in the green house.
hpred4 :: House -> Bool
hpred4 h = (beverage h == Coffee) == (color h == Green)

-- 5. The Ukrainian drinks tea.
hpred5 :: House -> Bool
hpred5 h = (compatriot h == Ukrainian) == (beverage h == Tea)

-- 6. The green house is immediately to the right of the ivory house.
spred6 :: Solution -> Bool
spred6 (Solution h1 h2 h3 h4 h5) = any ppred6 [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]
  where ppred6 (left, right) = color right == Green && color left == Ivory

-- 7. The Old Gold smoker owns snails.
hpred7 :: House -> Bool
hpred7 h = (cigarette h == Old_Gold) == (pet h == Snails)

-- 8. Kools are smoked in the yellow house.
hpred8 :: House -> Bool
hpred8 h = (cigarette h == Kools) == (color h == Yellow)

-- 9. Milk is drunk in the middle house.
spred9 :: Solution -> Bool
spred9 (Solution h1 h2 h3 h4 h5) = beverage h3 == Milk

-- 10. The Norwegian lives in the first house.
spred10 :: Solution -> Bool
spred10 (Solution h1 h2 h3 h4 h5) = compatriot h1 == Norwegian

-- 11. The man who smokes Chesterfields lives in the house next to the man
-- with the fox.
spred11 :: Solution -> Bool
spred11 (Solution h1 h2 h3 h4 h5) = any ppred11 [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]
  where ppred11 (h1, h2) = (cigarette h1 == Chesterfields && pet h2 == Fox)
                           || (cigarette h2 == Chesterfields && pet h1 == Fox)

-- 12. Kools are smoked in the house next to the house where the horse is
-- kept. (should be "... a house ...")
spred12 :: Solution -> Bool
spred12 (Solution h1 h2 h3 h4 h5) = any ppred12 [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]
  where ppred12 (h1, h2) = (cigarette h1 == Kools && pet h2 == Horse)
                           || (cigarette h2 == Kools && pet h1 == Horse)

-- 13. The Lucky Strike smoker drinks orange juice.
hpred13 :: House -> Bool
hpred13 h = (cigarette h == Lucky_Strikes) == (beverage h == Juice)

-- 14. The Japanese smokes Parliaments.
hpred14 :: House -> Bool
hpred14 h = (compatriot h == Japanese) == (cigarette h == Parliaments)

-- 15. The Norwegian lives next to the blue house.
spred15 :: Solution -> Bool
spred15 (Solution h1 h2 h3 h4 h5) = any ppred15 [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]
  where ppred15 (h1, h2) = (compatriot h1 == Norwegian && color h2 == Blue)
                           || (compatriot h2 == Norwegian && color h1 == Blue)

-- Predicates that apply to houses.
hpreds :: [House -> Bool]
hpreds = [hpred2, hpred3, hpred4, hpred5, hpred7, hpred8, hpred13, hpred14]

-- Predicates that apply to solutions.
spreds :: [Solution -> Bool]
spreds = [spred9, spred10, spred0, spred6, spred11, spred12, spred15]


{- The search space. -}

houseSpace :: [House]
houseSpace = [House a b c d e
               | a <- colors
               , b <- compatriots
               , c <- pets
               , d <- beverages
               , e <- cigarettes]

solutionSpace :: [Solution]
solutionSpace = [(Solution h1 h2 h3 h4 h5)
                  | h1 <- h, h2 <- h, h3 <- h, h4 <- h, h5 <- h]
                    where h = houses


{- The solution. -}

houses :: [House]
houses = filter (check hpreds) houseSpace

solutions :: [Solution]
solutions = filter (check spreds) solutionSpace


{- Helper functions and the main routine. -}

-- Check if all predicates ps apply to x.
check :: [a -> Bool] -> a -> Bool
check ps x = and $ map ($ x) ps

-- Print all solutions.
main = mapM print solutions
