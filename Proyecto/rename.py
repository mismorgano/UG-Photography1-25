from pathlib import Path
import os
import argparse
import glob
from itertools import count


def rename(old_path: Path, new_path: Path):
    """Rename a file from old_path to new_path."""
    if not old_path.exists():
        print(f"[WARN] File not found: {old_path}")
        return
    if new_path.exists():
        print(f"[SKIP] Target exists: {new_path}")
        return
    old_path.rename(new_path)
    print(f"[OK] Renamed: {old_path.name} -> {new_path.name}")


def read_images(directory: Path, wildcard: str):
    """Return a list of image paths matching the wildcard."""
    pattern = str(directory / wildcard)
    return [Path(p) for p in glob.glob(pattern)]


def rename_to_end(directory: Path, images: list[Path], start_index: int):
    """Rename given images to new names starting from a given index."""
    renamed = []

    for img, number in zip(images, count(start_index)):
        new_name = f"IMG_{number:04d}.JPG"
        new_path = directory / new_name
        rename(img, new_path)
        renamed.append((img.name, new_name))

    return renamed


def main():
    parser = argparse.ArgumentParser(
        description="Rename improperly named images to the end of the directory sequence"
    )
    parser.add_argument("dir", type=Path, help="Directory containing images")
    parser.add_argument("last", type=int, help="Starting number for renaming")
    parser.add_argument(
        "-im",
        "--images",
        default="*_1.JPG",
        help="Image filename pattern to match (wildcards like *_1.jpg)",
    )

    args = parser.parse_args()
    directory: Path = args.dir
    start_index: int = args.last
    pattern: str = args.images

    if not directory.is_dir():
        print(f"[ERROR] Not a directory: {directory}")
        return

    image_list = read_images(directory, pattern)
    if not image_list:
        print(f"[INFO] No images matched: {pattern}")
        return

    print(f"[INFO] Found {len(image_list)} image(s) matching '{pattern}'")
    renamed = rename_to_end(directory, image_list, start_index)

    print("\n[SUMMARY]")
    for old, new in renamed:
        print(f"{old} -> {new}")


if __name__ == "__main__":
    main()
