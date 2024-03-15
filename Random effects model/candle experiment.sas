data candle;
  do person=1 to 4;
    do row=1,2;
      do color=1 to 4;
        do col=1,2;
          input time @@;
          output;
          drop row col;
  end; end; end; end;
  lines;
   989 1032  1044  979  1011  951   974  998
  1077 1019   987 1031   928 1022  1033 1041
   899  912   847  880   899  800   886  859
   911  943   879  830   820  812   901  907
   898  840   840  952   909  790   950  992
   955 1005   961  915   871  905   920  890
   993  957   987  960   864  925   949  973
  1005  982   920 1001   824  790   978  938
;

/* Two-way mixed effects - random */
proc mixed data=candle;
   class person color;
   model time = color;
   random person person*color;
   lsmeans color /cl pdiff adjust=tukey;
run;

/* Two-way mixed effects - not random */
proc mixed data=candle;
   class person color;
   model time = color;
   lsmeans color /cl pdiff adjust=tukey alpha=0.05;
run;

/* Two-way main effects - random */
proc glm data=candle;
   class person color;
   model time = color;
   random person person*color;
   lsmeans color /cl pdiff adjust=tukey;
run;

/* Two-way main effects - not random */
proc glm data=candle;
   class person color;
   model time = color;
   lsmeans color /cl pdiff adjust=tukey alpha=0.05;
run;

/* Two-way main effects (one with random effects and one without) produce the simultaneous confidence intervals of same lengths */
