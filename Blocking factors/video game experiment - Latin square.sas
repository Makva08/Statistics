/* Video game experiment aims to evaluate in which of five specific sound modes a certain video game is played the most efficiently. 
The first three sound modes correspond to three different types of background music, as well as game sounds expected to enhance play. 
The fourth mode had game sounds but no background music. 
The fifth mode had no music or game sounds.
The experimenter observed that the game required no warm up, that boredom and fatigue would
be a factor after 4–6 games, and that players performance varied considerably on a day-to-day basis.
A Latin square design should be used, with the two blocking factors: “day” and “time order of the game.” 
The response measured was the game score, with higher scores being better.*/


data videogame;
  input order @@;
  do day=1 to 5;
    input trtmt y @@;
	output;
  end;
  lines;
  1   1  94   3 100   4  98   2 101   5 112
  2   3 103   2 111   1  51   5 110   4  90
  3   4 114   1  75   5  94   3  85   2 107
  4   5 100   4  74   2  70   1  93   3 106
  5   2 106   5  95   3  81   4  90   1  73
;
run;
proc print;
run;

proc glm data=videogame;
   class order day trtmt;
   model y = order day trtmt / solution;
   lsmeans trtmt /cl pdiff=all adjust=tukey;
run;

proc mixed data=videogame;
   class day order trtmt;
   model y = order day trtmt;
   estimate 'Music vs No Music' trtmt 1 1 1 -1.5 -1.5 / divisor=3 cl alpha=0.05;
run;
