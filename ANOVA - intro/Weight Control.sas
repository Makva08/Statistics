/* 	This example compares three diets on weight control
	Experimenter eould like to detect difference of 4 kg w/prob 90% */
data power;
input r @@;
v=3;
diff=4;
variance=36;
sigma=sqrt(variance);
alpha=0.05;
df1=v-1;
df2=v*(r-1);
ncp=r*diff**2/(2*sigma**2);
Falpha=finv(1-alpha, df1, df2);
power=1-probf(Falpha, df1, df2, ncp);
lines;
5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100
;
run;
proc print; 
var r power; 
run;
