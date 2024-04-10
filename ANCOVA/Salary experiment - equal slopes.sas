/* ANCOVA - homogenity of regression slopes*/
data equal_slopes;
input gender $ salary years;
datalines;
m 78 3
m 43 1
m 103 5
m 48 2
m 80 4
f 80 5
f 50 3
f 30 2
f 20 1
f 60 4
;
/* Treatment group - Males */
proc reg data=equal_slopes;
where gender='m';
model salary=years;
title 'Males';
run; quit;

/* Treatment group - Females */
proc reg data=equal_slopes;
where gender='f';
model salary=years;
title 'Females';
run; quit;

/* Check p-val to know if slopes are equal */
proc glm data=equal_slopes;
class gender;
model salary = gender years gender*years;
run;

proc sgplot data=equal_slopes;
styleattrs datalinepatterns=(solid);
reg y=salary x=years / group=gender;
run;

/* Fit an equal slopes model */
proc glm data=equal_slopes;
class gender;
model salary = gender years;
lsmeans gender / pdiff adjust=tukey;
title 'Equal Slopes Model';
run;

proc glm data=equal_slopes;
class gender;
model salary = gender years / noint solution;
ods select SolutionF;
title 'Equal Slopes Model reparametrized';
run;
