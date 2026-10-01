#' Square a value
#'
#' A vectorized multiplication example. The arithmetic and missing-value rules
#' are those of ordinary R multiplication.
#' @param x A numeric vector.
#' @return The elementwise square of `x`.
#' @examples
#' square(c(2, 3))
#' @export
## ---- numeric-square
square <- function(x) { x * x }

#' Greatest common divisor
#'
#' Euclid's recursive algorithm, with a nonnegative result. The arguments are
#' intended to be integer-valued numeric scalars. By convention, `gcd(0, 0)` is
#' zero. These algorithms are intended for small teaching examples, not
#' arbitrary precision arithmetic.
#' @param a,b Numeric scalars used as integers.
#' @return A nonnegative greatest common divisor.
#' @examples
#' gcd(206, 40)
#' gcd(-12, 18)
#' @export
## ---- numeric-gcd
gcd <- function(a, b) {
  a <- abs(a)
  b <- abs(b)
  if (b == 0) {
    a
  } else {
    gcd(b, a %% b)
  }
}

#' Trial-division helpers
#'
#' Explicit helper algorithms used by [is_prime()]. Trial division is suitable
#' for small teaching examples. `find_divisor()` starts at `test_divisor`;
#' when using a starting value above two, the caller is responsible for having
#' ruled out smaller divisors. A recursive scan may exhaust R's recursion limit
#' for large inputs.
#' These helpers assume their arguments satisfy the stated teaching
#' preconditions; they do not perform separate input validation.
#' @param a A nonzero numeric scalar used as an integer.
#' @param b A numeric scalar used as an integer.
#' @param n A numeric scalar representing an integer at least two.
#' @param test_divisor A numeric scalar representing an integer at least two.
#' @return `divides()` returns one logical value. `find_divisor()` and
#'   `smallest_divisor()` return a divisor of `n` (or `n` itself).
#' @name prime_helpers
#' @examples
#' divides(3, 12)
#' smallest_divisor(91)
NULL

#' @rdname prime_helpers
#' @export
## ---- numeric-prime-helpers
divides <- function(a, b) {
  b %% a == 0
}

#' @rdname prime_helpers
#' @export
find_divisor <- function(n, test_divisor) {
  if (square(test_divisor) > n) {
    n
  } else if (divides(test_divisor, n)) {
    test_divisor
  } else {
    find_divisor(n, test_divisor + 1)
  }
}

#' @rdname prime_helpers
#' @export
smallest_divisor <- function(n) { find_divisor(n, 2) }

#' Test primality by trial division
#'
#' Integers less than two are not prime. This is a recursive teaching algorithm
#' for small integers and assumes `n` is one numeric scalar used as an integer.
#' It does not perform separate input validation.
#' @param n A numeric scalar used as an integer.
#' @return One logical value.
#' @examples
#' is_prime(43)
#' is_prime(1)
#' @export
## ---- numeric-is-prime
is_prime <- function(n) {
  n >= 2 && n == smallest_divisor(n)
}
