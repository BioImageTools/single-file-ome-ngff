from pathlib import Path
import zarr
import pytest


@pytest.fixture(params=["without_root", "with_root"])
def variant(request):
    return request.param


@pytest.fixture()
def zip_path(variant):
    return Path(__file__).parents[1] / "data" / f"test.{variant}.zip"


def test_read(zip_path, variant):
    store = zarr.ZipStore(zip_path, mode="r")
    if variant == "without_root":
        path = "B/03/0/0"
    else:        
        path = "20200812-CardiomyocyteDifferentiation14-Cycle1.zarr/B/03/0/0"
    group = zarr.open(store, mode="r", path=path)
    assert group[0, 0, 0, 0] == 160
    assert group.shape == (1, 2, 2160, 5120)


    

if __name__ == "__main__":
    pytest.main()
