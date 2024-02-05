/* This experiment aims to detect the effect of the number of revolutions per minute (rpm) of the rotary 
pump head of an Olson heart–lung pump on the fluid flow rate. 
The rpm was set directly on the tachometer of the pump console and PVC tubing of size 3/8” by 3/32” was used. 
The flow rate was measured in liters per minute. 
Five equally spaced levels of the treatment factor “rpm” were selected, namely, 50, 75, 100, 125, and 150 rpm, and
these were coded as 1, 2, 3, 4, 5, respectively. The experimental design was a completely randomized
design with r1 = r3 = r5 = 5, r2 = 3, and r4 = 2.
Code calculates ANOVA table and tests the null hypothesis that # of rev per min has no eff on fluid flow rate.
*/
data heart_lung_pump;
  input Observation rpm Level Liters_per_minute;
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

proc glm data=heart_lung_pump;
  class Level;
  model Liters_per_minute = Level;
  means Level / tukey;
  output out=ANOVA_Results r=residual_residual;
run;
data _null_;
  set ANOVA_Results;
  SSE = residual_residual**2;
  df = _dferror_;
  alpha = 0.1; 
  chi_sq_crit = quantile('CHISQ', 1 - alpha/2, df);
  upper_limit_error_variance = (df * SSE) / chi_sq_crit;
  put "Upper Confidence Limit for Error Variance: " upper_limit_error_variance;
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
