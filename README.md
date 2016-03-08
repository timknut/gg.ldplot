# gg.ldplot
Plot a pairwise LD matrix from vcftools with ggplot2

## Install with devtools
```{R}
# library(devtools)
install_github("timknut/gg.ldplot")
```

## Run without dependencies on the CIGENE cluster
`module load R/3.2.3`

**Example R-script.** This will make a *.png with your plot in working dir.
```{R}
.libPaths( c( .libPaths(), "/mnt/users/tikn/R/x86_64-pc-linux-gnu-library/3.2")) ## Dependencies
library(gg.ldplot, lib.loc = "/mnt/users/tikn/R/x86_64-pc-linux-gnu-library/3.2")
data("bovine_vcf")
png("test_LD.png")
plot_LDmatrix(bovine_vcf)
dev.off()
```

## vcftools
Create the input data.frame with [vcftools](https://vcftools.github.io/index.html) from a *phased* vcf with eg:

```{sh}
vcftools --gzvcf phased_vcf.vcf.gz --out bovine_vcf --hap-r2
```
**WARNING** vcftools outputs a malformatted table. Fix it with `sed -i "s/\s*$//" bovine_vcf.ld"`

Now read the file into R.
```{R}
bovine_vcf <- read.table("bovine_vcf.ld", header = TRUE, stringsAsFactors = F)
```

## Example
The package includes a small example dataset.

```{R}
data("bovine_vcf")
plot_LDmatrix(bovine_vcf)
```

![Example plot](/data/Rplot.png)

