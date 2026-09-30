#' Construct and mutate a pair
#'
#' A pair is a closure with class `pair` and two stored values. Assigning a pair
#' to another variable preserves shared identity: changing either alias changes
#' the same object. No R-list copy-on-modify representation is used.
#'
#' `head()` and `tail()` are the existing `utils` generics, with registered
#' methods that select one stored value. Mutation returns invisible `NULL`.
#' @param x,y Values to store. In methods, `x` is a pair.
#' @param pair A pair to mutate.
#' @param new_value The replacement value.
#' @param ... Ignored by the pair selector methods.
#' @return `pair()` returns a pair closure; selectors return its stored values;
#'   mutation returns invisible `NULL`.
#' @examples
#' p <- pair(1, 2)
#' q <- p
#' set_head(p, 3)
#' head(q)
#' tail(p)
#' @export
## ---- teaching-pair
pair <- function(x, y) {
  .head <- x
  .tail <- y
  dispatch <- function(message, val = NULL) {
    if (identical(message, "head")) {
      .head
    } else if (identical(message, "tail")) {
      .tail
    } else if (identical(message, "set-head!")) {
      assign(".head", val, inherits = TRUE)
      invisible(NULL)
    } else if (identical(message, "set-tail!")) {
      assign(".tail", val, inherits = TRUE)
      invisible(NULL)
    } else {
      "unknown-message"
    }
  }
  class(dispatch) <- "pair"
  dispatch
}

#' @rdname pair
#' @export
head.pair <- function(x, ...) { x("head") }

#' @rdname pair
#' @export
tail.pair <- function(x, ...) { x("tail") }

#' @rdname pair
#' @export
set_head <- function(pair, new_value) {
  if (!inherits(pair, "pair")) stop("pair must be a pair")
  pair("set-head!", new_value)
}

#' @rdname pair
#' @export
set_tail <- function(pair, new_value) {
  if (!inherits(pair, "pair")) stop("pair must be a pair")
  pair("set-tail!", new_value)
}
