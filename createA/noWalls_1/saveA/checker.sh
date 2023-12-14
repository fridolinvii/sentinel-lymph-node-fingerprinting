#!/bin/bash

#create Backup

mkdir out
touch out/zl.txt; touch out/zl.txt;

mv out/zl.txt  out/zl.old.txt
mv out/numberOfHoles.txt  out/numberOfHoles.old.txt 


#check which elements we have, and which ones need to be calculated again

counter=0
touch  out/zl.txt out/numberOfHoles.txt 
 for numberOfHoles in {1..24}; do
    for zl in {1..180}; do
        FILE=A/Ao/A/A_$numberOfHoles'_'$zl.mat
        if [ ! -f $FILE ]; then 
	  	#echo $w/$r'_'$n/A/$k'_'$z.mat >> file.txt
		let counter+=1
		echo $zl >> out/zl.txt
		echo $numberOfHoles >> out/numberOfHoles.txt
          fi
        done
      done
    
touch out/counter.txt
echo $counter > out/counter.txt
cat out/counter.txt
