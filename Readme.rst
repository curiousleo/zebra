The Puzzle
~~~~~~~~~~

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

(from http://en.wikipedia.org/wiki/Zebra_puzzle)

The Programs
~~~~~~~~~~~~

``zebra.lhs`` and ``zebra.pl`` solve the above puzzle. The former is
programmed Haskell, using its lazy evaluation feature to generate the
search space and then filtering it using predicates based on the rules
of the Zebra Puzzle. The latter is a simple Prolog program (in the
SWI-Prolog dialect).

Time needed to run the programs on my laptop (not giving away the
solution here!)::

  $ ghc -O3 -o zebra zebra.lhs && time ./zebra
  Solution (House {color = …, compatriot = …, pet = …, beverage = …,
  cigarette = …}) (House …) (House …) (House …) (House …)

  real	1m25.781s
  user	1m25.461s
  sys	0m0.128s

