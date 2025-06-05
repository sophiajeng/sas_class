proc sgplot data=STAT1.drug;
    vline drugdose / group=disease 
                        stat=mean 
                        response=bloodp
                        markers;
run; 
proc glm data=STAT1.drug order=internal;
    class disease drugdose;
    model bloodp = disease|drugdose;
    lsmeans disease*drugdose;
    title "Model with Disease and Drug Dose as Predictors";
run;
quit;
ods graphics on;
proc glm data=STAT1.drug plots(only)=intplot;
   class DrugDose Disease;
   model BloodP=DrugDose|Disease;
   lsmeans DrugDose*Disease / slice=Disease;
run;
quit;