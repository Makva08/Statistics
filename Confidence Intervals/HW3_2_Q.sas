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
/* This code generates a result with comparisons of Bonferroni, Scheffe, Tukey and Dunnets methods of Confidence Intervals.
Its using means u2-u1, u3-u1 and u4-u1 meaning 1 is the control group. 
Result yields that Tukey method is the best for multiple comparisons, 
as its confidence limits are most confined over difference between means.*/
proc GLM data=battery;
 class BatteryType;
 model LifePerCost = BatteryType;
 lsmeans BatteryType/cl pdiff=control('1') adjust=bon alpha=0.05;
 lsmeans BatteryType/cl pdiff adjust=scheffe alpha=0.05;
 lsmeans BatteryType/cl pdiff adjust=tukey alpha=0.05;
 lsmeans BatteryType/cl pdiff=control('1') adjust=dunnett alpha=0.05;
run;
