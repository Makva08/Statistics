/* Generate Full Factorial Candidate Set */
proc plan ordered;
    factors RF1=4 RF2=4 Pressure=5 / noprint;
    output out=CandidateFullFactorial
        RF1 nvals=(50 75 150 165)
        RF2 nvals=(300 600 900 1000)
        Pressure nvals=(0.2 1 2 8 12);
run;

/* Select a Fractional Design from the Full Factorial Set */
proc optex data=CandidateFullFactorial seed=12345;
    class RF1 RF2 Pressure;
    model RF1|RF2|Pressure@2;
    generate n=35; /* Selecting 35 runs */
    output out=Design;
run;

proc print data=Design;
run;

