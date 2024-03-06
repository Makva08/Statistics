/* Find the required sample size for the 90% simultaneous confidence
intervals for the pairwise comparison of main effects of B to have a width at most 10.
*/
data samplesize;
input r@@;
a=2;
b=4;
mse=25;
alpha=0.10;
prob=1-alpha;
df=a*b*r-a-b+1;
qT=probmc('range',.,prob,df,b);
width=2*(qT/2**0.5)*sqrt(mse*2/(a*r));
lines;
5 6 7 8
;
proc print;
var r width;
run;
