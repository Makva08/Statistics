/* Define Specific Combinations to Include */
data Preset;
    input RF1 RF2 Pressure;
    datalines;
    50 900 8
    75 900 8
    75 900 12
    75 1000 8
    150 1000 8
    150 600 8
    150 600 2
    150 600 12
    150 300 2
    150 1000 1
    150 1000 0.2
    165 1000 0.2
;
run;

/* Generate Experimental Design with Preset Runs Included */
proc optex data=CandidateFullFactorial seed=12345; 
    class RF1 RF2 Pressure;
    model RF1|RF2|Pressure@2;
    generate n=40 augment=preset; /* Augmenting design with Preset runs */
    output out=DesignWithPreset;
run;

proc print data=DesignWithPreset;
run;
