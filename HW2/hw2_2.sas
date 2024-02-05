data heart_lung_pump;
  input Observation rpm Level Liters_per_minute;
  datalines;
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
