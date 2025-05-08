import exifread
import exiftool
from pathlib import Path
import logging
import csv
import argparse

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")

CANON_MODES = {
    0: "Full auto",
    1: "Manual",
    2: "Landscape",
    3: "Fast shutter",
    4: "Slow shutter",
    5: "Night",
    6: "Gray Scale",
    7: "Sepia",
    8: "Portrait",
    9: "Sports",
    10: "Macro",
    11: "Black & White",
    12: "Pan focus",
    13: "Vivid",
    14: "Neutral",
    15: "Flash Off",
    16: "Long Shutter",
    17: "Super Macro",
    18: "Foliage",
    19: "Indoor",
    20: "Fireworks",
    21: "Beach",
    22: "Underwater",
    23: "Snow",
    24: "Kids & Pets",
    25: "Night Snapshot",
    26: "Digital Macro",
    27: "My Colors",
    28: "Movie Snap",
    29: "Super Macro 2",
    30: "Color Accent",
    31: "Color Swap",
    32: "Aquarium",
    33: "ISO 3200",
    34: "ISO 6400",
    35: "Creative Light Effect",
    36: "Easy",
    37: "Quick Shot",
    38: "Creative Auto",
    39: "Zoom Blur",
    40: "Low Light",
    41: "Nostalgic",
    42: "Super Vivid",
    43: "Poster Effect",
    44: "Face Self-timer",
    45: "Smile",
    46: "Wink Self-timer",
    47: "Fisheye Effect",
    48: "Miniature Effect",
    49: "High-speed Burst",
    50: "Best Image Selection",
    51: "High Dynamic Range",
    52: "Handheld Night Scene",
    53: "Movie Digest",
    54: "Live View Control",
    55: "Discreet",
    56: "Blur Reduction",
    57: "Monochrome",
    58: "Toy Camera Effect",
    59: "Scene Intelligent Auto",
    60: "High-speed Burst HQ",
    61: "Smooth Skin",
    62: "Soft Focus",
    68: "Food",
    84: "HDR Art Standard",
    85: "HDR Art Vivid",
    93: "HDR Art Bold",
    257: "Spotlight",
    258: "Night 2",
    259: "Night+",
    260: "Super Night",
    261: "Sunset",
    263: "Night Scene",
    264: "Surface",
    265: "Low Light 2",
}


def read_metadata(image: Path, properties: list[str], n: int):
    """Reads metadata from an image file and includes the image number."""
    if not image.exists():
        logging.warning(f"File not found: {image}")
        return {"Image Number": n, **{prop: None for prop in properties}}

    metadata = {"Image Number": n}

    for prop in properties:

        if prop != "MakerNotes:EasyMode":
            with open(image, "rb") as file_handle:
                tags = exifread.process_file(file_handle, details=False)
                metadata[prop] = tags.get(prop)
        if prop == "MakerNotes:EasyMode":
            with exiftool.ExifToolHelper() as et:
                tags = et.get_tags(image, tags=prop)
                value = tags[0].get(prop)
                value = CANON_MODES.get(value, f"Unknown ({value})")
                metadata[prop] = value
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
