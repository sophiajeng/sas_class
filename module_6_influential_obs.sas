ods graphics on;
%let dimensions=abdomen weight wrist forearm;
proc reg data=STAT1.bodyfat2;
    CONTINUOUS: model pctbodyfat2 
                  = &dimensions;
    title 'PctBodyFat Model - Plots of Diagnostic Statistics';
run;
quit;

/*perform regression and store sig parameter*/
ods select none;
proc glmselect data=STAT1.bodyfat2 plots=all;
	STEPWISE: model pctbodyfat2 = &dimensions / selection=stepwise details=steps select=SL slentry=0.05 slstay=0.05;
	title "Stepwise Model Selection for PctBodyFat - SL 0.05";
run;
quit;
ods select all;

/*check if any observation is an outlier or influential based on parameter*/
ods graphics on;
ods output RSTUDENTBYPREDICTED=Rstud 
           COOKSDPLOT=Cook
           DFFITSPLOT=Dffits 
           DFBETASPANEL=Dfbs;
proc reg data=STAT1.bodyfat2 
         plots(only label)=
              (RSTUDENTBYPREDICTED 
               COOKSD 
               DFFITS 
               DFBETAS);
    SigLimit: model pctbodyfat2 = &_GLSIND; 
    title 'SigLimit Model - Plots of Diagnostic Statistics';
run;
quit;

/*create dataset with all the values, outliers of parameter by obs*/
title;
proc print data=Rstud;
run;

proc print data=Cook;
run;

proc print data=Dffits;
run;

proc print data=Dfbs;
run;

data Dfbs01;
	set Dfbs (obs=300);
run;

data Dfbs02;
	set Dfbs (firstobs=301);
run;

data Dfbs2;
	update Dfbs01 Dfbs02;
	by Observation;
run;

/*create a dataset to include only those obs/parameters that are influential/outliers*/
data influential;
/*  Merge datasets from above.*/
    merge Rstud
          Cook 
          Dffits
		  Dfbs2;
    by observation;

/*  Flag observations that have exceeded at least one cutpoint;*/
    if (ABS(Rstudent)>3) or (Cooksdlabel ne ' ') or Dffitsout then flag=1;
    array dfbetas{*} _dfbetasout: ;
    do i=2 to dim(dfbetas);
         if dfbetas{i} then flag=1;
    end;

/*  Set to missing values of influence statistics for those*/
/*  that have not exceeded cutpoints;*/
    if ABS(Rstudent)<=3 then RStudent=.;
    if Cooksdlabel eq ' ' then CooksD=.;

/*  Subset only observations that have been flagged.*/
    if flag=1;
    drop i flag;
run;

title;
proc print data=influential;
    id observation;
    var Rstudent CooksD Dffitsout _dfbetasout:; 
run;


ods graphics on;
ods output RSTUDENTBYPREDICTED=Rstud 
           COOKSDPLOT=Cook
           DFFITSPLOT=Dffits 
           DFBETASPANEL=Dfbs;
proc reg data=STAT1.BodyFat2 
         plots(only label)=
              (RSTUDENTBYPREDICTED 
               COOKSD 
               DFFITS 
               DFBETAS);
   FORWARD: model PctBodyFat2
                 = Abdomen Weight Wrist Forearm;
   id Case;
   title 'FORWARD Model - Plots of Diagnostic Statistics';
run;
quit;
data influential;
/*  Merge datasets from above.*/
    merge Rstud
          Cook 
          Dffits
		  Dfbs;
    by observation;

/*  Flag observations that have exceeded at least one cutpoint;*/
    if (ABS(Rstudent)>3) or (Cooksdlabel ne ' ') or Dffitsout then flag=1;
    array dfbetas{*} _dfbetasout: ;
    do i=2 to dim(dfbetas);
        if dfbetas{i} then flag=1;
    end;

/*  Set to missing values of influence statistics for those*/
/*  who have not exceeded cutpoints;*/
    if ABS(Rstudent)<=3 then RStudent=.;
    if Cooksdlabel eq ' ' then CooksD=.;

/*  Subset only observations that have been flagged.*/
    if flag=1;
    drop i flag;
run;

proc print data=influential;
    id observation ID1;
    var Rstudent CooksD Dffitsout _dfbetasout:; 
run;
    