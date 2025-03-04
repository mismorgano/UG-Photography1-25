import exifread
from pathlib import Path
import logging
import os
import csv
import argparse

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def read_metadata(path: Path, properties: list, n: int):
    """Reads metadata from an image file and includes the image number."""
    if not path.exists():
        logging.warning(f"File not found: {path}")
        return {"Image Number": n, **{prop: None for prop in properties}}

    with open(path, "rb") as file_handle:
        tags = exifread.process_file(file_handle, details=False)

    metadata = {"Image Number": n, **{prop: tags.get(prop) for prop in properties}}

    return metadata


def write_metadata(file: Path, fieldnames, rows):
    """Writes metadata to a csv file."""
    logging.info(f"Writing metadata to {file}")

    with open(file=file, mode="w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def create_image_path(n, prefix="IMG_", suffix=".jpg"):
    """Generates a filename for an image based on a number with zero-padding."""
    return Path(f"{prefix}{str(n).zfill(4)}{suffix}")


def read_properties(file: Path):
    """Reads a file and returns its contents as a list of rows."""
    if not file.exists():
        logging.error(f"File not found: {file}")
        return []
    with open(file, "r", newline="") as f:
        return [line.strip() for line in f]


def main():
    parser = argparse.ArgumentParser(
        description="Extract metadata from a range of images"
    )
    parser.add_argument("dir", type=Path, help="The directory containing images")
    parser.add_argument("start", type=int, help="First image")
    parser.add_argument("end", type=int, help="Last image (inclusive)")
    parser.add_argument(
        "properties", type=Path, help="File of the properties to extract"
    )
    parser.add_argument("out", type=Path, help="Output CSV file")
    args = parser.parse_args()

    dir: Path = args.dir
    output: Path = args.out
    prop_file: Path = args.properties
    start, end = args.start, args.end

    if not dir.exists() or not dir.is_dir():
        logging.error(f"Invalid directory: {dir}")
        return

    properties = read_properties(Path(prop_file))
    fieldnames = ["Image Number"] + properties

    images_path = (
        (Path(f"{dir}/{create_image_path(n)}"), n) for n in range(start, end + 1)
    )
    metadata = (read_metadata(img_path, properties, n) for (img_path, n) in images_path)

    write_metadata(output, fieldnames, metadata)


if __name__ == "__main__":

    main()
