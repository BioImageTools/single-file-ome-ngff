// cargo-deps: zarrs = "0.18.0-beta.0", zarrs_zip="*"
use std::{path::Path, sync::Arc};

use zarrs::{
    array::Array,
    filesystem::FilesystemStore,
    storage::{ReadableStorageTraits, StoreKey},
};
use zarrs_zip::ZipStorageAdapter;

fn main_impl(folder_path: &str, zip_file: &str, array_path: &str) {
    let zip_key = StoreKey::new(zip_file).unwrap();
    let store = Arc::new(FilesystemStore::new(&folder_path).unwrap());
    let store = Arc::new(ZipStorageAdapter::new(store, zip_key).unwrap());
    let array = Array::open(store.clone(), array_path).unwrap();
    read_array_from_store(array).unwrap();
}

fn main() {
    main_impl("../data", "test.without_root.zip", "/B/03/0/0");
    main_impl(
        "../data",
        "test.with_root.zip",
        "/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr/B/03/0/0",
    );
}

fn read_array_from_store<TStorage: ReadableStorageTraits + 'static>(
    array: Array<TStorage>,
) -> Result<(), Box<dyn std::error::Error>> {
    // Read the whole array
    let data_all = array.retrieve_array_subset_ndarray::<u16>(&array.subset_all())?;
    println!("The whole array is:\n{data_all}\n");

    // Read value at (0, 0, 0, 0)
    let array_ndarray = array.retrieve_array_subset_ndarray::<u16>(&array.subset_all())?;
    println!(
        "The value at (0, 0, 0, 0) is: {:?}",
        array_ndarray[[0, 0, 0, 0]]
    );
    assert!(array_ndarray[[0, 0, 0, 0]] == 160);

    // Assert the shape
    println!("The shape of the array is: {:?}", array_ndarray.shape());
    assert!(array_ndarray.shape() == &[1, 2, 2160, 5120]);
    Ok(())
}
