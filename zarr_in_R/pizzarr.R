install.packages("devtools")
devtools::install_github("keller-mark/pizzarr", ref="67359dd")
library(pizzarr)

zarr_file_reference <- "data/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr"
zarr_file_with_root <- "data/test.with_root.zip"
zarr_file_without_root <- "data/test.withoutroot.zip"

store <- DirectoryStore$new(zarr_file_reference)
g <- zarr_open_group(store)
# works

store <- DirectoryStore$new(zarr_file_with_root)
g <- zarr_open_group(store)
# error: cannot open file 'data/test.with_root.zip/.zgroup': Not a directory

store <- DirectoryStore$new(zarr_file_with_root)
g <- zarr_open_group(store)
# error: cannot open file 'data/test.with_root.zip/.zgroup': Not a directory