data golf;
input golfer brand distance @@;
lines;
1	1	211
1	1	205
1	1	179
1	2	231
1	2	237
1	2	249
1	3	188
1	3	213
1	3	246
2	1	222
2	1	191
2	1	234
2	2	222
2	2	204
2	2	251
2	3	215
2	3	197
2	3	164
3	1	244
3	1	207
3	1	196
3	2	191
3	2	226
3	2	192
3	3	217
3	3	197
3	3	244
4	1	217
4	1	219
4	1	241
4	2	199
4	2	225
4	2	209
4	3	193
4	3	184
4	3	234

;

proc glm data=golf;
class golfer brand;
model distance = brand|golfer;
means brand / tukey;
run; 
