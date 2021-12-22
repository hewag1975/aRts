## code to prepare sample datasets goes here

## autumn
ifl = "~/Pictures/images/autumn.jpg"
autumn = stars::read_stars(ifl)
names(autumn) = "Autumn forest"
sf::st_crs(autumn) = 3035

usethis::use_data(autumn, overwrite = TRUE)

## mountains
ifl = "~/Pictures/images/mountains_2.jpg"
mountains = stars::read_stars(ifl)
names(mountains) = "Mountains"
sf::st_crs(mountains) = 3035

usethis::use_data(mountains, overwrite = TRUE)
