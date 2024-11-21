
install.packages("devtools")
devtools::install_github("grimbough/Rarr", ref="84f2e9c")
library(Rarr)

zarr_file_reference <- "data/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr"
zarr_file_with_root <- "data/test.with_root.zip"
zarr_file_without_root <- "data/test.withoutroot.zip"

zarr_overview(zarr_file_reference)
# error, 'data/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr/.zarray': No such file or directory'

zarr_overview(zarr_file_with_root)
# error; 'data/test.with_root.zip/.zarray': Not a directory' 

zarr_overview(zarr_file_with_root)
# error, 'data/test.with_root.zip/.zarray': Not a directory'

