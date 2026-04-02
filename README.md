# utl-altair-slc-bare-bones-code-kaplan-meit-plot-using-r-packages-kaplan-meier-curves
    %let pgm=utl-altair-slc-bare-bones-code-kaplan-meit-plot-using-r-packages-kaplan-meier-curves;

    %stop_submission;

    Altair slc bare bones code kaplan meit plot using r packages kaplan meier curves

    Too long to post on a list, see github
    https://github.com/rogerjdeangelis/utl-altair-slc-bare-bones-code-kaplan-meit-plot-using-r-packages-kaplan-meier-curves

    graph output
    https://github.com/rogerjdeangelis/utl-altair-slc-bare-bones-code-kaplan-meit-plot-using-r-packages-kaplan-meier-curves/blob/main/survival

    Altair Community Rapidminer
    https://community.altair.com/discussion/43716/survival-analysis-in-rapid-miner?tab=all

    /*               _     _
     _ __  _ __ ___ | |__ | | ___ _ __ ___
    | `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
    | |_) | | | (_) | |_) | |  __/ | | | | |
    | .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
    |_|
    */

    * CREATE THIS YEARLY SURVIVAL RATE

    /**************************************************************************************************************************/
    /*                           Days to Infection by Year                                                                    */
    /*                                   DAYS                                                                                 */
    /*        0      60      120     180     240     300     360                                                              */
    /*  SURV --+-------+-------+-------+-------+-------+-------+--------------+ PROB INFECTION FREE DAYS                      */
    /*   1.0 + +===+---+-------+                                              | 1.0                                           */
    /*       | |   |   |       |                                              |                                               */
    /*   0.9 + |   |   |       |     2014                                     + 0.9                                           */
    /*       | |   |   +---+   +---------------------+                        |                                               */
    /*   0.8 + |   |       |                         |                        + 0.8                                           */
    /*       | |   +---+   +-------+                 +------------------------|                                               */
    /*   0.7 + +---+   |           |                                          + 0.7                                           */
    /*       |     |   |           |                                          |                                               */
    /*   0.6 +     |   |           |                                          + 0.6                                           */
    /*       |     |   |           | 2015                                     |                                               */
    /*   0.5 +     |   +-------+   +---------------+                          + 0.5                                           */
    /*       |     +           |                   |                          |                                               */
    /*   0.4 +     +--------+  |                   +--------------------------+ 0.4                                           */
    /*       |              |  |                                              |                                               */
    /*   0.3 +              |  |     2016                                     + 0.3                                           */
    /*       |              |  +----------------------+                       |                                               */
    /*   0.2 +              |                         |                       + 0.2                                           */
    /*       |              |                         +-----------------------|                                               */
    /*   0.1 +              |        2017                                     + 0.1                                           */
    /*       |              +-------------------------------------------------|                                               */
    /*   0.0 +                                                                + 0.0                                           */
    /*       |                                                                |                                               */
    /*       --+-------+-------+-------+-------+-------+-------+--------------+                                               */
    /*         0      60      120     180     240     300     360                                                             */
    /*                               DAYS                                                                                     */
    /* Note: (does not apply to the kaplan meir lines above)                                                                  */
    /*                                                                                                                        */
    /* In a clinical trial with a fixed follow-up period of 365 days,                                                         */
    /* if no patients have follow-up beyond 365 days,                                                                         */
    /* then all patients are censored at 360 days and the                                                                     */
    /* "Number at Risk" would be 0 at 360 days.                                                                               */
    /**************************************************************************************************************************/

    PREPARATION
    -----------

      Very important make sure
      options valivarname=v7; /*--- many language and linux are case sensitive, a huge nightmare ---*/

      Create Folder
          d:/kmp
          d/kmp/pdf
      Download
          download and unzip the self extracting 7zip file, sample_50000.exe
          into
          d:/kmp/kmp.sample_50000
      A csv is alxo available in this repo


    Related Repos
    ------------------------------------------------------------------------------------------------------------------------------------------
    https://github.com/rogerjdeangelis/utl-altair-slc-kaplan-meir-survival-with-bells-and-whistles-r-survival-package
    https://github.com/rogerjdeangelis/utl-Grays-test-in-survival-analysis-cumulative-p-value
    https://github.com/rogerjdeangelis/utl-simple-clinical-survival-plot-using-r-packages-kaplan-meier-curves
    https://github.com/rogerjdeangelis/utl-worst-case-median-survival-sas-quantlife-and-r-quantreg-with-confidence-intervals-and-censoring
    https://github.com/rogerjdeangelis/utl_slopegarphs_and_5_10_15_20_year_survival_rates

    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    download and unzip the self extracting 7zip file, sample.exe
    place in d:/kmp/sample.exe
    */


    libname kmp sas7bdat "d:/kmp";
    options validvarname=v7;

    proc contents data=kmp.sample_50000 position;
    run;

    proc print data=kmp.sample_50000(obs=3);run;
    proc print data=kmp.sample_50000(firstobs=199998);run;


    /**************************************************************************************************************************/
    /*   Altair SLC  d:/kmp/sample_50000.sas7bat                                                                              */
    /*                                                                                                                        */
    /*      Obs    Year time_to_event Censu                                                                                   */
    /*                                                                                                                        */
    /*        1    2014        0         0                                                                                    */
    /*        2    2014        0         1                                                                                    */
    /*        3    2014        0         1                                                                                    */
    /*    ...                                                                                                                 */
    /*   199998    2017      359         0                                                                                    */
    /*   199999    2017      359         0                                                                                    */
    /*   200000    2017      359         0                                                                                    */
    /*                                                                                                                        */
    /*                                                                                                                        */
    /*   The CONTENTS Procedure                                                                                               */
    /*                                                                                                                        */
    /*   Data Set Name           SAMPLE_50000                                                                                 */
    /*   Member Type             DATA                                                                                         */
    /*   Engine                  SAS7BDAT                                                                                     */
    /*   Created                 01APR2026:13:30:49                                                                           */
    /*   Last Modified           01APR2026:13:30:49                                                                           */
    /*   Observations            200,000                                                                                      */
    /*   Variables               3                                                                                            */
    /*   Indexes                 0                                                                                            */
    /*   Observation Length      24                                                                                           */
    /*   Deleted Observations    0                                                                                            */
    /*   Data Set Type                                                                                                        */
    /*   Label                                                                                                                */
    /*   Compressed              NO                                                                                           */
    /*   Sorted                  NO                                                                                           */
    /*   Data Representation     WINDOWS_64                                                                                   */
    /* n Encoding                wlatin1 Windows-1252 Wester                                                                  */
    /*                                                                                                                        */
    /*              Engine/Host Dependent Information                                                                         */
    /*                                                                                                                        */
    /*   Data Set Page Size          65536                                                                                    */
    /*   Number of Data Set Pages    74                                                                                       */
    /*   First Data Page             1                                                                                        */
    /*   Max Obs Per Page            2715                                                                                     */
    /*   Obs In First Data Page      2660                                                                                     */
    /* 7bFile Name                   d:\kmp\sample_50000.sasdat                                                               */
    /*   Release Created             9.0401M7                                                                                 */
    /*   Host Created                X64_10PRO                                                                                */
    /*                                                                                                                        */
    /* er   List of Variables and Attributes in Creation Ord                                                                  */
    /*                                                                                                                        */
    /*   Number    Variable         Type  Len  Pos                                                                            */
    /*   _________________________________________                                                                            */
    /*        1    Year             Num     8    0                                                                            */
    /*        2    time_to_event    Num     8    8                                                                            */
    /*        3    Census           Num     8   16                                                                            */
    /*                                                                                                                        */
    /*   Altair SLC  d:/kmp/sample_50000.sas7bat                                                                              */
    /*                                                                                                                        */
    /*      Obs    Year time_to_event Censu                                                                                   */
    /*                                                                                                                        */
    /*        1    2014        0         0                                                                                    */
    /*        2    2014        0         1                                                                                    */
    /*        3    2014        0         1                                                                                    */
    /*    ...                                                                                                                 */
    /*  199,998    2017      359         0                                                                                    */
    /*  199,999    2017      359         0                                                                                    */
    /*  200,000    2017      359         0                                                                                    */
    /**************************************************************************************************************************/

    /*
     _ __  _ __ ___   ___ ___  ___ ___
    | `_ \| `__/ _ \ / __/ _ \/ __/ __|
    | |_) | | | (_) | (_|  __/\__ \__ \
    | .__/|_|  \___/ \___\___||___/___/
    |_|
    */

    options validvarname=v7;

    libname kmp sas7bdat "d:/kmp";
    libname workx sas7bdat "d:/wpswrkx";  /*--- put in autoexec ---*/

    proc datasets lib=workx kill;
    run;quit;

    %utlfkil(d:/pdf/survival.pdf); /*--- kaplan meir plot ---*/

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=kmp.sample_50000 r=sample_5000;
    submit;
    # Create plot object
    p <- survminer::ggsurvplot(
      survival::survfit(survival::Surv(time_to_event, Census) ~ Year, data=sample_5000),
      palette=c("red", "blue", "green", "orange"),
      surv.median.line = "hv"
    )

    # Save directly without pdf()/dev.off()
    ggplot2::ggsave("d:/pdf/survival.pdf", plot = p$plot, height=8, width=10)
    endsubmit;
    run;

    /**************************************************************************************************************************/
    /* ONLY OUTPUT                                                                                                            */
    /* d:/pdf/survival.pdf                                                                                                    */
    /**************************************************************************************************************************/

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    1                                          Altair SLC        08:26 Thursday, April  2, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp

    NOTE: Library worksas assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\worksas

    NOTE: Library workwpd assigned as follows:
          Engine:        WPD
          Physical Name: d:\workwpd


    LOG:  8:26:58
    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.031
          cpu time  : 0.000


    NOTE: AUTOEXEC processing completed

    1         options validvarname=v7;
    2
    3         libname kmp sas7bdat "d:/kmp";
    NOTE: Library kmp assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\kmp

    4         libname workx sas7bdat "d:/wpswrkx";  /*--- put in autoexec ---*/
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx


    Altair SLC

    The DATASETS Procedure

             Directory

    Libref           WORKX
    Engine           SAS7BDAT
    Physical Name    d:\wpswrkx
    5
    6         proc datasets lib=workx kill;
    NOTE: No matching members in directory
    7         run;quit;
    NOTE: Procedure datasets step took :
          real time : 0.015
          cpu time  : 0.000


    8
    9         %utlfkil(d:/pdf/survival.pdf); /*--- kaplan meir plot ---*/
    10
    11        options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    12        proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    13        export data=kmp.sample_50000 r=sample_5000;
    NOTE: Creating R data frame 'sample_5000' from data set 'KMP.sample_50000'

    14        submit;
    15        # Create plot object
    16        p <- survminer::ggsurvplot(
    17          survival::survfit(survival::Surv(time_to_event, Census) ~ Year, data=sample_5000),
    18          palette=c("red", "blue", "green", "orange"),
    19          surv.median.line = "hv"
    20        )
    21        str(p)
    22        # Save directly without pdf()/dev.off()
    23        ggplot2::ggsave("d:/pdf/survival.pdf", plot = p$plot, height=8, width=10)
    24        endsubmit;

    NOTE: Submitting statements to R:

    > # Create plot object
    > p <- survminer::ggsurvplot(
    +   survival::survfit(survival::Surv(time_to_event, Census) ~ Year, data=sample_5000),
    +   palette=c("red", "blue", "green", "orange"),
    +   surv.median.line = "hv"
    + )
    > str(p)
    > # Save directly without pdf()/dev.off()
    > ggplot2::ggsave("d:/pdf/survival.pdf", plot = p$plot, height=8, width=10)

    NOTE: Processing of R statements complete

    25        run;
    NOTE: Procedure r step took :
          real time : 5.528
          cpu time  : 0.093


    26
    27
    28
    29
    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 5.654
          cpu time  : 0.218

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
