data oats;
input WP Variety Manure Yield;
lines;
  1 2 3 156
  1 2 2 118
  1 2 1 138
  1 2 0 104
  2 0 0 111
  2 0 1 131
  2 0 3 172
  2 0 2 156
  3 1 0 115
  3 1 1 114
  3 1 2 163
  3 1 3 142
  5 2 2 109
  5 2 3 100
  5 2 0  64
  5 2 1  70
  4 1 0  79
  4 1 2  94
  4 1 3 127
  4 1 1  83
  6 0 1  89
  6 0 2  97
  6 0 3 115
  6 0 0  59;
  run;

  proc mixed data=oats;
  class Variety Manure;
  model Yield=Variety Manure Variety*Manure;
  random WP WP(Variety);
  lsmeans Variety Manure / cl pdiff adjust=Tukey;
  lsmeans Manure / cl pdiff=control('0') adjust=Dunnett alpha=0.05;
run;
