/* -------------------------------------------------------------------------- *
 * Adapted from utl-altair-slc-bare-bones-code-kaplan-meit-plot-using-r-       *
 * packages-kaplan-meier-curves.sas                                           *
 *                                                                            *
 * The original assigns  libname kmp sas7bdat "d:/kmp";  and inspects the     *
 * survival dataset kmp.sample_50000 (Year / time_to_event / Census).         *
 * Here the libname to a local Windows path is replaced by an inline DATA     *
 * step holding a small sample of that same dataset, so the original          *
 * PROC CONTENTS and PROC PRINT steps run unchanged.                          *
 * -------------------------------------------------------------------------- */

options validvarname=v7;

/* survival sample (Year, time_to_event, Census) spanning 2014-2017 */
data sample_50000;
    input Year time_to_event Census;
    datalines;
2014 0 0
2014 60 0
2014 170 0
2014 270 0
2014 355 0
2015 0 0
2015 60 0
2015 170 0
2015 270 0
2015 355 1
2016 0 1
2016 60 0
2016 170 0
2016 270 0
2016 355 0
2017 0 1
2017 60 1
2017 170 1
2017 270 0
2017 355 0
;
run;

/* --- original inspection steps, run against the sample --- */

proc contents data=sample_50000 position;
run;

proc print data=sample_50000(obs=3);
run;

proc print data=sample_50000(firstobs=18);
run;
