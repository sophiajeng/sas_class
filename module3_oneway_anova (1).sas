proc means data=stat1.garlic;
class fertilizer;
var bulbwt;
run;

proc sgplot data=stat1.garlic;
vbox bulbwt / category=fertilizer;
run;

proc glm data=STAT1.garlic plots=diagnostics;
    class fertilizer;
    model bulbwt=fertilizer;
	means fertilizer / hovtest=levene;
    title "One-Way ANOVA with Fertilizer as Predictor";
run;
quit;

title;

ods select lsmeans diff diffplot controlplot;
proc glm data=STAT1.garlic plots=diagnostics
	plots(only)=diffplot(center);
    class fertilizer;
    model bulbwt=fertilizer;
    lsmeans fertilizer / pdiff=all 
                         adjust=tukey;
    title "One-Way ANOVA with Fertilizer as Predictor";
run;
quit;

title;

ods select lsmeans diff diffplot controlplot;
proc glm data=STAT1.garlic 
         plots(only)=controlplot;
    class fertilizer;
    model bulbwt=fertilizer;
    lsmeans fertilizer / pdiff=control('4') 
                         adjust=dunnett;
    title "Post-Hoc Analysis of ANOVA - Heating Quality as Predictor";
run;
quit;

title;

