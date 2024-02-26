/*Experimenting with several cross-factors */

/* This experiment compares brands of microwave popcorn. 
It aims to find which brand gives rise to the best popcorn 
in terms of the proportion of popped kernels in microwave oven.
The first treatment factor was brand: two national (levels 1 and 2) and one local (level 3). 
Second treatment was power of the microwaves tested: 500W and 600W.
Third treatment was popping time: 4, 4.5 and 5 min (coded with keys 1-3). */

data popmic;
  input brand power @@;
  do time=1 to 3;
    do rep=1 to 2; drop rep;
      input y @@;
      output;
  end; end;
  lines;
  1 1  73.8 65.5  70.3 91.0  72.7 81.9
  1 2  70.8 75.3  78.7 88.7  74.1 72.1
  2 1  73.7 65.8  93.4 76.3  45.3 47.6
  2 2  79.3 86.5  92.2 84.7  66.3 45.7
  3 1  62.5 65.0  50.1 81.5  51.4 67.7
  3 2  82.1 74.5  71.5 80.0  64.0 77.0
;
run;

proc print data=popmic;
run;

proc glm data=popmic;
class brand power time;
model y=brand power time brand*power brand*time power*time brand*power*time;
lsmeans power/cl pdiff;
lsmeans brand*time;
run; 
