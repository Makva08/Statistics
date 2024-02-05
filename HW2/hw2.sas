data heart_lung_pump;
input Observation rpm Level Liters_per_minute;
/*	alpha=0.1;*/
/*	v=15;*/
/*	n=4;*/
/*	df1=v-1;*/
/*	df2=n-v;*/
/*	Falpha=finv(1-alpha, df1, df2);*/
/*	power=1-probf(Falpha, df1, df2);*/
/*	put "power=" power;*/
	put "Falpha=" Falpha;
lines;
1 150 5 3.540
2 50 1 1.158
3 50 1 1.128
4 75 2 1.686
5 150 5 3.480
6 150 5 3.510
7 100 3 2.328
8 100 3 2.340
9 100 3 2.298
10 125 4 2.982
11 100 3 2.328
12 50 1 1.140
13 125 4 2.868
14 150 5 3.504
15 100 3 2.340
16 75 2 1.740
17 50 1 1.122
18 50 1 1.128
19 150 5 3.612
20 75 2 1.740
;
run;
proc print data = heart_lung_pump;
run;

proc glm data=heart_lung_pump;
    class Level;
    model Liters_per_minute = Level;
    means Level / tukey;
run;

data output_dataset;
    alpha=0.1;
	n=15;
	v=4;
	df1=v-1;
	df2=n-v;
	Falpha=finv(1-alpha, df1, df2);
	output;
run;
proc print data=output_dataset;
	var Falpha;
run;
