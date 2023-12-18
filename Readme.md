# Sentinel lymph node fingerprinting
This is the code to the paper [Sentinel lymph node fingerprinting](http://iopscience.iop.org/10.1088/1361-6) (Physics in Medicine and Biology 2019).

## Create Matrix Ao
`createA/noWallsR3/saveA` 
create matrix for R3 (non-symetric collimator. Rest is similar)
* Step 1) saveA.m
* Step 2) createA.m
* Step 3) createA_2.m

`createA/optimal_design_withWallsN_vs_noWallsR3` 
 creates table 1. 
* Warning: Creating new sources will create new numbers of the table!
    * use auswerten.m to get the number for Table 1.
    * use vergleichen.m to get error100.mat
* Warning: using createDifferentSource.m will change source.mat and you get different numbers.


## Evaluating the measurments
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
* copy the matrix `Ao.mat` created in `createA/noWallsR3/saveA` into the folder `fingerprinting/R3`
* execute `lowpassfiltDict.m` to create from `Ao.mat` the matrix `DictLLN.mat`
* execute `fingerprinting.m` to get the 3D contstruction from all the pattern in the folder `image_bearbeitet` which are saved in `SOURCE_LL.mat`
* execute `auswerten.m` to save the error in the matrix `error.mat`


* **Note:** This is done for *noWallsN*, *R3*, and *withWallsN*.

#### Data
Please contact *Prof. Dr. Philippe C. Cattin* (philippe.cattin@unibas.ch) to access the data
 
The RAW data
* https://dbe-lakefs.dbe.unibas.ch/repositories/moonstar-slnf/main

Processed data
* https://dbe-lakefs.dbe.unibas.ch/repositories/moonstar-slnf/objects?ref=slnf&path= (Branch slnf)
* copy the folder `image_bearbeitet` into `fingerprinting/R3`
* `cutter.m` has the different parameters for the preprocessing of the data

## Plotting the error
`error_sym_vs_nonsym` fingerprintL2_new.m creates Figure 14
* copy the matrix `SOURCE_LL.mat` from `fingerprinting` and executing `auswerten.m` will give you the error
* plotting the erros was hardcoded from the results from `auswerten.m`

## Optimal Design
`optimal_design`
Visualize Figure 5

`createA/noWallsR3/optimal_design`
* create values for the optimal design


## Other
`functionalC`
This creates Figure 8 
