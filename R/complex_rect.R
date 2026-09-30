#' Install a complex-number representation in the operation table
#'
#' These functions register selectors and constructors in the current default
#' table. They do not install R packages. Rectangular payloads store real and
#' imaginary parts; polar payloads store magnitude and angle in radians.
#' Inputs are intended to be numeric scalars, with nonnegative polar magnitude.
#' Constructors can be obtained using [Get()]. Reinstalling replaces methods.
#' @return The character string `"done"`.
#' @name complex_installers
#' @examples
#' reset_operation_table()
#' install_rectangular_package()
#' install_polar_package()
#' z <- Get("make_from_mag_ang", "polar")(2, pi / 2)
#' imag_part(z)
#' reset_operation_table()
NULL

#' @rdname complex_installers
#' @export
## ---- teaching-complex-rect
install_rectangular_package <- function() {
  # internal functions
  real_part <- function(z) { head(z) }
  imag_part <- function(z) { tail(z) }
  magnitude <- function(z) {
    sqrt(square(real_part(z)) + square(imag_part(z)))
  }
  angle <- function(z) {
    atan2(imag_part(z), real_part(z))
  }
  make_from_real_imag <- function(x, y) { pair(x, y) }
  make_from_mag_ang <- function(r, a) {
    pair(r * cos(a), r * sin(a))
  }
  # interface to the rest of the system
  tag <- function(x) { attach_tag("rectangular", x)  }
  Put("real_part", List("rectangular"), real_part)
  Put("imag_part", List("rectangular"), imag_part)
  Put("magnitude", List("rectangular"), magnitude)
  Put("angle", List("rectangular"), angle)
  Put("make_from_real_imag", "rectangular",
      function(x, y) { tag(make_from_real_imag(x, y)) }
     )
  Put("make_from_mag_ang", "rectangular",
      function(r, a) { tag(make_from_mag_ang(r, a)) }
     )
  "done"
}
