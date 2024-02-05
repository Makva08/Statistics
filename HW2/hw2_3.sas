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
3 4 5 6 7 8 9
;
run;
proc print; 
var r power; 
run;
