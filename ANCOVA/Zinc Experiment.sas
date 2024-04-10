/*  Zinc experiment was run to illustrate the possible bias caused by ignoring an important covariate. 
The experimental units consisted of 12 steel brackets. Four steel brackets were sent to each of three vendors to be zinc plated. 
The response variable was the thickness of the zinc plating, in hundred-thousandths of an inch. 
The thickness of each bracket before plating was measured as a covariate.
*/
data zinc;
  input vendor   x   y;
  lines;
           1   110  40
           1    75  38
           1    93  30
           1    97  47
           2    60  25
           2    75  32
           2    38  13
           2   140  35
           3    62  27
           3    90  24
           3    45  20
           3    59  13
;
run;

proc sgplot;
scatter Y=y X=x/group=vendor;
title "Scatter Plot";
run;

proc glm data=zinc;
class vendor;
model y=vendor x;
run;

/* Sometimes its interesting to check what happpens if covariate is not included, how significance changes! */
