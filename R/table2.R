#' Construct an independent mutable table with two keys
#'
#' Returns a dispatcher. Call it with `"lookup"` to obtain a function of
#' `(key1, key2)`, with `"insert!"` to obtain a function of
#' `(key1, key2, value)`, or with `"table"` to inspect the backing pair list.
#' Keys are compared using [equal()]. A missing lookup returns `FALSE`;
#' insertion and replacement return `"ok"`. Consequently a stored `FALSE`
#' cannot be distinguished from a missing key by this interface.
#' @return A closure dispatching the three table operations.
#' @examples
#' tab <- make_table2()
#' tab("insert!")("row", "column", 42)
#' tab("lookup")("row", "column")

#' @rdname make_table2
#' @export
## ---- teaching-table2
make_table2 <- function() {
  local_table <- List("*table*")
  lookup <- function(key1, key2) {
    subtable <- assoc(key1, tail(local_table))
    if (!identical(subtable, FALSE)) {
      record <- assoc(key2, tail(subtable))
      if (!identical(record, FALSE)) {
        tail(record)
      } else {
        FALSE
      }
    } else {
      FALSE
    }
  }
  insert <- function(key1, key2, value) {
    subtable <- assoc(key1, tail(local_table))
    if (!identical(subtable, FALSE)) {
      record <- assoc(key2, tail(subtable))
      if (!identical(record, FALSE)) {
        set_tail(record, value) # replace existing value
      } else {
        set_tail(subtable,
                 pair(pair(key2, value), tail(subtable)))
      }
    } else {
      set_tail(local_table,
               pair(
                 List(key1, pair(key2, value)),
                 tail(local_table)
               ))
    }
    "ok"
  }
  dispatch <- function(m) {
    if (identical(m, "lookup")) {
      lookup
    } else if (identical(m, "insert!")) {
      insert
    } else if (identical(m, "table")) { # inspect the backing structure
      local_table 
    } else {
      stop("Unknown operation -- TABLE")
    }
  }
  dispatch
}
