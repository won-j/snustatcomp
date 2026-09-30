#' Constructors and selectors for symbolic expressions
#'
#' A sum is `List("+", a1, a2)` and a product is `List("*", m1, m2)`.
#' These constructors do not simplify expressions. Variables follow the
#' lecture contract: a nonempty character vector is a variable, and variable
#' equality uses `identical()`. For ordinary algebra examples use one name.
#' Selectors expect the corresponding well-formed expression. The derivative
#' algorithm itself remains a lecture example rather than a package function.
#' @param x An expression or possible variable.
#' @param v1,v2 Possible variables.
#' @param a1,a2 The two operands of a sum.
#' @param m1,m2 The two operands of a product.
#' @param s A sum or product expression, as appropriate.
#' @return Predicates return logical scalars; constructors return pair lists;
#'   selectors return the requested operand.
#' @name symbolic_expressions
#' @examples
#' e <- make_sum("x", make_product(2, "y"))
#' is_sum(e)
#' addend(e)
NULL

#' @rdname symbolic_expressions
#' @export
## ---- teaching-symbolic-expressions
is_variable <- function(x) { is.character(x) && length(x) > 0 }

#' @rdname symbolic_expressions
#' @export
is_same_variable <- function(v1, v2) {
  is_variable(v1) && is_variable(v2) && identical(v1, v2)
}

#' @rdname symbolic_expressions
#' @export
is_sum <- function(x) {
  is_pair(x) && identical(head(x), "+")
}

#' @rdname symbolic_expressions
#' @export
make_sum <- function(a1, a2) { List("+", a1, a2) }

#' @rdname symbolic_expressions
#' @export
make_product <- function(m1, m2) { List("*", m1, m2) }

#' @rdname symbolic_expressions
#' @export
addend <- function(s) { head(tail(s)) }

#' @rdname symbolic_expressions
#' @export
augend <- function(s) { head(tail(tail(s))) }

#' @rdname symbolic_expressions
#' @export
is_product <- function(x) {
  is_pair(x) && identical(head(x), "*")
}

#' @rdname symbolic_expressions
#' @export
multiplier <- function(s) { head(tail(s)) }

#' @rdname symbolic_expressions
#' @export
multiplicand <- function(s) { head(tail(tail(s))) }
