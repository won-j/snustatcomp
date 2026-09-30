#' Dispatch an operation on tagged arguments
#'
#' `apply_generic()` looks up the operation and list of type tags in the
#' default operation table, then passes the untagged contents to the method.
#' It does not perform coercion. `do_call()` converts a proper pair list to
#' ordinary R arguments while preserving vectors and `NULL` elements.
#' @param op An operation key in the operation table.
#' @param args A proper pair list of arguments, or `NULL` for no arguments.
#' @param what A function or function name accepted by [base::do.call()].
#' @return The result of the selected function call.
#' @name generic_dispatch
#' @examples
#' do_call(function() 42, NULL)
#' do_call(function(x, y) list(x, y), List(c(1, 2), NULL))
NULL

#' @rdname generic_dispatch
#' @export
## ---- teaching-apply-generic
apply_generic <- function(op, args) {
  type_tags <- map(type_tag, args)
  fun <- Get(op, type_tags)
  if (!identical(fun, FALSE)) {
    do_call(fun, map(contents, args))
  } else {
    stop("no method for these types -- apply_generic")
  }
}

#' @rdname generic_dispatch
#' @export
do_call <- function(what, args) {
  if (!is.null(args) && !is_pair(args)) {
    stop("second argument must be a proper List or NULL")
  }
  do.call(what, flatten_list(args))
}
