## code to prepare sample datasets goes here

## autumn
ifl = "~/Pictures/images/pic_001.jpg"
autumn = stars::read_stars(ifl)
names(autumn) = "Autumn forest"
sf::st_crs(autumn) = 3035

usethis::use_data(autumn, overwrite = TRUE)
