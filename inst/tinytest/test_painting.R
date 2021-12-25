library(tinytest)

## rgb2hex
expect_equal(
    rgb2hex(matrix(c(0, 0, 0), nrow = 1))
    , "#000000"
)

