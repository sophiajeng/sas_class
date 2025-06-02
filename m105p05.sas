/*************************************
* Validating Parameters: Practice #5 *
*************************************/

%macro stormchart(basin, season);
title1 "Storm Frequency by Type";
title2 "&basin Basin, &season Season";
proc sgplot data=mc1.storm_final noborder;
	vbar StormType / filltype=gradient;
    where Basin="&basin" and Season=&season;
    yaxis grid;
run;
title;
%mend stormchart;

%stormchart(NA,2015)


%macro stormchart(basin, season) / minoperator;
proc sql;
	select min(season), max(season) into :minseason trimmed, :maxseason trimmed
	from mc1.storm_final;
quit;
%if &season>=&minseason and &season<=&maxseason %then %do;
	proc sql noprint;
		select basin into :basinlist separated by " " from mc1.storm_basin_codes;
	quit;
%end;
%else %do;
	%put ERROR: Valid Seasons are between &minSeason and &maxSeason;
%end;
%if &basin in &basinlist %then %do;
	title1 "Storm Frequency by Type";
	title2 "&basin Basin, &season Season";
	proc sgplot data=mc1.storm_final noborder;
		vbar StormType / filltype=gradient;
    	where Basin="&basin" and Season=&season;
    	yaxis grid;
	run;
	title;
%end;
%else %do;
	%put ERROR: &basin is an invalid basin code. Basin codes include &basinlist..;
%end;
%mend stormchart;

%stormchart(EP,2010)