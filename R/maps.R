#' Helper function creating a list of OSM features to be queries
#'
#' @param x, object of class `stars`, the picture to be processed.
#' @param ... further arguments passed to `supercells()`
#'
#' @return
#' A nested `list` with layers and key-value-lists per layer.
#'
#' @examples
#' FeatureList(maptype = "building")
#' FeatureList(maptype = "street")
#' FeatureList(maptype = NULL, layers = c("buildings"))
#'
#' @export
FeatureList = function(
    maptype = "building"
    , layers = NULL
){

    ## argument checks
    match.arg(
        maptype
        , choices = c("building", "street")
        , several.ok = FALSE
    )

    match.arg(
        layers
        , choices = c(
            "buildings"
            , "roadsMajor"
            , "roadsMinor"
            , "roadsSmall"
            , "rivers"
            , "railways"
        )
        , several.ok = TRUE
    )

    if (!is.null(maptype) & !is.null(layers)) {
        warning("'maptype' is specified, 'layers' will be ignored!")
    }

    if (is.null(maptype)) {
        stopifnot(
            "'layers' must be a character vector!" = {
                inherits(layers, what = "character")
            }
        )
    }

    ## default layers for maptypes "building", "street"
    if (!is.null(maptype)) {
        layers = switch(
            maptype
            , "building" = c(
                "buildings"
                , "roadsMajor"
                , "roadsMinor"
                , "rivers"
                , "railways"
            )
            , "street" = c(
                "roadsMajor"
                , "roadsMinor"
                , "roadsSmall"
                , "rivers"
                , "railways"
            )
        )
    }

    ## create feature list
    mapply(
        \(l){
            switch(
                l
                , "buildings" = FeatureBuildings()
                , "roadsMajor" = FeatureRoadsMajor()
                , "roadsMinor" = FeatureRoadsMinor()
                , "roadsSmall" = FeatureRoadsSmall()
                , "rivers" = FeatureRivers()
                , "railways" = FeatureRailways()
            )
        }
        , l = layers
        , SIMPLIFY = FALSE
        , USE.NAMES = TRUE
    )

}

#' Functions to create key-value-lists per layer
FeatureBuildings = function(){
    list(
        key = "building"
        , values = c(
            "apartments"
            , "commercial"
            , "detached"
            , "house"
            , "residential"
            , "retail"
            , "semidetached_house"
            , "terrace"
            , "yes"
        )
    )
}

FeatureRoadsMajor = function(){
    list(
        key = "highway"
        , values = c(
            "motorway"
            , "motorway_link"
            , "motorway_junction"
            , "primary"
            , "primary_link"
            , "trunk"
        )
    )
}

FeatureRoadsMinor = function(){
    list(
        key = "highway"
        , values = c(
            "secondary"
            , "tertiary"
            , "secondary_link"
            , "tertiary_link"
        )
    )
}

FeatureRoadsSmall = function(){
    list(
        key = "highway"
        , values = c(
            "residential"
            , "living_street"
            , "unclassified"
            , "service"
            , "footway"
            , "corridor"
            , "bridleway"
        )
    )
}

FeatureRivers = function(){
    list(
        key = "waterway"
        , values = c(
            "river"
        )
    )
}

FeatureRailways = function(){
    list(
        key = "railway"
        , values = c(
            "rail"
        )
    )
}
