#' Construct and inspect tagged data
#'
#' A tag is the head of a pair and its contents are the tail. The predicates
#' check the pair representation, not a separate class for each possible tag.
#' @param type_tag A type identifier, usually a character scalar.
#' @param contents The untagged payload.
#' @param datum A tagged pair.
#' @return `attach_tag()` returns a pair; selectors return its tag or payload.
#' @name tagged_data
#' @examples
#' z <- attach_tag("number", 3)
#' type_tag(z)
#' contents(z)
NULL

#' @rdname tagged_data
#' @export
## ---- teaching-tag
attach_tag <- function(type_tag, contents) {
  pair(type_tag, contents)
}
#' @rdname tagged_data
#' @export
type_tag <- function(datum) {
  if (is_pair(datum) ) {
    head(datum)
  } else {
    stop("bad tagged datum -- type_tag")
  }
}
#' @rdname tagged_data
#' @export
contents <- function(datum) {
  if (is_pair(datum) ) {
    tail(datum)
  } else {
    stop("bad tagged datum -- contents")
  }
}
