/*The rust experiment investigates the effect of temperature on the percentage of surface area of a
metal sheet exhibiting rust after a given length of time exposed to certain weathering conditions. 

Five temperatures were examined in the experiment, but only three could be examined at any one time
under identical experimental conditions. 

A balanced incomplete block design (BIBD) was used, formed from two
cyclic designs with initial blocks (1, 2, 3) and (1, 2, 4).*/

data rust;
   input Temperature Block RustPercentage;
   lines;
50 1 12
50 2 19
50 6 20
50 7 10
50 8 21
50 9 19
55 1 18
55 3 33
55 5 19
55 7 18
55 9 18 
55 10 24
60 1 24
60 2 36
60 4 35
60 5 39
60 6 22
60 10 28
65 3 39
65 4 45
65 6 43
65 7 34
65 8 42
65 10 21
70 2 45
70 3 52
70 4 55
70 5 48
70 8 50
70 9 43
;
run;

proc glm data=rust;
   class Temperature Block;
   model RustPercentage = Temperature Block;
   lsmeans Temperature/cl pdiff adjust=tukey alpha=0.05;
   contrast 'Linear Trend' Temperature -10 -5 0 5 10;
run;
