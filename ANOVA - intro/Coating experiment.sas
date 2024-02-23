/* P. Saravanan, V. Selvarajan, S. V. Joshi, and G. Sundararajan (2001, Journal of Physics D: Applied
Physics) described an experiment to study the effect of different spray parameters on thermal
spray coating properties. In the experiment, the authors attempted to produce high-quality alumina
(Al2O3) coatings by controlling the fuel ratio (factor A at 1:2.8 and 1:2.0), carrier gas flow rate
(factor B at 1.33 and 3.21L s-1), frequency of detonations (factor C at 2 and 4Hz), and spray
distance (factor D at 180 and 220 mm). To quantify the quality of the coating, the researchers
measured multiple response variables. This example examines the porosity (vol. %).*/
data alumina_coating;
    input A B C D Porosity;
    datalines;
    2 2 2 2 5.95
    2 2 2 1 4.57
    2 2 1 2 4.03
    2 2 1 1 2.17
    2 1 2 2 3.43
    2 1 2 1 1.02
    2 1 1 2 4.25
    2 1 1 1 2.13
    1 2 2 2 12.28
    1 2 2 1 9.57
    1 2 1 2 6.73
    1 2 1 1 6.07
    1 1 2 2 8.49
    1 1 2 1 4.92
    1 1 1 2 6.95
    1 1 1 1 5.31
;
run;

proc glm data=alumina_coating;
    class A B C D;
    model Porosity = A B C D A*B A*C A*D B*C B*D C*D;
    means A B C D / tukey;

	/*calculating the 95% confidence intervals for the difference between the two main effects of Factor B  */
	lsmeans B / pdiff=ALL cl adjust=tukey;
run;
quit;
