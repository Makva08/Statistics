
data candidate;
do treatment = 1 to 8;
output;
end;
run;

proc print;
run;

proc optex data = candidate seed = 72145;
class treatment;
model treatment;
* For 8 blocks of size 3 ;
blocks structure = (8) 3;
examine design;
run;
