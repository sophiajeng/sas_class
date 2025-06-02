ods graphics;

proc ttest data=STAT1.german plots(shownull)=interval;
    class group;
    var change;
    format group $NoYes.;
    title "Two-Sample t-test Comparing Treatment Group: No vs Yes";
run;

title;
