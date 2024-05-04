
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

#Perform innerjoin on index a
OREG_a <- merge(x=OREG,y=OREGresults, 
+              by="a")

#Save output file to modify column headers
write.csv(OREG_a,"~/OREG_a.csv")

#Change first three headers to "a"	"SAMP.A"	"b"
OREG_a <- read.csv("~/OREG_a.csv")

# Now merge index b
OREG_ab <- merge(x=OREG,y=OREG_a, 
+              by="b")
#Save
> write.csv(OREG_ab,"~/OREG_ab.csv")

#Perform same sequence with other Regions
