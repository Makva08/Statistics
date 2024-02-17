/* Aim is to investigate Two-Way ANOVA
	Experiment compares the effects of auditory and visual cues on speed of response
	of a human subject
*/
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
