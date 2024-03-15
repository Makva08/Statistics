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
* Data by observation;
data candle;
  input person color time;
  lines;
           1     1    989
           1     1   1032
           1     2   1044
           1     2    979
           1     3   1011
           1     3    951
           1     4    974
           1     4    998
           1     1   1077
           1     1   1019
           1     2    987
           1     2   1031
           1     3    928
           1     3   1022
           1     4   1033
           1     4   1041
           2     1    899
           2     1    912
           2     2    847
           2     2    880
           2     3    899
           2     3    800
           2     4    886
           2     4    859
           2     1    911
           2     1    943
           2     2    879
           2     2    830
           2     3    820
           2     3    812
           2     4    901
           2     4    907
           3     1    898
           3     1    840
           3     2    840
           3     2    952
           3     3    909
           3     3    790
           3     4    950
           3     4    992
           3     1    955
           3     1   1005
           3     2    961
           3     2    915
           3     3    871
           3     3    905
           3     4    920
           3     4    890
           4     1    993
           4     1    957
           4     2    987
           4     2    960
           4     3    864
           4     3    925
           4     4    949
           4     4    973
           4     1   1005
           4     1    982
           4     2    920
           4     2   1001
           4     3    824
           4     3    790
           4     4    978
           4     4    938
;
run;
/*Random */
proc mixed data=candle;
   class person color;
   model time = color;
   random person person*color;
   lsmeans color /cl pdiff adjust=tukey;
run;


/*Not Random */
proc mixed data=candle;
   class person color;
   model time = color;
   lsmeans color /cl pdiff adjust=tukey alpha=0.05;
run;
