# =============================================================================
# PAIRWISE RELATEDNESS: join sample IDs onto ngsRelate index pairs
# ngsRelate reports relatedness statistics keyed by numeric sample indices
# (a, b); this script maps those indices back to sample names by merging
# against the per-region sample list, one region at a time.
# =============================================================================

OREG <- read_excel("OREG.xlsx")
head(OREG)

# A tibble: 6 × 3
      a     b SAMP 
  <dbl> <dbl> <chr>
1     0     0 C_10 
2     1     1 C_11 
3     2     2 C_12 
4     3     3 C_13 
5     4     4 C_14 
6     5     5 C_1  

     
#Read in results from ngsrelate
OREGresults <- read.delim("~/OREGresults")

#Perform innerjoin on index a to attach the sample name for individual "a"
OREG_a <- merge(x=OREG,y=OREGresults,
+              by="a")

#Save output file to modify column headers
write.csv(OREG_a,"~/OREG_a.csv")

#Change first three headers to "a"	"SAMP.A"	"b" (manual edit step before reloading)
OREG_a <- read.csv("~/OREG_a.csv")

# Now merge index b to attach the sample name for individual "b" as well
OREG_ab <- merge(x=OREG,y=OREG_a,
+              by="b")
#Save fully-labeled pairwise relatedness table
> write.csv(OREG_ab,"~/OREG_ab.csv")

#Perform same sequence with other Regions (CCAL, INYO, SCAL)
