
#' @rdname complex_installers
#' @export
## ---- teaching-complex-polar
install_polar_package <- function() {
  # internal functions
  real_part <- function(z) {
    magnitude(z) * cos(angle(z))
  }
  imag_part <- function(z) {
    magnitude(z) * sin(angle(z))
  }
  magnitude <- function(z) { head(z) }
  angle <- function(z) { tail(z) }
  make_from_real_imag <- function(x, y) {
    pair(sqrt(square(x) + square(y)),
         atan2(y, x))
  }
  make_from_mag_ang <- function(r, a) { pair(r, a) }
  # interface to the rest of the system
  tag <- function(x) { attach_tag("polar", x) }
  Put("real_part", List("polar"), real_part)
  Put("imag_part", List("polar"), imag_part)
  Put("magnitude", List("polar"), magnitude)
  Put("angle", List("polar"), angle)
  Put("make_from_real_imag", "polar", 
      function(x, y) { tag(make_from_real_imag(x, y)) }
     )
  Put("make_from_mag_ang", "polar",
      function(r, a) { tag(make_from_mag_ang(r, a)) }
     )
  "done"
}
