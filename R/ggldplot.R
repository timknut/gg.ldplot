#' Make full partial martix
#'
#' @param x A vcftools ld data.frame
#'
#' @import dplyr
#' @import ggplot2
#'
#' @return a data.frame
#' @export
#'
#' @examples
make_full_dl_matrix <- function(x) {
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
  new_df <- dplyr::bind_rows(x, new_df)
  new_df <- dplyr::arrange(new_df, POS1, POS2)
}

#' Plot LD matrix heatmap
#'
#' @param x vcftools ld data.frame
#'
#' @import dplyr
#' @import ggplot2
#'
#' @return a ld plot
#' @export
#'
#' @examples
plot_LDmatrix <- function(x) {
  p1 <- ggplot(make_full_dl_matrix(x),
               aes(as.factor(POS1), as.factor(POS2))) +
    geom_tile(aes(fill = R.2), colour = "grey") +
    scale_fill_gradient(low = "white", high = "black") +
    theme_classic() +
    theme(
      axis.text.x = element_text(angle = 30, vjust = 0.5),
      axis.title = element_blank(),
      axis.text = element_text(size = 8)
    ) +
    coord_flip()
  p1
}
