#' Select components of data-directed complex values
#'
#' Install the rectangular or polar methods before calling these selectors.
#' Constructors are retrieved with `Get("make_from_real_imag", "rectangular")`
#' or `Get("make_from_mag_ang", "polar")`. These values are tagged pairs, not
#' native R complex vectors. Angles are measured in radians.
#' @param z A tagged rectangular or polar pair.
#' @return A numeric component, magnitude, or angle.
#' @name complex_selectors
#' @examples
#' reset_operation_table()
#' install_rectangular_package()
#' z <- Get("make_from_real_imag", "rectangular")(3, 4)
#' magnitude(z)
#' reset_operation_table()
NULL

#' @rdname complex_selectors
#' @export
## ---- teaching-complex-generic
real_part <- function(z) { apply_generic("real_part", List(z)) }
#' @rdname complex_selectors
#' @export
imag_part <- function(z) { apply_generic("imag_part", List(z)) }
#' @rdname complex_selectors
#' @export
magnitude <- function(z) { apply_generic("magnitude", List(z)) }
#' @rdname complex_selectors
#' @export
angle     <- function(z) { apply_generic("angle", List(z)) }
