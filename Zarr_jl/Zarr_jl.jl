import Pkg; Pkg.add(Pkg.PackageSpec(;name="Zarr", version="0.9.4"))


using Zarr



z = zopen("../data/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr")


z = zopen("../data/test.with_root.zip")
## ERROR: ArgumentError: Path ../data/test.with_root.zip is not a directory.


z = zopen("../data/test.without_root.zip")
## ERROR: ArgumentError: Path ../data/test.without_root.zip is not a directory.
