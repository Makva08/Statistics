/* Paper towel absorbancy experiment was run to compare the effects of two treatment factors:
brand and printing, on the absorbancy of paper towels.
1st factors A: Three brands. 2nd factors B: white and printed towels. 
For each observation, water was dripped from above a towel, which was horizontally suspended between two pairs of books
on a flat surface, until the water began leaking through to the surface below. 
The time to collect each observation was measured in s. 
Absorbancy was measured as the number of water drops absorbed per square inch of towel. 
The rate at which the water droplets fell to the towel was measured (in drops/s) as a covariate. 
*/

data papertowel;
    input run trtmt AB drops time area rate absorb;
    lines;
        1    2   12   89   50  121.00  1.780  0.7355
        2    4   22   28   15   99.00  1.867  0.2828
        3    2   12   47   22  121.00  2.136  0.3884
        4    1   11   82   42  121.00  1.952  0.6777
        5    5   31   54   30  123.75  1.800  0.4364
        6    1   11   74   37  121.00  2.000  0.6116
        7    4   22   29   14   99.00  2.071  0.2929
        8    6   32   80   41  123.75  1.951  0.6465
        9    3   21   25   11   99.00  2.273  0.2525
        10   3   21   27   12   99.00  2.250  0.2727
        11   6   32   83   40  123.75  2.075  0.6707
        12   5   31   41   19  123.75  2.158  0.3313
    ;
run;

proc sgplot;
scatter Y=absorb X=rate/group=trtmt;
series Y=absorb X=rate/group=trtmt; /*connects points made by scatter plot*/
title "Absorbancy vs Rate by Treatment Level";
run;

/* proc gplot data=papertowel;
    plot absorb*rate=trtmt / overlay;
    title 'Absorbancy vs Rate by Treatment Level with Connected Lines';
run;
quit; */

proc glm data=papertowel;
class trtmt;
model absorb = trtmt rate/solution;
title 'One-Way ANCOVA';
run;

