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
