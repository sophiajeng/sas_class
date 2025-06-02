/*st102d02.sas*/
ods graphics;
/*diagnostic plots panel
class categorical predictor variable
model specify dependant/independant var
mean unadjusted means of hovtest=levene levene test of homogeneity of variance
format the output variable names*/
proc glm data=STAT1.ameshousing3 plots=diagnostics;
    class Heating_QC;
    model SalePrice=Heating_QC;
	means Heating_QC / hovtest=levene;
    format Heating_QC $Heating_QC.;
    title "One-Way ANOVA with Heating Quality as Predictor";
run;
quit;

title;



