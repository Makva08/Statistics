/* Finding sample size with Z-val */
%let alpha = 0.10; 
%let max_mse = 25;
%let ci_width = 10;

data _null_;
    alpha = &alpha;
    max_mse = &max_mse;
    ci_width = &ci_width;

    z_value = quantile('normal', 1 - alpha / 2);
    call symputx('z_value', z_value);
    sample_size = 4 * (z_value ** 2) * max_mse / (ci_width ** 2);
    call symputx('sample_size', sample_size);
run;

%put zval: &z_value;  /* Just making sure z_value is correct */
%put Required Sample Size per Group: &sample_size;
/* Had an issue with variable definition, thats why they are created in macro
and then called in data step */



/* Finding sample size with t-val */
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
