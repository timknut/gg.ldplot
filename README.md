# gg.ldplot
Plot a pairwise LD matrix from vcftools with ggplot2

## Install
```{R}
# library(devtools)
install_github("timknut/gg.ldplot")
```

## vcftools
Create the input data.frame with [vcftools](https://vcftools.github.io/index.html) from a *phased* vcf with eg:

```{sh}
vcftools --gzvcf phased_vcf.vcf.gz --out bovine_vcf --hap-r2
```
**WARNING** vcftools outputs a malformatted table. Fix it with `sed -i "s/\s*$// bovine_vcf.ld"`

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

