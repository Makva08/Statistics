data water_heating;
   input block C D E_val time;
   lines;
1 1 1 1 261.0
2 1 1 1 279.0
3 1 1 1 296.7
4 1 1 1 282.8
1 1 1 2 259.4
2 1 1 2 249.4
3 1 1 2 280.7
4 1 1 2 259.9
1 1 2 1 300.0
2 1 2 1 331.8
3 1 2 1 308.3
4 1 2 1 314.2
1 1 2 2 286.6
2 1 2 2 281.3
3 1 2 2 287.7
4 1 2 2 276.3
1 2 1 1 255.7
2 2 1 1 304.4
3 2 1 1 286.8
4 2 1 1 276.4
1 2 1 2 245.6
2 2 1 2 254.7
3 2 1 2 249.1
4 2 1 2 263.6
1 2 2 1 266.1
2 2 2 1 291.5
3 2 2 1 285.7
4 2 2 1 294.5
1 2 2 2 256.4
2 2 2 2 262.2
3 2 2 2 259.2
4 2 2 2 264.0
1 3 1 1 162.2
2 3 1 1 168.1
3 3 1 1 147.8
4 3 1 1 132.2
1 3 1 2 137.0
2 3 1 2 168.1
3 3 1 2 151.9
4 3 1 2 169.9
1 3 2 1 109.6
2 3 2 1 109.3
3 3 2 1 109.3
4 3 2 1 294.5
1 3 2 2 108.2
2 3 2 2 135.3
3 3 2 2 111.2
4 3 2 2 110.0

;
run;

proc glm data=water_heating;
   class block C D E_val;
   model time = block C D E_val C*D C*E_val D*E_val C*D*E_val;
   lsmeans C*D C*E_val D*E_val C*D*E_val /alpha=0.05 adjust=tukey;
   /* Testing the null hypothesis that the main effects of Factor C are all equal*/
   lsmeans C/cl pdiff adjust=tukey alpha=0.05;
   contrast 'Test for Main Effects of C' C 1 -1 0;
run;


proc freq data=water_heating;
  tables C;
run;
/* Calculating the necessary number of blocks for the 95% simultaneous confidence 
intervals for all pairwise comparisons of the main effects of C to have a width 
less than or equal to 40 when the block size is kept at 12 */

data size;
input r@@;
C = 3;
D = 2;
E = 2;
df = C * D * E * r - C - D - E + 1;
sigma2 = 1200.336;
alpha = 0.05;
w = probmc('range', ., 1 - alpha, df, C) / sqrt(2);
width = 2 * w * sqrt(2 * sigma2 / (C * r));
lines;
8 9 10 11 12
;
run;

proc print;
var r width;
run;
