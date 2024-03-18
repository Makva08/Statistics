proc plan ordered; 
	factors RTemp=3 Press=3 Time=3 Solvent=2 Source=5 / noprint; 
	output out = Candidate 
		RTemp nvals = (150 to 350 by 100) 
		Press nvals = (10 to 30 by 10) 
		Time nvals = ( 3 to 5 ) 
		Solvent nvals = (20 to 25 by 5) 
		Source nvals = ( 1 to 5 ); 

data Candidate; set Candidate; 
	if (^( (RTemp=150) & (Press=10) & (Time=3) )); 
	if (^( (RTemp=350) & (Press=30) & (Time=5) )); 
run; 

proc print data=Candidate(obs=10); 
run;

/* The default number of runs for a design is assumed by the optex procedure to be 10 plus # of params (in this case 10+18 = 28). 
Randomness is built in the algorithm to overcome prob of local optima.*/

proc optex data=Candidate seed=12345; 
class Source; 
model Source Solvent|RTemp|Press|Time@2 
	RTemp*RTemp Press*Press Time*Time; 
	generate n = 25;  /* this statement requests how many runs will experiment have */
run;


/* Constructing saturated second-order design */


/* Saturated means it includes estimation of all main effects and two-factor interactions
FACTEX procedure creates the full set of 2^7 = 128 candidate runs. 
Saturated design should be indicated in optex procedure. */

proc factex; 
factors x1-x7; 
output out=Candidate1; 
run; 

proc optex data=Candidate1 seed=12345; 
model x1|x2|x3|x4|x5|x6|x7@2; 
	generate n=saturated; 
output out = Design1a; 
run;

/* Different methods can be used to find better D-efficiency
Fedorov ref: 
https://documentation.sas.com/doc/en/pgmsascdc/v_048/qcug/qcug_optex_details33.htm
*/ 

proc optex data=Candidate1 seed=12345; 
model x1|x2|x3|x4|x5|x6|x7@2; 
	generate n=saturated 
		method=fedorov 
		iter=500; 
output out = Design1b; 
run;
