/*data step reads it in and unpacks it into libname mapped to r*/
data li.p_deq;
	set xptfile.p_deq;
run;

data li.BRFSS_a;
    set XPTfile.LLCP2014;
run;

/*verify success*/

proc contents data=li.BRFSS_a;
run;


data li.BRFSS_b;
	set li.BRFSS_a (keep =
		VETERAN3 
		ASTHMA3
		DIABETE3
		SLEPTIM1
		_AGE_G
		SMOKE100
		SMOKDAY2
		SEX
		_HISPANC
		_MRACE1
		MARITAL
		GENHLTH
		HLTHPLN1
		EDUCA
		INCOME2
		_BMI5CAT
		EXERANY2);
run;

proc contents data = li.BRFSS_b;
run;

/*If you want to keep most of the variables, then use
the drop command instead*/

data Drop_Example;
	set li.BRFSS_a (drop =
		VETERAN3 
		ASTHMA3
		DIABETE3
		SLEPTIM1
		_AGE_G
		SMOKE100
		SMOKDAY2
		SEX
		_HISPANC
		_MRACE1
		MARITAL
		GENHLTH
		HLTHPLN1
		EDUCA
		INCOME2
		_BMI5CAT
		EXERANY2);
run; 

Proc Contents data=Drop_Example;
run;

/*110_check*/	
proc freq data=li.BRFSS_b;
	tables VETERAN3;
run;

/*check exclusions with the missing option*/

proc freq data=li.BRFSS_b;
	tables VETERAN3 / missing;
	tables DIABETE3 / missing;
	tables SLEPTIM1 / missing;
	tables ASTHMA3 / missing;
run;


