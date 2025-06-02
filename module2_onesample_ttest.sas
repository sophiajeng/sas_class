%let interval=bodytemp heartrate;
proc univariate data=STAT1.normtemp;
	var &interval;
    histogram &interval/ normal kernel;
    inset n mean std / position=ne;
;
run;


proc ttest data=stat1.NormTemp h0=98.6 plots(only shownull)=interval; 
   var BodyTemp; 
   title 'Testing Whether the Mean Body Temperature=98.6'; 
run; 
title;