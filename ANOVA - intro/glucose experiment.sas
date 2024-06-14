data gluc;
input method glucose concen @@;
lines;
1	1	43.3
1	1	44.3
1	1	41.2
1	2	136.7
1	2	143.8
1	2	140.1
1	3	178.1
1	3	184.0
1	3	182.4
2	1	37.2
2	1	40.2
2	1	38.8
2	2	134.0
2	2	131.4
2	2	131.2
2	3	178.8
2	3	174.5
2	3	175.7
;
proc glm data=gluc;
class method glucose;
model concen = method|glucose;
lsmeans glucose /cl pdiff adjust=tukey alpha=0.05;
run; 
