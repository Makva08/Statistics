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
data extra;
m=3;
am=alpha/(2*m);
prob=1-am;
df=12;
tcv=tinv(.95, 12);
run;
proc print;
run;
proc glm data=data;
   class BatteryType;
   model LifePerCost = BatteryType;
   means BatteryType / bon scheffe tukey dunnett('1');
run;
