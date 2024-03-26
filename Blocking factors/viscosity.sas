data viscosity;
  input sample aliquot @@;
  do subali=1 to 2;
    do part=1 to 2;
	  input viscosity @@;
	  output;
  end; end;
  lines;
  1  1 59.8 59.4 58.2 63.5
  1  2 66.6 63.9 61.8 62.0
  1  3 64.9 68.8 66.3 63.5
  1  4 62.7 62.2 62.9 62.8
  1  5 59.5 61.0 54.6 61.5
  1  6 69.0 69.0 60.6 61.8
  1  7 64.5 66.8 60.2 57.4
  1  8 61.6 56.6 64.5 62.3
  1  9 64.5 61.3 72.7 72.4
  1 10 65.2 63.9 60.8 61.2
  2  1 59.8 61.2 60.0 65.0
  2  2 65.0 65.8 64.5 64.5
  2  3 65.0 65.2 65.5 63.5
  2  4 62.5 61.9 60.9 61.5
  2  5 59.8 60.9 56.0 57.2
  2  6 68.8 69.0 62.5 62.0
  2  7 65.2 65.6 61.0 59.3
  2  8 59.6 58.5 62.3 61.5
  2  9 61.0 64.0 73.0 71.7
  2 10 65.0 64.0 62.0 63.0
;

proc glm data=viscosity;
  class sample aliquot subali;
  model viscosity = sample aliquot(sample) subali(aliquot sample);
  random sample aliquot(sample) subali(aliquot sample)/test;
run;
