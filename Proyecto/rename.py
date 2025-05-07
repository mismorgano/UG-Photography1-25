from pathlib import Path
import argparse
from itertools import count
from datetime import datetime
from functools import partial
import exifread


def get_datetime(img: Path):
    """Get the Image DateTime metadata"""
    with open(img, "rb") as file_handle:
        tags = exifread.process_file(file_handle, details=False)
        time = str(tags.get("Image DateTime"))
        time = time.replace(":", "-", 2)

    return datetime.fromisoformat(time)


def is_in_dates(img: Path, start_date: datetime, end_date: datetime):
    """Check if the image date time is in the range."""
    date = get_datetime(img=img)

    return start_date <= date and date <= end_date


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


def rename_to_end(directory: Path, images: list[Path], start_index: int):
    """Rename given images to new names starting from a given index."""
    renamed = []

    for img, number in zip(images, count(start_index)):
        new_name = f"IMG_{number:04d}.JPG"
        new_path = directory / new_name
        rename(img, new_path)
        renamed.append((img.name, new_name))

    return renamed


def read_images(directory: Path, start_date: datetime, end_date: datetime):
    """Return a list of image paths matching the wildcard."""
    files = (directory / f for f in directory.iterdir())

    filter_images = filter(
        partial(is_in_dates, start_date=start_date, end_date=end_date), files
    )
    images = sorted(filter_images, key=get_datetime)
    return images


def main():
    parser = argparse.ArgumentParser(
        description="Rename improperly named images to the end of the directory sequence"
    )
    parser.add_argument("dir", type=Path, help="Directory containing images")
    parser.add_argument("last", type=int, help="Starting number for renaming")
    parser.add_argument("start_date", type=datetime.fromisoformat, help="start date")
    parser.add_argument("end_date", type=datetime.fromisoformat, help="end date")

    args = parser.parse_args()
    directory: Path = args.dir
    start_index: int = args.last

    start_date = args.start_date
    end_date = args.end_date

    if not directory.is_dir():
        print(f"[ERROR] Not a directory: {directory}")
        return

    images = read_images(directory, start_date=start_date, end_date=end_date)

    if not images:
        print("[INFO] No images found in the given date range.")
        return

    print(f"[INFO] Found {len(images)} image(s) to rename.")

    renamed = rename_to_end(directory, images, start_index)

    print("\n[SUMMARY]")
    for old, new in renamed:
        print(f"{old} -> {new}")


if __name__ == "__main__":
    main()
