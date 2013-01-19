~~~~~~~~~~~~~~~~
The Zebra Puzzle
~~~~~~~~~~~~~~~~

Rules
~~~~~

(from http://en.wikipedia.org/wiki/Zebra_puzzle):

1.  There are five houses.
2.  The Englishman lives in the red house.
3.  The Spaniard owns the dog.
4.  Coffee is drunk in the green house.
5.  The Ukrainian drinks tea.
6.  The green house is immediately to the right of the ivory house.
7.  The Old Gold smoker owns snails.
8.  Kools are smoked in the yellow house.
9.  Milk is drunk in the middle house.
10. The Norwegian lives in the first house.
11. The man who smokes Chesterfields lives in the house next to the man
    with the fox.
12. Kools are smoked in the house next to the house where the horse is
    kept. [should be … a house …]
13. The Lucky Strike smoker drinks orange juice.
14. The Japanese smokes Parliaments.
15. The Norwegian lives next to the blue house.

Now, who drinks water? Who owns the zebra? In the interest of clarity,
it must be added that each of the five houses is painted a different
color, and their inhabitants are of different national extractions, own
different pets, drink different beverages and smoke different brands of
American cigarets [sic]. One other thing: in statement 6, right means
your right.

Data Types
~~~~~~~~~~

A solution consists of a row of houses in a certain order.

> data Solution = Solution House House House House House
>     deriving (Show, Eq)

A house has a color, an inhabitant of a certain nationality, a pet,
a beverage and a cigarette associated with it.

> data House = House
>     { color :: Color
>     , compatriot :: Compatriot
>     , pet :: Pet
>     , beverage :: Beverage
>     , cigarette :: Cigarette
>     } deriving (Show, Eq)

Properties of a House
---------------------

> data Color = Blue | Green | Ivory | Red | Yellow
>     deriving (Show, Eq)

For each property, there is a function that returns a list of all the
possible values for this property:

> colors :: [Color]
> colors = [Blue, Green, Ivory, Red, Yellow]

> data Compatriot = Englishman | Japanese | Norwegian | Spaniard | Ukrainian
>     deriving (Show, Eq)

> compatriots :: [Compatriot]
> compatriots = [Englishman, Japanese, Norwegian, Spaniard, Ukrainian]

> data Pet = Dog | Fox | Horse | Snails | Zebra
>     deriving (Show, Eq)

> pets :: [Pet]
> pets = [Dog, Fox, Horse, Snails, Zebra]

> data Beverage = Coffee | Juice | Milk | Tea | Water
>     deriving (Show, Eq)

> beverages :: [Beverage]
> beverages = [Coffee, Juice, Milk, Tea, Water]

> data Cigarette = Chesterfields | Kools | Luckies | Old_Gold | Parliaments
>     deriving (Show, Eq)

> cigarettes :: [Cigarette]
> cigarettes = [Chesterfields, Kools, Luckies, Old_Gold, Parliaments]

Predicates
~~~~~~~~~~

0. In the interest of clarity, it must be added that each of the five
houses is painted a different color, and their inhabitants are of
different national extractions, own different pets, drink different
beverages and smoke different brands of American cigarets [sic].

``p0`` makes sure that every property occurs exactly once in all the
houses of a possible solution.

> p0 :: Solution -> Bool
> p0 (Solution h1 h2 h3 h4 h5) = all p cs
>   where
>     p ((House a1 b1 c1 d1 e1), (House a2 b2 c2 d2 e2)) =
>         and [a1 /= a2, b1 /= b2, c1 /= c2, d1 /= d2, e1 /= e2]
>     cs =
>         [ (h1, h2), (h1, h3), (h1, h4), (h1, h5), (h2, h3)
>         , (h2, h4), (h2, h5), (h3, h4), (h3, h5), (h4, h5)
>         ]

1. There are five houses.
This is fulfilled by the definition of ``Solution``.

2. The Englishman lives in the red house.

I.e., true if *either* the inhabitant is an Englishman and the color is
red, *or* the inhabitant is not an Englishman and the color is not red.

This pattern applies to most of the predicates that make statements
about houses.

> p2 :: House -> Bool
> p2 h = (compatriot h == Englishman) == (color h == Red)

3. The Spaniard owns the dog.

> p3 :: House -> Bool
> p3 h = (compatriot h == Spaniard) == (pet h == Dog)

4. Coffee is drunk in the green house.

> p4 :: House -> Bool
> p4 h = (beverage h == Coffee) == (color h == Green)

5. The Ukrainian drinks tea.

> p5 :: House -> Bool
> p5 h = (compatriot h == Ukrainian) == (beverage h == Tea)

6. The green house is immediately to the right of the ivory house.

> p6 :: Solution -> Bool
> p6 (Solution h1 h2 h3 h4 h5) = any p cs
>   where
>     p (left, right) = color right == Green && color left == Ivory
>     cs = [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]

7. The Old Gold smoker owns snails.

> p7 :: House -> Bool
> p7 h = (cigarette h == Old_Gold) == (pet h == Snails)

8. Kools are smoked in the yellow house.

> p8 :: House -> Bool
> p8 h = (cigarette h == Kools) == (color h == Yellow)

9. Milk is drunk in the middle house.

> p9 :: Solution -> Bool
> p9 (Solution _ _ h3 _ _) = beverage h3 == Milk

10. The Norwegian lives in the first house.

> p10 :: Solution -> Bool
> p10 (Solution h1 _ _ _ _) = compatriot h1 == Norwegian

11. The man who smokes Chesterfields lives in the house next to the man
with the fox.

> p11 :: Solution -> Bool
> p11 (Solution h1 h2 h3 h4 h5) = any p cs
>   where
>     p (left, right) =
>         (cigarette left == Chesterfields && pet right == Fox)
>         || (cigarette right == Chesterfields && pet left == Fox)
>     cs = [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]

12. Kools are smoked in the house next to the house where the horse is
kept. [should be … a house …]

> p12 :: Solution -> Bool
> p12 (Solution h1 h2 h3 h4 h5) = any p cs
>   where
>     p (left, right) =
>         (cigarette left == Kools && pet right == Horse)
>         || (cigarette right == Kools && pet left == Horse)
>     cs = [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]

13. The Lucky Strike smoker drinks orange juice.

> p13 :: House -> Bool
> p13 h = (cigarette h == Luckies) == (beverage h == Juice)

14. The Japanese smokes Parliaments.

> p14 :: House -> Bool
> p14 h = (compatriot h == Japanese) == (cigarette h == Parliaments)

15. The Norwegian lives next to the blue house.

> p15 :: Solution -> Bool
> p15 (Solution h1 h2 h3 h4 h5) = any p cs
>   where
>     p (left, right) =
>         (compatriot left == Norwegian && color right == Blue)
>         || (compatriot right == Norwegian && color left == Blue)
>     cs = [(h1, h2), (h2, h3), (h3, h4), (h4, h5)]

Predicates that apply to houses
-------------------------------

> hps :: [House -> Bool]
> hps = [p2, p3, p4, p5, p7, p8, p13, p14]

Predicates that apply to solutions
----------------------------------

``p9`` and ``p10`` are the cheapest solution predicates, so they are
checked first.

> sps :: [Solution -> Bool]
> sps = [p9, p10, p0, p6, p11, p12, p15]

Search Space
~~~~~~~~~~~~

``houseSpace`` contains all possible combinations of house properties:

> houseSpace :: [House]
> houseSpace =
>     [ House a b c d e
>     | a <- colors
>     , b <- compatriots
>     , c <- pets
>     , d <- beverages
>     , e <- cigarettes
>     ]

The ``solutionSpace`` consists of all possible combinations of houses:

> solutionSpace :: [Solution]
> solutionSpace =
>     [ (Solution h1 h2 h3 h4 h5)
>     | h1 <- h, h2 <- h, h3 <- h, h4 <- h, h5 <- h ]
>   where h = houses


Solution
~~~~~~~~

``houses`` returns a list of all houses for which all house predicates
are true:

> houses :: [House]
> houses = filter (check hps) houseSpace

``solutions`` returns all solutions for which all solution predicates
are true:

> solutions :: [Solution]
> solutions = filter (check sps) solutionSpace

Helper Functions
~~~~~~~~~~~~~~~~

Check if all predicates ``ps`` apply to ``x``:

> check :: [a -> Bool] -> a -> Bool
> check ps x = and $ map ($ x) ps

Print all solutions:

> main :: IO [()]
> main = mapM print solutions
