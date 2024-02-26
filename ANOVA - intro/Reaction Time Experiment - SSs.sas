/* Aim is to investigate Two-Way ANOVA */
	/* Experiment compares the effects of auditory and visual cues on speed of response */
	/* of a human subject */
data reaction_times;
    input Cue $ ElapsedTime $ ReactionTime;
    datalines;
    Auditory 5 0.204
    Auditory 5 0.170
    Auditory 5 0.181
    Auditory 10 0.167
    Auditory 10 0.182
    Auditory 10 0.187
    Auditory 15 0.202
    Auditory 15 0.198
    Auditory 15 0.236
    Visual 5 0.257
    Visual 5 0.279
    Visual 5 0.269
    Visual 10 0.283
    Visual 10 0.235
    Visual 10 0.260
    Visual 15 0.256
    Visual 15 0.281
    Visual 15 0.258
    ;
run;

/* Two-way ANOVA */
proc anova data=reaction_times;
    class Cue ElapsedTime;
    model ReactionTime = Cue ElapsedTime Cue*ElapsedTime;
    means Cue ElapsedTime / tukey;
run;
/* Printing the results */
proc print data=reaction_times;
run;
/* Generate Interaction plots */
proc gplot data=reaction_times;
    plot ReactionTime*ElapsedTime=Cue / overlay;
    symbol1 interpol=join value=dot color=red;
    symbol2 interpol=join value=dot color=blue;
    title 'Interaction Plot for Cue and ElapsedTime';
run;
quit;
/*Test the hypothesis that different elapsed times have the same effects on the reaction time. */
proc anova data=reaction_times;
    class Cue ElapsedTime;
    model ReactionTime = Cue ElapsedTime;
    means ElapsedTime / tukey;
run;

/* Find a 95% confidence interval for the difference between the average reaction time from the
auditory cue and the average reaction time from the visual cue */
proc anova data=reaction_times;
    class Cue ElapsedTime;
    model ReactionTime = Cue ElapsedTime Cue*ElapsedTime;
    means Cue / tukey cl;
run;
proc GLM data=reaction_times;
 class Cue ElapsedTIme;
 model ReactionTime = Cue ElapsedTime Cue*ElapsedTime;
 lsmeans Cue/cl pdiff adjust=tukey alpha=0.05;
run;

proc glm data=reaction_times;
    class Cue ElapsedTime;
    model ReactionTime = Cue|ElapsedTime;
	lsmeans Cue*ElapsedTime/cl pdiff adjust=bon alpha=0.05;
 	lsmeans Cue*ElapsedTime/cl pdiff adjust=scheffe alpha=0.05;
 	lsmeans Cue*ElapsedTime/cl pdiff adjust=dunnett alpha=0.05;
    lsmeans Cue*ElapsedTime / pdiff cl adjust=tukey;
run;
quit;
