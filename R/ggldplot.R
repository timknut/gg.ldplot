#' Make full partial martix. For internal use.
#'
#' @param x A vcftools ld data.frame
#'
#' @import dplyr
#' @import ggplot2
#' @import assertthat
#'
#' @return a data.frame
#' @export
#'
#' @examples
make_full_dl_matrix <- function(x) {
  assert_that(is.data.frame(x))
  chrom <- unique(x$CHR)
  new_df <- dplyr::data_frame(
    CHR = chrom,
    POS1 = unique(x$POS1),
    POS2 = unique(x$POS1),
    N_CHR = unique(x$N_CHR),
    R.2 = 1,
    D = NA,
    Dprime = NA
  )
  names(new_df)[5] <- "R.2"
  names(x)[5] <- "R.2"
  new_df <- dplyr::bind_rows(x, new_df)
  new_df <- dplyr::arrange(new_df, POS1, POS2)
  new_df
}

#' Plot LD matrix heatmap
#'
#' @param x vcftools ld data.frame
#' @param simplify.labels Logical. Should labels be simplified? For big data sets.
#'
#' @return a ld plot
#' @export
#'
#' @examples
#' data("bovine_vcf")
#' plot_LDmatrix(bovine_vcf)
plot_LDmatrix <- function(x, simplify.labels = FALSE) {
  p1 <- ggplot(make_full_dl_matrix(x),
               aes(as.factor(POS1), as.factor(POS2))) +
    geom_raster(aes(fill = R.2)) +
    scale_fill_gradient(low = "white", high = "black") +
    theme_classic() +
    theme(
      axis.text.x = element_text(angle = 30, vjust = 0.5),
      axis.title = element_blank(),
      axis.text = element_text(size = 8),
      axis.line = element_blank()#,
      #legend.position = c(0.15, 0.8)
      # legend.direction = "horizontal"
    ) + coord_flip()
  if(simplify.labels){
    p1 + set_labels(x) +
      theme(axis.ticks.y = element_blank(),
            axis.text.y = element_blank())
  } else {
  p1
    }
}


#' Set pretty labels. For internal use.
#'
#' @param x a data frame
#'
#' @return a ggplot scale object.
#' @export
#'
#' @examples
set_labels <- function(x){
  df1 <- make_full_dl_matrix(x)
  bp_pos <- levels(factor(df1$POS1))
  p.index <- pretty(dense_rank(bp_pos))
  bp_pos <- na.omit(bp_pos[p.index])
  scale_y_discrete(labels = bp_pos, breaks = bp_pos)
}

