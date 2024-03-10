data results;
    v = 7; /* Number of treatments */
    k = 5; /* Block size */

    do b = 1 to 25;
        r = b * k / v;
        lambda = r * (k - 1) / (v - 1);
        if r = int(r) and lambda = int(lambda) then do;
            output;
        end;
    end;
run;

/* Print results */
proc print data=results;
    var b r lambda;
    title "Block Design Analysis for v=7, k=5";
run;

data size;
	r = 15;
	alpha = 0.05;
	mse = 30;
	v = 7; /*num of treatments*/
	k = 5; /*block size*/
	b = 21;
	df = v * r - b - v + 1;
	lambda = r * (k-1)/(v-1);
	q = probmc('range', ., 1-alpha, df, v);
	msd_tukey = (q/sqrt(2)) * sqrt(2*mse*k/(lambda*v));
	width_tukey = 2 *msd_tukey;
	dunnett_crit = 2.5;
	msd_dunnett = dunnett_crit * sqrt(mse/r);
	width_dunnett = 2 * msd_dunnett;
lines;
10 11 12 13 14 15 16 17 18 19
;

proc print;
var r b lambda width_tukey width_dunnett;
run;
