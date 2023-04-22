Conservation genomics of California towhee (Melozone crissalis) relative to the official list of endangered and threatened wildlife


Andrew N. Black, Jong Yoon Jeon, Chris McCreedy, Safia Janjua, Erangi J Heenkenda, Samarth Mathur, Elise Ferree, Amy L. Fesnock-Parker, Alvaro Hernandez, and J. Andrew DeWoody



Scripts used in each subcategory listed in the manuscript, corresponds to the structure below:

"Reference genome sequencing, assembly, and annotation"
-assembly_safia.sh

"Whole genome resequencing"
-processing/ref_format.sh
-processing/alignment.sh

"Spatial patterns of gene flow"
-analyses/fst-sites.sh
-analyses/fst-sitesF.sh
-analyses/fst-sitesM.sh
-analyses/omni_config.ini
-analyses/towhee_omni.jl
-analyses/towhee_omni.sh
-analyses/towhee_rga.sh

"Genomic diversity"
-analyses/het.sh
-analyses/ROH.sh

"Population structure and differentiation"
-processing/beagle.sh
-analyses/pca.sh
-analyses/admixture.sh
-analyses/clumpp.sh
-analyses/fst.sh
-processing/cleaning_safia.sh
-analyses/bcfcall.sh
-analyses/nu_tree.sh
-analyses/mt_tree.sh

"plotting / summary statistics"
-R/*.R











