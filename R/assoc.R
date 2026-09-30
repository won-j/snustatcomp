#' Association lists and structural equality
#'
#' `equal()` compares acyclic pair structures recursively and compares leaves
#' using `identical()`, including numeric storage type. `assoc()` returns the
#' first key-value pair whose head equals the key, or `FALSE` if none exists.
#' @param key A lookup key.
#' @param pairs A proper list of key-value pairs, or `NULL`.
#' @param xs,ys Acyclic pair structures or ordinary R objects.
#' @return `equal()` returns a logical scalar; `assoc()` returns a matching
#'   key-value pair or `FALSE`.
#' @name association_lists
#' @examples
#' assoc("a", List(pair("a", 1), pair("b", 2)))
#' equal(List(1, 2), List(1, 2))
NULL

# expects a key and a list of key-value pairs as arguments.
# returns the key-value pair that has the given key as its head
#' @rdname association_lists
#' @export
## ---- teaching-assoc
assoc <- function(key, pairs) {
  if (is.null(pairs)) {
    FALSE
  } else if (equal(key, head(head(pairs))) ) {
    head(pairs)  # a key-value pair
  } else {
    assoc(key, tail(pairs))
  }
}

#' @rdname association_lists
#' @export
equal <- function(xs, ys) {
  if (is_pair(xs)) {
    is_pair(ys) &&
      equal(head(xs), head(ys)) &&
      equal(tail(xs), tail(ys))
  } else {
    identical(xs, ys)
  }
}
