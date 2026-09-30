#' Access the default operation table
#'
#' The package starts with an empty table. `Put()` registers or replaces a
#' value; `Get()` returns a value or `FALSE` when no entry exists. The wrappers
#' always use the current table, including after `reset_operation_table()`.
#' Install complex representations explicitly after a reset.
#'
#' The default table is shared within the R session. For an independent table,
#' use [make_table2()]. The teaching file illustrates a separate table local
#' to the lecture environment, not the package's private default table.
#' @param key1,key2 The two keys, compared using [equal()].
#' @param value A value to register. `FALSE` is also the missing-entry sentinel.
#' @return `Get()` returns the stored value or `FALSE`; `Put()` returns `"ok"`;
#'   `reset_operation_table()` returns invisible `NULL`.
#' @name operation_table
#' @examples
#' reset_operation_table()
#' Put("double", List("number"), function(x) 2 * x)
#' Get("double", List("number"))(3)
#' reset_operation_table()
NULL

.operation_state <- new.env(parent = emptyenv())

#' @rdname operation_table
#' @export
Get <- function(key1, key2) {
  .operation_state$table("lookup")(key1, key2)
}

#' @rdname operation_table
#' @export
Put <- function(key1, key2, value) {
  .operation_state$table("insert!")(key1, key2, value)
}

#' @rdname operation_table
#' @export
reset_operation_table <- function() {
  .operation_state$table <- make_table2()
  invisible(NULL)
}

.onLoad <- function(libname, pkgname) {
  reset_operation_table()
}

# The following explicitly marked teaching template is the source of the
# generated get_put.R file. Local closures are intentional: later lecture
# definitions use this local table, rather than the package default table.
# teaching> ## ---- teaching-get-put
# teaching> operation_table <- make_table2()
# teaching> Get <- operation_table("lookup")
# teaching> Put <- operation_table("insert!")
