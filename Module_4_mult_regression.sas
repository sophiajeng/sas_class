ods graphics off;
proc reg data=STAT1.bodyfat2 ;
    model pctbodyfat2=age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist;
    title "Full Model";
run;
quit;
/*remove insignificant variables */

proc reg data=STAT1.bodyfat2 ;
    model pctbodyfat2=age weight height neck chest abdomen hip thigh ankle biceps forearm wrist;
    title "Without Knee Model";
run;
quit;

proc reg data=STAT1.bodyfat2 ;
    model pctbodyfat2=age weight height neck abdomen hip thigh ankle biceps forearm wrist;
    title "Without Knee and Chest Model";
run;
quit;

proc reg data=STAT1.bodyfat2 ;
    model pctbodyfat2=age neck chest abdomen forearm wrist;
    title "Refitted Model 1";
run;
quit;

proc reg data=STAT1.bodyfat2 ;
    model pctbodyfat2=age neck abdomen forearm wrist;
    title "Refitted Model 2";
run;
quit;

proc reg data=STAT1.bodyfat2 ;
    model pctbodyfat2=weight;
    title "With Just Weight";
run;
quit;

