# snustatcomp

`snustatcomp` provides small, explicit R implementations used in the Seoul
National University statistical computing lectures. It includes numerical
helpers, mutable pairs and linked lists, association tables, tagged data,
table-driven generic operations, complex-number representations, and symbolic
expression constructors and selectors.

The GitHub repository is
[`won-j/snustatcomp`](https://github.com/won-j/snustatcomp), and the installed R
package is also named `snustatcomp`.

## Installation from GitHub

Install the current development version with `pak`:

```r
install.packages("pak")
pak::pkg_install("won-j/snustatcomp")

library(snustatcomp)
```

Alternatively, use `remotes`:

```r
install.packages("remotes")
remotes::install_github("won-j/snustatcomp")
```

For a reproducible project, install an exact commit and record it with `renv`:

```r
renv::install("github::won-j/snustatcomp@<commit-sha>")
renv::snapshot()
```

Replace `<commit-sha>` with the commit used by the project. If the repository
is private, configure a GitHub personal access token that can read it before
installing.

## Example

```r
library(snustatcomp)

gcd(84, 30)
is_prime(97)

p <- pair(1, 2)
q <- p
set_head(p, 3)
head(q)  # 3: p and q refer to the same mutable pair
```

The package keeps `head()` and `tail()` as methods of the existing `utils`
generics. When another package exports a function with the same name as a
teaching helper, use an explicit call such as `snustatcomp::map()`.

## Teaching source

Files under `R/` are the maintained package sources. Readable sources for
lecture chunks are generated under `inst/teaching/` and installed with the
package. Do not edit the generated files directly.

For example, a Quarto document can register the numerical teaching chunks with:

```r
knitr::read_chunk(
  system.file(
    "teaching", "numeric.R",
    package = "snustatcomp",
    mustWork = TRUE
  )
)
```

The numerical chunk labels are `numeric-square`, `numeric-gcd`,
`numeric-prime-helpers`, and `numeric-is-prime`.

## Development

From the repository root:

```sh
Rscript --vanilla tools/generate-teaching.R
Rscript --vanilla -e 'roxygen2::roxygenise(".")'
Rscript --vanilla tools/generate-teaching.R --check
Rscript --vanilla -e 'testthat::test_local(".")'
R CMD build .
R CMD check --no-manual snustatcomp_0.1.2.tar.gz
```

Commit generated files under `inst/teaching/` together with generated
`NAMESPACE` and `man/` documentation. GitHub Actions checks both generated
teaching-source consistency and the R package.

## Sources and Licenses

The R implementations in this package were developed for the Seoul National
University's 326.212: Statistical Computing lectures. They are translated from or based on programs presented in *[Structure and Interpretation of Computer Programs](https://mitpress.mit.edu/9780262510875/structure-and-interpretation-of-computer-programs/)*, Second Edition (1996), by Harold Abelson and Gerald Jay Sussman with Julie Sussman, and in [SICP JS](https://sourceacademy.org/sicpjs/), the JavaScript adaptation by Martin Henz and Tobias Wrigstad. The licensing approach follows the [Licenses section of
`source-academy/sicp`](https://github.com/source-academy/sicp#licenses).

The R package source code is made available under the [GNU General Public
License version 3 (GPL-3)](https://www.gnu.org/licenses/gpl-3.0.html), as
declared in `DESCRIPTION`. The generated teaching sources under
`inst/teaching/` are derived from the canonical sources under `R/` and are
distributed under the same license.

The SICP and SICP JS texts and figures used as source material are licensed by
their respective authors and adapters under the [Creative Commons
Attribution-ShareAlike 4.0 International license (CC BY-SA
4.0)](https://creativecommons.org/licenses/by-sa/4.0/). This package does not
redistribute those texts or figures.

External packages and third-party materials remain subject to the licenses
specified by their respective copyright holders and distributors. A
file-specific notice takes precedence where present.
