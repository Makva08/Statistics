/* This code uses a battery experiment as an example
Experiment is trying to find which type of nonrechareable batteries are most economical
It compares lifetime per unit cost of particular name brands
Also it compares alkaline vs heavy duty batteries
Lvl 1 - alkaline, name brand (1,1)
Lvl 2 - alkaline, store brand (1,2)
Lvl 3 - heavy duty, name brand (2,1)
Lvl 4 - heavy duty, store brand (2,2) */
data data;
input BatteryType $ LifePerCost;
lines;
1 611
1 537
1 542
1 593
2 923
2 794
2 827
2 898
3 445
3 490
3 384
3 413
4 476
4 569
4 480
4 460
;
run;
/* Using statistical model ANOVA */
proc anova data=data;
   class BatteryType;
   model LifePerCost = BatteryType;
run;
/* finding estimats of treatment means*/
proc means data=data mean clm;
   class BatteryType;
   var LifePerCost;
run;
/* this part tests hypothesis if all treatments are equal, using alpha=0.05 */
data extra;
v=4;
alpha=0.05;
df1=v-1;
df2=v**2-v;
Falpha=finv(1-alpha, df1, df2);
put "Critical F Value (Falpha): " Falpha;
run;
