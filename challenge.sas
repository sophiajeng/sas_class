data challenge;
	set d.p_bpxo;
run;
proc contents data=challenge;
run;

data challenge;
	set li.p_deq;
run;
proc contents data=challenge;
run;

Proc univariate data=challenge normal plot;
	var BPXOSY1;
run;

data d.p_bpxo_b;
	set d.p_bpxo;
	bpgrp=9;
	if BPXOSY1 < 120 and bpxosy1 ne . then bpgrp=1;
	if BPXOSY1>=120 and BPXOSY1<130 then bpgrp=2;
	if BPXOSY1>=130 and BPXOSY1<140 then bpgrp=3;
	if BPXOSY1>=140 then bpgrp=4;
run;
proc freq data=d.p_bpxo_b;
 table BPXOSY1 * bpgrp/list missing;
run;

PROC SGPLOT DATA=challenge;
     Scatter y=BPXODI1 x=BPXOSY1;
RUN;

data derm_b;
	set challenge;
	sunexp=0;
	if ded120 ge 15 & ded120 le 480 then sunexp=1;
run;
proc freq data=derm_b;
tables sunexp*ded120 /list missing;
run;

data derm_c;
	set derm_b;
	shade=0;
	if deq034a=1 or deq034a=2 then shade=1;
	sunscreen=0;
	if deq034d=1 or deq034d=2 then sunscreen=1;
run;

proc logistic data = derm_c descending;
	model sunexp = shade sunscreen/risklimits;
run;

 
proc logistic data = derm_c descending;
	model sunexp = shade sunscreen shade*sunscreen/risklimits;
run;
