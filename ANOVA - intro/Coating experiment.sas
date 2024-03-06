/* P. Saravanan, V. Selvarajan, S. V. Joshi, and G. Sundararajan (2001, Journal of Physics D: Applied
Physics) described an experiment to study the effect of different spray parameters on thermal
spray coating properties. In the experiment, the authors attempted to produce high-quality alumina
(Al2O3) coatings by controlling the fuel ratio (factor A at 1:2.8 and 1:2.0), carrier gas flow rate
(factor B at 1.33 and 3.21L s-1), frequency of detonations (factor C at 2 and 4Hz), and spray
distance (factor D at 180 and 220 mm). To quantify the quality of the coating, the researchers
measured multiple response variables. This example examines the porosity (vol. %).*/

data alumina_coating;
  do A=2,1;
    do B=2,1;
      do C=2,1;
        do D=2,1;
          input Porosity @@;
          output;
  end; end; end; end;
  lines;
   5.95  4.57  4.03  2.17  3.43  1.02  4.25  2.13
  12.28  9.57  6.73  6.07  8.49  4.92  6.95  5.31
;
* Data by observation;
data alumina_coating;
  input A B C D Porosity;
  lines;
        2 2 2 2  5.95
        2 2 2 1  4.57
        2 2 1 2  4.03
        2 2 1 1  2.17
        2 1 2 2  3.43
        2 1 2 1  1.02
        2 1 1 2  4.25
        2 1 1 1  2.13
        1 2 2 2 12.30
        1 2 2 1  9.57
        1 2 1 2  6.73
        1 2 1 1  6.07
        1 1 2 2  8.49
        1 1 2 1  4.92
        1 1 1 2  6.95
        1 1 1 1  5.31
;
run;

proc glm data=alumina_coating;
    class A B C D;
    model Porosity = A B C D A*B A*C A*D B*C B*D C*D;
    means A B C D / tukey;

	/*calculating the 95% confidence intervals for the difference between the two main effects of Factor B  */
	lsmeans B / pdiff=ALL cl adjust=tukey;
	lsmeans B*C / out=bc_lsmeans;
run;

proc sgplot data=bc_lsmeans;
    series x=C y=lsmean / group=B; /* plots the LSMEAN of Porosity for each level of C, grouped by levels of B. */
    xaxis label='Factor C Level';
    yaxis label='LSMEAN of Porosity';
run;

/* MSE and df_error are taken from ANOVA table */
/* This snippet calculates the upper limit of the 90% CI for error variance */
proc iml;
    mse = 0.2703562;
    df_error = 5; 
    alpha = 0.10; /* 90% confidence interval */
    chi_square_critical_value = quantile("chisquare", alpha, df_error);
    upper_limit_sigma_squared = (df_error * mse) / chi_square_critical_value;
    print upper_limit_sigma_squared;
quit;


/* Tried looking at interaction between B and C 
Interestingly, full model yields no interaction, whereas 
this reduced model yields interaction, probably as there are
no other factors presented. */

/*proc glm data=alumina_coating;*/
/*    class B C;*/
/*    model Porosity = B C B*C;*/
/*    lsmeans B*C / plot=interaction;*/
/*run;*/
/*quit;*/
