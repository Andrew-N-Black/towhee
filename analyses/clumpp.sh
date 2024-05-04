 #Copy qopt files for each run into individual directories
 cp ../../ADX/R_{1..10}/*K3*.qopt ./
 cp ../../ADX/R_{1..10}/*K4*.qopt ./
 cp ../../ADX/R_{1..10}/*K5*.qopt ./
 
 #For each directory, add two additional columns for distruct
 for i in `ls -1 *qopt` ; do  paste pre $i post > $i.Q; done
 
 #merge each Q file for each K
 cat *Q > pop_K5_combined.txt
 cat *Q > pop_K4_combined.txt
 cat *Q > pop_K3_combined.txt
 
 module load CLUMPP/1.1.2
 CLUMPP
 
 
 
 DATATYPE 1 
INDFILE NOTNEEDED.indfile 
POPFILE pop_K5_combined.txt 
OUTFILE pop_K5-combined-merged.txt 
MISCFILE pop_K5-combined-miscfile.txt 
K 5 
C 81 
R 10 
M 2 
W 0 
S 2 
GREEDY_OPTION 2 
REPEATS 20 
PERMUTATIONFILE NOTNEEDED.permutationfile 
PRINT_PERMUTED_DATA 1 
PERMUTED_DATAFILE pop_K5-combined-aligned.txt 
PRINT_EVERY_PERM 0 
EVERY_PERMFILE pop_K5-combined.every_permfile 
PRINT_RANDOM_INPUTORDER 0 
RANDOM_INPUTORDERFILE pop_K3-combined.random_inputorderfile 
OVERRIDE_WARNINGS 0 
ORDER_BY_RUN 0 


 
 
