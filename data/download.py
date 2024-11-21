import os
import shutil
import zipfile
import urllib.request
from pathlib import Path

def download_and_process_zarr():
    """
    Downloads a Zarr file and creates two versions:
    1. Original file with root directory
    2. Repackaged file without root directory
    """
    # Set up constants
    url = "https://zenodo.org/records/13305156/files/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr.zip?download=1"
    with_root_zip = "test.with_root.zip"
    without_root_zip = "test.without_root.zip"
    temp_dir = "tmp"

    try:
        # Download the file
        print(f"Downloading from {url}")
        urllib.request.urlretrieve(url, with_root_zip)

        # Create temporary directory
        temp_path = Path(temp_dir)
        temp_path.mkdir(exist_ok=True)

        # Unzip to temporary directory
        print(f"Extracting {with_root_zip} to {temp_dir}")
        with zipfile.ZipFile(with_root_zip, 'r') as zip_ref:
            zip_ref.extractall(temp_dir)

        # Find the .zarr directory
        zarr_dirs = list(temp_path.glob('*.zarr'))
        if not zarr_dirs:
            raise FileNotFoundError("No .zarr directory found in the extracted contents")
        zarr_dir = zarr_dirs[0]

        # Create new zip without root folder
        print(f"Creating {without_root_zip} without root folder")
        with zipfile.ZipFile(without_root_zip, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for root, _, files in os.walk(zarr_dir):
                for file in files:
                    file_path = Path(root) / file
                    arc_name = str(file_path.relative_to(zarr_dir))
                    zipf.write(file_path, arc_name)

    except Exception as e:
        print(f"An error occurred: {e}")
        raise

    finally:
        # Clean up
        print("Cleaning up temporary files")
        if Path(temp_dir).exists():
            shutil.rmtree(temp_dir)

if __name__ == "__main__":
    download_and_process_zarr()
