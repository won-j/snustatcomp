with_empty_operation_table <- function(code) {
  reset_operation_table()
  on.exit(reset_operation_table(), add = TRUE)
  force(code)
}
