data errorvarcalc;
    df = 5;
    alpha = 0.10;
	mse=0.27;
    critval = quantile('CHISQ', alpha, df);
    upper_limit = (df * mse) / critval;
	put "Chi square dist corresponding number " critval;
    put "Upper limit for error variance (s^2) at 90% confidence level is " upper_limit;
run;
