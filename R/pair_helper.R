#' Pair lists and their elementary operations
#'
#' `List()` constructs a Scheme-style linked list terminated by `NULL`.
#' `List()` with no arguments is `NULL`. `len()`, `map()`, `appnd()`, and
#' `flatten_list()` expect finite, acyclic proper lists. Dotted tails produce
#' an error; cyclic structures are not supported by these recursive traversals.
#'
#' `flatten_list()` converts only the outer chain to an R list, preserving each
#' element (including `NULL`, vectors, and nested pairs) as one element.
#' `flatten_pair()` recursively collects non-pair leaves and discards `NULL`
#' leaves; it accepts dotted pairs too. Neither function changes its input.
#' `appnd()` copies the first chain and shares the second chain.
#'
#' The name `map` is used for consistency with the lectures. Use
#' `snustatcomp::map()` when another attached package has the same name.
#' @param x An object to inspect or a pair to print.
#' @param ... Elements of a new linked list; unused in the print method.
#' @param items A proper pair list, or `NULL`.
#' @param p A pair/list structure to convert.
#' @param fun A function applied to each element.
#' @param list1,list2 Proper pair lists, or `NULL`.
#' @return `is_pair()` returns a logical scalar; `List()`, `map()`, and `appnd()`
#'   return pair lists or `NULL`; `len()` returns a length; the flattening
#'   functions return ordinary R lists. Printing invisibly returns `x`.
#' @name pair_lists
#' @examples
#' xs <- List(1, 2, 3)
#' len(xs)
#' flatten_list(map(square, xs))
#' flatten_list(List(c(1, 2), NULL))
NULL

#' @rdname pair_lists
#' @export
## ---- teaching-pair-helper
is_pair <- function(x) { inherits(x, "pair") }

#' @rdname pair_lists
#' @export
print.pair <- function(x, ...) {
  cat("[ ")
  .head <- head(x)
  if (is.null(.head)) cat("NULL")
  else if (is.atomic(.head)) cat(.head)
  else print(.head)
  cat(", ")
  .tail <- tail(x)
  if (is.null(.tail)) cat("NULL")
  else if (is.atomic(.tail)) cat(.tail)
  else print(.tail)
  cat(" ]")
  invisible(x)
}

#' @rdname pair_lists
#' @export
List <- function(...) {
  alist <- list(...)
  if (length(alist) > 0) {
    pair(..1, do.call(List, alist[-1]))
  } else {
    NULL
  }
}

#' @rdname pair_lists
#' @export
len <- function(items) {
  if (is.null(items)) return(0)
  if (!is_pair(items)) stop("items must be a proper List")
  1 + len(tail(items))
}

#' @rdname pair_lists
#' @export
flatten_pair <- function(p) {
  if (is.null(p)) {
    list()
  } else if (!is_pair(p)) {
    list(p)
  } else {
    c(flatten_pair(head(p)), flatten_pair(tail(p)))
  }
}

#' @rdname pair_lists
#' @export
flatten_list <- function(p) {
  if (is.null(p)) return(list())
  if (!is_pair(p)) stop("p must be a proper List")
  c(list(head(p)), flatten_list(tail(p)))
}

#' @rdname pair_lists
#' @export
map <- function(fun, items) {
  if (is.null(items)) return(NULL)
  if (!is_pair(items)) stop("items must be a proper List")
  pair(fun(head(items)), map(fun, tail(items)))
}

#' @rdname pair_lists
#' @export
appnd <- function(list1, list2) {
  if (is.null(list1)) {
    len(list2)
    return(list2)
  }
  if (!is_pair(list1)) stop("list1 must be a proper List")
  pair(head(list1), appnd(tail(list1), list2))
}
