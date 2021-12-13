## code to prepare `pic` dataset goes here
ifl = "~/Pictures/images/pic_001.jpg"
pic = stars::read_stars(ifl)
names(pic) = "Autumn forest"
sf::st_crs(pic) = 3035

usethis::use_data(pic, overwrite = TRUE)
