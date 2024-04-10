/* Exp consists of 5 humidity lvls that are assigned randomly to 3 climate-controlled rooms in a CRD.
Factor humidity has lvls that are equally spaced. Orthogonal contrast coeff can be used to fit a poly to the response - fungus yields. */

data fungus;
  array yields[15] _temporary_ (13.1 12.3 13.3 17.1 16.6 17.4 19.5 21.1 19.3 18.7 20.1 18.2 18.9 17.3 17.5);
  do humidity = 30 to 70 by 10;
    do i = 1 to 3;
      yield = yields[(humidity-30)/10*3 + i];
      output;
    end;
  end;
  drop i;
run;

proc print data=fungus;
run;

/* IML generates orthogonal polynomials*/
proc iml;
  x = {30 40 50 60 70}; 
  xpoly = orpol(x,4); /* the '4' is the df for the quantitative factor */
  humidity = x`; 
  new=humidity || xpoly;
  create out1 from new[colname={"humidity" "xp0" "xp1" "xp2" "xp3" "xp4"}];
  append from new; 
  close out1; 
quit;

proc print data=out1; 
run;

/* Here data is sorted and then merged with the original dataset */
proc sort data=fungus; 
  by humidity; 
run;

data ortho_poly; 
merge out1 fungus; 
  by humidity; 
run;

proc print data=ortho_poly; 
run;

proc mixed data=ortho_poly method=type1;
  class;
  model yield=xp1 xp2 xp3 xp4/ solution;
  title 'Using Orthog polynomials from IML';
  ods select SolutionF;
run;
 
/*Proc glm will use the orthogonal contrast coefficients directly*/
proc glm data=fungus;
 class humidity;
 model yield = humidity;
 contrast 'linear' humidity -2 -1 0 1 2;
 contrast 'quadratic' humidity 2 -1 -2 -1 2;
 contrast 'cubic' humidity -1 2 0 -2 1;
 contrast 'quatic' humidity 1 -4 6 -4 1;
 lsmeans humidity;
run;

/* Specifying only quadratic poly.
Centering the quantitative variable lvls by subtracting the mean of the levels (50) & creating the quadratic poly terms.*/
data fungus; 
  set fungus;
  x=humidity-50;
  x2=x**2;
run;

/* Outputs regression coefficients, uses global F-test*/
proc mixed data=fungus method=type1;
  class; 
  model yield = x x2 /solutions;
run;
