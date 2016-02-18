# gg.ldplot
Plot a LD data.frame from vcftools with ggplot2

## Install
```{R}
# library(devtools)
install_github("timknut/gg.ldplot")
```

## vcftools
The input data.frame could be created with [vcftools](https://vcftools.github.io/index.html) from a phased vcf with eg:

```{sh}
vcftools --gzvcf example_LD_haploview_10_snps_beagle.vcf.gz --out ld_test_10SNPs --hap-r2
```

## Example

`plot_LDmatrix(ld_test_10SNPs.hap)`

![Example plot](/data/Rplot.png)

