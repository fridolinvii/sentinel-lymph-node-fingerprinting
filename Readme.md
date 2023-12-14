# Sentinel lymph node fingerprinting
This is the code to the paper [Sentinel lymph node fingerprinting](http://iopscience.iop.org/10.1088/1361-6) (Physics in Medicine and Biology 2019).


`optimal_design`
Visualize Figure 5

`functionalC`
This creates Figure 8 

`error_sym_vs_nonsym`
fingerprintL2_new.m creates Figure 14

`fingerprinting/R3`
auswerten.m : Table 2
* for t={2,32} (we use here t=2 and t=32 instead of t=1 and t=16, to compare it better with the results from the with septum walls Collimator. At the point of measurement, it had two times the radioactive strength than during the measurment with the R3 collimator. Therefore, two compare the results the expose time of 1s with the first collimator is the same as if 2s with the R3 collimator
	* #1 error{t,1}.err
	* #2 error{t,5}.err
	* #3 error{t,8}.err
	* #4 error{t,4}.err
	* #5 error{t,7}.err
	* #6 error{t,6}.err
	* #7 error{t,9}.err

`createA/optimal_design_withWallsN_vs_noWallsR3`
* creates table 1. 
* Warning: Creating new sources will create new numbers of the table!
    * use auswerten.m to get the number for Table 1.
    * use vergleichen.m to get error100.mat
* Warning: using createDifferentSource.m will change source.mat and you get different numbers.


`createA/noWallsR3/saveA`
* create matrix for R3 (non-symetric collimator. Rest is similar)
* Step 1) saveA.m
