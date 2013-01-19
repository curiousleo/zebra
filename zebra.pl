% ~~~~~~~~~~~~~~~~
% The Zebra Puzzle
% ~~~~~~~~~~~~~~~~
% 
% Rules
% ~~~~~
% 
% (from http://en.wikipedia.org/wiki/Zebra_puzzle):
% 
% 1.  There are five houses.
% 2.  The Englishman lives in the red house.
% 3.  The Spaniard owns the dog.
% 4.  Coffee is drunk in the green house.
% 5.  The Ukrainian drinks tea.
% 6.  The green house is immediately to the right of the ivory house.
% 7.  The Old Gold smoker owns snails.
% 8.  Kools are smoked in the yellow house.
% 9.  Milk is drunk in the middle house.
% 10. The Norwegian lives in the first house.
% 11. The man who smokes Chesterfields lives in the house next to the
%     man with the fox.
% 12. Kools are smoked in the house next to the house where the horse is
%     kept. (should be "... a house ...")
% 13. The Lucky Strike smoker drinks orange juice.
% 14. The Japanese smokes Parliaments.
% 15. The Norwegian lives next to the blue house.
% 
% Now, who drinks water? Who owns the zebra? In the interest of clarity,
% it must be added that each of the five houses is painted a different
% color, and their inhabitants are of different national extractions,
% own different pets, drink different beverages and smoke different
% brands of American cigarets [sic]. One other thing: in statement 6,
% right means your right.

% 1.  There are five houses.
% This is implicit in the definitions of rightOf, middleHouse, and
% firstHouse.
rightOf(A,B,(B,A,_,_,_)).
rightOf(A,B,(_,B,A,_,_)).
rightOf(A,B,(_,_,B,A,_)).
rightOf(A,B,(_,_,_,B,A)).

exists(A,H) :- rightOf(A,_,H).
exists(A,H) :- rightOf(_,A,H).

middleHouse(A,(_,_,A,_,_)).
firstHouse(A,(A,_,_,_,_)).

nextTo(A,B,H) :- rightOf(A,B,H).
nextTo(A,B,H) :- rightOf(B,A,H).

% 2.  The Englishman lives in the red house.
:-    exists(house(british,_,_,_,red),Houses),
% 3.  The Spaniard owns the dog.
      exists(house(spanish,dog,_,_,_),Houses),
% 4.  Coffee is drunk in the green house.
      exists(house(_,_,_,coffee,green),Houses),
% 5.  The Ukrainian drinks tea.
      exists(house(ukranian,_,_,tea,_),Houses),
% 6.  The green house is immediately to the right of the ivory house.
      rightOf(house(_,_,_,_,green),house(_,_,_,_,ivory),Houses),
% 7.  The Old Gold smoker owns snails.
      exists(house(_,snail,oldgold,_,_),Houses),
% 8.  Kools are smoked in the yellow house.
      exists(house(_,_,kools,_,yellow),Houses),
% 9.  Milk is drunk in the middle house.
      middleHouse(house(_,_,_,milk,_),Houses),
% 10. The Norwegian lives in the first house.
    firstHouse(house(norwegian,_,_,_,_),Houses),
% 11. The man who smokes Chesterfields lives in the house next to the
%     man with the fox.
      nextTo(house(_,_,chesterfields,_,_),house(_,fox,_,_,_),Houses),
% 12. Kools are smoked in the house next to the house where the horse is
%     kept. (should be "... a house ...")
      nextTo(house(_,_,kools,_,_),house(_,horse,_,_,_),Houses),
% 13. The Lucky Strike smoker drinks orange juice.
      exists(house(_,_,luckystrike,orangejuice,_),Houses),
% 14. The Japanese smokes Parliaments.
      exists(house(japanese,_,parliaments,_,_),Houses),
% 15. The Norwegian lives next to the blue house.
      nextTo(house(norwegian,_,_,_,_),house(_,_,_,_,blue),Houses),

%     Now, who drinks water?
      exists(house(WaterDrinker,_,_,water,_),Houses),
%     Who owns the zebra?
      exists(house(ZebraOwner,zebra,_,_,_),Houses),

      print(ZebraOwner),print('\n'),
      print(WaterDrinker),print('\n').
