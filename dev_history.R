## 2021-12-13 ====
usethis::use_data_raw("pic")

## 2021-12-09 ====
## reference
# https://usethis.r-lib.org/reference/index.html#package-setup

## add vignette painting
usethis::use_article("painting")

## tinytest
tinytest::setup_tinytest(pkgdir = ".")

## license, news, readme
usethis::use_news_md()
usethis::use_readme_rmd()
usethis::use_mit_license(copyright_holder = "Hendrik Wagenseil")

## dev_history.R
usethis::use_build_ignore("dev_history.R")
usethis::edit_file("dev_history.R")

## create package
# usethis::create_package("~/Documents/repos/github/aRts")
