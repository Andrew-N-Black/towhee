for i in `echo "CCAL SCAL OREG INYO"`
do 
grep -v 'nan' $i.allSNPs.ld > $i.allSNPs.LD
shuf $i.allSNPs.LD | split -l 1000 -a 3 - shuff/$i --additional-suffix=.txt --numeric-suffixes=1 --verbose
done
