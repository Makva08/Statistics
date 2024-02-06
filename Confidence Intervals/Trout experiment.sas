data trout;
   input SulfamerazineLvl Hemoglobin;
   lines;
1 6.7
1 7.8
1 5.5
1 8.4
1 7.0
1 7.8
1 8.6
1 7.4
1 5.8
1 7.0
2 9.9
2 8.4
2 10.4
2 9.3
2 10.7
2 11.9
2 7.1
2 6.4
2 8.6
2 10.6
3 10.4
3 8.1
3 10.6
3 8.7
3 10.7
3 9.1
3 8.8
3 8.1
3 7.8
3 8.0
4 9.3
4 9.3
4 7.2
4 7.8
4 9.3
4 10.2
4 8.7
4 8.6
4 9.3
4 7.2
;
run;
/* calculating 99% confidence intervals for treatment-versus-control comparisons
regarding absence of sulfamerazine in the diet */
proc glm data=trout;
class SulfamerazineLvl;
model Hemoglobin = SulfamerazineLvl;
lsmeans SulfamerazineLvl/cl pdiff=control('1') adjust=bon alpha=0.01;
lsmeans SulfamerazineLvl/cl pdiff adjust=scheffe alpha=0.01;
lsmeans SulfamerazineLvl/cl pdiff adjust=tukey alpha=0.01;
lsmeans SulfamerazineLvl/cl pdiff=control('1') adjust=dunnett alpha=0.01;
run;
/* this part tests hypothesis if all treatments are equal, using alpha=0.05 */
data extra;
v=4;
alpha=0.05;
df1=v-1;
df2=v*10-v;
Falpha=finv(1-alpha, df1, df2);
put "Critical F Value (Falpha): " Falpha;
run;
/* calculating 95% confidence intervals for treatment-versus-control comparisons
regarding absence of sulfamerazine in the diet */
proc power;
MSE=2.2022;
twosamplemeans test = diff stddev=sqrt(2*MSE) meandiff=0 npergroup=. power=0.95 alpha=0.05 sides=2 width=2
run;
