/*This experiment aimed to determine the factors that affect the length of time that a cigarette will burn.
 
Three factors of interest: 
�Tar� (factor A ) at two levels, �regular� and �ultra-light,��
�Brand� (factor B ) at two levels, �name brand� and �generic brand� (coded 1 and 2),
�Age� (factor C ) at three levels, �fresh,� � 24 hour air exposure,� �48 hour air exposure.� 

The cigarettes were to be burned in whole plots of size six. 
There were ten whole plots, and these were assigned at random to the tar levels so that each tar level was assigned five whole plots.
The six split plots (time slots) in each whole plot were assigned at random to the six brand/age treatment combinations. 
Marks were made across the seam of each cigarette at a given distance apart. 
Each cigarette was lit at the beginning of its allotted time slot, and the time taken to burn between the two marks was recorded.
*/

data cigarett;
  input WP A @@;
  do SP = 1 to 6; 
    input B C time @@;
	D = 10*B+C;
    output;
  end;
  
  lines;
   1 1  2 2 301  1 1 326  2 3 260  1 3 290  1 2 312  2 1 292 
   2 2  1 1 329  1 2 331  1 3 285  2 1 306  2 2 258  2 3 276 
   3 2  2 2 290  1 1 380  1 2 335  1 3 309  2 3 243  2 1 334 
   4 2  1 1 321  2 1 337  2 3 275  1 2 316  1 3 307  2 2 250 
   5 2  2 2 308  1 1 345  2 1 307  2 3 288  1 3 321  1 2 330 
   6 1  1 1 344  2 3 283  2 1 281  2 2 261  1 3 307  1 2 292 
   7 1  2 1 274  1 3 310  1 2 304  2 2 279  2 3 277  1 1 330 
   8 1  1 3 302  1 2 325  2 2 301  1 1 338  2 3 270  2 1 297 
   9 2  1 2 323  1 3 334  2 3 265  1 1 326  2 2 269  2 1 297 
  10 1  2 3 309  1 3 314  2 2 259  1 1 344  2 1 310  1 2 322 
;
proc print;
run;

proc mixed data = cigarett;
  class WP A D;
  model time = A D A*D;
  random WP(A);
run;

proc mixed data = cigarett;
class WP A B C;
model time = A|B|C;
random WP(A);
lsmeans B /cl pdiff adjust = Tukey;
run;
