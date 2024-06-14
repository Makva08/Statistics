***********************************************************;
*  Using a Library to Read Excel Files                    *;
***********************************************************;
*  Syntax and Example                                     *;
*                                                         *;
*    OPTIONS VALIDVARNAME=V7;                             *;
*    LIBNAME libref xlsx "path/file.xlsx";                *;
*    LIBNAME libref CLEAR;                                *; 
***********************************************************;

options validvarname=v7;
libname xlclass xlsx "S:/workshop/data/class.xlsx";

*other examples;
*libname xlclass xlsx "c:/workshop/data/class.xlsx";
*libname xlclass xlsx "c:/workshop/PG1/data/class.xlsx";

libname xlclass clear;

***********************************************************;
*  Demo                                                   *;
*    1) Open the STORM.XLSX file in Excel to view the     *;
*       data. Notice that, in the STORM_SUMMARY           *;
*       worksheet, there are spaces in the Hem NS and Hem *;
*       EW column headings. Close the Excel file after    *;
*       you finish viewing it.                            *;
*    2) Complete the OPTIONS statement to ensure that     *;
*       column names follow SAS naming conventions.       *;
*    3) Complete the LIBNAME statement to define a        *;
*       library named XLSTORM that connects to the        *;
*       STORM.XLSX workbook.                              *;
*    4) Highlight the OPTIONS and LIBNAME statements and  *;
*       run the selected code. Use the navigation pane to *;
*       find the XLSTORM library. Open the STORM_SUMMARY  *;
*       table. Notice Hem_NS and Hem_EW columns include   *;
*       underscores. Close the STORM_SUMMARY table.       *;
*    5) Modify the PROC CONTENTS statement to read the    *;
*       STORM_SUMMARY table in the XLSTORM library.       *;
*    6) Add a statement to clear the XLSTORM library.     *;
*       Highlight the PROC step and the last LIBNAME      *;
*       statement and run the selected code.              *;
***********************************************************;

*Complete the OPTIONS statement;
options validvarname=v7;

*Complete the LIBNAME statement;
*Update the path if necessary;

libname xlstorm xlsx "s:/workshop/data/storm.xlsx";  

*Complete the DATA= option to reference the STORM_SUMMARY worksheet;
proc contents data=xlstorm.storm_summary;
run;

*Clear the XLSTORM library;
libname xlstorm clear;
