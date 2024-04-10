/* ANCOVA homogenity - unequal slopes*/
data unequal_slopes;
input gender $ salary years;
datalines;
m  42  1
m  112  4
m  92  3
m  62  2
m  142  5
f  80  5
f  50  3
f  30  2
f  20  1
f  60  4
;
proc glm data=unequal_slopes;
class gender;
model salary=gender years gender*years;
title 'Covariance Test for Equal Slopes';
lsmeans gender/pdiff at years=1;
lsmeans gender/pdiff at years=3;
lsmeans gender/pdiff at years=5;
run;

/* Generating the covariate regression slopes and intercepts*/
proc glm data=unequal_slopes;
class gender;
model salary=gender years gender*years / noint solution;
ods select SolutionF;
title 'Reparmeterized Model';
run;
