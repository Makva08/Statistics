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
