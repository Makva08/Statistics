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
proc anova data=data;
   class BatteryType;
   model LifePerCost = BatteryType;
run;

proc means data=data mean clm;
   class BatteryType;
   var LifePerCost;
run;

data extra;
v=4;
alpha=0.05;
df1=v-1;
df2=v**2-v;
Falpha=finv(1-alpha, df1, df2);
put "Critical F Value (Falpha): " Falpha;
run;
