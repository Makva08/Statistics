data _null_;
	alpha = 0.10;
	max_mse = 25;
	ci_width = 10;
    z_value = quantile('normal', 1 - &alpha / 2);
    call symputx('z_value', z_value);
	sample_size = %sysevalf(4*(&&z_value ** 2) * &max_mse / ((&ci_width) ** 2));
run;
%put zval: &z_value;  /* for 90% z_val=1.645, this is just a check */
%put Required Sample Size per Group: &sample_size;
