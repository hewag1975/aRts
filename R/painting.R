#' Create a painting from a picture
#'
#' @details
#' This function takes an image and applies the concept of superpixels as
#' implemented in the [supercells](https://github.com/Nowosad/supercells)
#' package to get a painting like representation.
#'
#' @param x, object of class `stars`, the picture to be processed.
#' @param ... further arguments passed to `supercells()`
#'
#' @return
#' Object of class `sf` containig the boundaries of the supercells and the
#' average hex color value.
#'
#' @examples
#' data(pic)
#' ptg = painting(pic)
#' par(mfrow = c(1, 2))
#' plot(pic, rgb = 1:3)
#' plot(ptg, rgb = 1:3)
#'
#' @importFrom sf st_drop_geometry
#' @importFrom stars read_stars
#' @importFrom supercells supercells
#'
#' @export
painting = function(
    x
    , ...
){

    stopifnot(
        "'x' needs to be of class 'stars'!" = {
            inherits(x, "stars")
        }
    )

    sc_args = c(list(x = x), list(...))
    if (!"k" %in% names(sc_args)) {
        sc_args = c(list(k = 2000), sc_args)
    }
    if (!"compactness" %in% names(sc_args)) {
        sc_args = c(list(compactness = 10), sc_args)
    }

    sc = do.call("supercells", args = sc_args)
    sc$col = rgb2hex(sf::st_drop_geometry(sc[4:6]))

    return(
        subset(
            sc
            , select = c("col", "geometry")
        )
    )

}

#' function to create hex color values from RGB
rgb2hex = function(x){
    apply(
        x
        , MARGIN = 1
        , \(x) rgb(x[1], x[2], x[3], maxColorValue = 255)
    )
}



# jpeg(
#     "img/fichtel_sc.jpg"
#     , width = dim(img)[1]
#     , height = dim(img)[2]
#     , units = "px"
# )
# plot(
#     st_geometry(sc)
#     , border = NA
#     , col = avg_colors
# )
# dev.off()

