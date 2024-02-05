data battery;
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
proc GLM data=battery;
 class BatteryType;
 model LifePerCost = BatteryType;
 lsmeans BatteryType/cl pdiff=control('1') adjust=bon alpha=0.05;
 lsmeans BatteryType/cl pdiff adjust=scheffe alpha=0.05;
 lsmeans BatteryType/cl pdiff adjust=tukey alpha=0.05;
 lsmeans BatteryType/cl pdiff=control('1') adjust=dunnett alpha=0.05;
run;
