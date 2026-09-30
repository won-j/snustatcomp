# snustatcomp 0.1.0

- Package the lecture's mutable pair, list, table, tagged-data, complex, and
  symbolic-expression helpers while preserving their educational names.
- Consolidate square, gcd, and trial-division algorithms in R/numeric.R and
  generate installed teaching sources from canonical package sources.
- Register pair methods for utils::head/tail and base::print without masking
  the existing generics; preserve mutation through shared pair aliases.
- Initialize an empty private operation table at load time and provide reset
  with Get/Put wrappers that always follow the current table.
- Correct primality for integers below two and validate scalar integer inputs.
  Normalize gcd signs and define gcd(0, 0) as zero.
- Preserve vector and NULL argument boundaries in flatten_list and support
  zero-argument calls through do_call(what, NULL).
- Document proper-list and acyclic traversal contracts; retain local teaching
  definitions for examples that deliberately redefine algorithms.
