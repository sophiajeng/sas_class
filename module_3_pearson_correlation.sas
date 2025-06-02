proc corr data=STAT1.bodyfat2 rank
          plots(only)=scatter(nvar=all ellipse=none);
   var age weight height;
   with  pctbodyfat2;
   id case;
   title "Correlations and Scatter Plots with pctbodyfat2";
run;
proc corr data=STAT1.bodyfat2 rank
          plots(only)=scatter(nvar=all ellipse=none);
   var neck chest abdomen hip thigh knee ankle biceps forearm wrist;
   with  pctbodyfat2;
   id case;
run;
title;

ods graphics off;
proc corr data=STAT1.bodyfat2 out=pearson
          nosimple 
          best=3;
   var age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist;
run;

title;
