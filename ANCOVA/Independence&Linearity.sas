data film_data;
    input RF1 RF2 Pressure thickness refractive_index;
    lines;
50 300 1 129.3 1.47978
50 300 2 159.87 1.469019
50 900 8 156 1.47074
75 900 8 145 1.46884
75 1000	0.2	137.68 1.46917
75 1000	8 148.856 1.46874184
150 900	12 118.954 1.46631714
150	300	1 104.631 1.4681808
165	900	0.2	106.25 1.26042
150	600	2 109.912 1.46448872
150	1000 2 120.26 1.46454913
150	1000 8 124.76 1.462736
165	1000 12	104.982	1.467856
165	1000 8 106.3 1.464753
75 1000	2 112.38 1.46402
50 900	2 151.16 1.47074
150	900	0.2	121.208	1.46402032
150	900	1 120.26 1.46454913
150	300	8 121.437 1.46441377
75 600 12 118.62 1.46823701
75 600 1 143.27	1.464854
50 1000	12 148.34 1.465876
50 1000	0.2	158.46 1.470323
75 300 12 121.01 1.46402
165	600	2 107.4873 1.4628772
165 600	1 106.857 1.46527
75 300 0.2 137.235 1.469042
50 1000	1 144.317 1.467802
50 600 0.2 117.89287 1.4650732
75 900 1 145.193 1.469483
165	300	2 102.483 1.41029
50 600 8 147.867 1.464874
165	900	12 109.371 1.451231
;
run;

proc glm data=film_data;
   class RF1 RF2 Pressure;
   model refractive_index = RF1 RF2 Pressure thickness;
   output out=residuals_data r=residuals p=predicted_values;
run;

proc sgscatter data=film_data;
  matrix refractive_index RF1 RF2 Pressure thickness / diagonal=(histogram);
  title "Pairwise Scatter Plots of refractive_index Against Each Predictor";
run;



/* Plot residuals against each predictor */
proc sgplot data=residuals_data;
  scatter x=predicted_values y=residuals;
  title "Residuals vs Fitted Values";
run;

proc sgplot data=residuals_data;
  scatter x=RF1 y=residuals;
  title "Residuals vs RF1";
run;

proc sgplot data=residuals_data;
  scatter x=RF2 y=residuals;
  title "Residuals vs RF2";
run;

proc sgplot data=residuals_data;
  scatter x=Pressure y=residuals;
  title "Residuals vs Pressure";
run;

proc sgplot data=residuals_data;
  scatter x=thickness y=residuals;
  title "Residuals vs Thickness";
run;
