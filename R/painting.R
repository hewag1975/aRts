#' Create a painting from a picture using supercells
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
#' Object of class `sf` containing the boundaries of the supercells and the
#' average hex color value.
#'
#' @examples
#' data(autumn)
#' ptg = painting(pic)
#' par(mfrow = c(1, 2))
#' plot(pic, rgb = 1:3)
#' plot(ptg)
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

    sc = subset(sc, select = c("col", "geometry"))
    structure(sc, class = c("sf_paint", class(sc)))

}

#' Create hex color values from RGB
#'
#' @param x, `matrix` or `data.frame` of rgb color values.
#'
#' @return
#' A `character` vector of hex color values
#'
rgb2hex = function(x){
    apply(
        x
        , MARGIN = 1
        , \(x) rgb(x[1], x[2], x[3], maxColorValue = 255)
    )
}

#' Plot object of class `sf_paint`
#'
#' @param x, object of class `sf_paint`.
#' @param col, vector of color values. Defaults to the hexcolor column
#'   attached when running `painting()`.
#'
#' @importFrom sf st_geometry
#'
#' @export
plot.sf_paint = function(
    x
    , col = x$col
    , ...
){
    plot(
        sf::st_geometry(x)
        , border = NA
        , col = col
        , ...
    )
}
