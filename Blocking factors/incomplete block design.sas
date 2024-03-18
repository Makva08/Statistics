data candidate;
do treatment = 1 to 8;
output;
end;
run;

proc print;
run;
/* proc optex in SAS searches for efficient incomplete block designs - 
it searches for the design that gives the smallest confidence region 
for all contrasts using the Scheffé method of multiple comparisons, **if BIBD exists, function finds it.
* The algorithm does 10 independent searches int in seed determines where 
to start the search so that the algorithm yields the same results when it is re-run
* The D-Efficiency concerns the width of CI given by Scheffe method (higher D shorter CI). 
* The A-Efficiency concerns the width of CI for pairwise comparisons given by Tukey method(higher A shorter CI) */

proc optex data = candidate seed = 72145;
class treatment;
model treatment;
* For 8 blocks of size 3 ;
blocks structure = (8) 3;
examine design;
run;
