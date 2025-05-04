from pathlib import Path
import os
import argparse
import glob
from itertools import count
from datetime import datetime
from functools import partial
import exifread 
def file_in_range(file: Path, start_date: datetime, end_date:datetime):
    pass

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

def is_in_dates(img: Path, start_date:datetime, end_date: datetime):
    from os.path import getatime, getmtime, getctime
    
    time = os.path.getctime(img)
    date = datetime.fromtimestamp(time)

    return start_date < date and date < end_date

    print(time, datetime.fromtimestamp(time))
    print(datetime.fromtimestamp(getatime(img)), datetime.fromtimestamp(getctime(img)), datetime.fromtimestamp(getmtime(img)))
    print(getctime(img) < datetime.fromtimestamp(getmtime(img)))

def main():
    parser = argparse.ArgumentParser(
        description="Rename improperly named images to the end of the directory sequence"
    )
    parser.add_argument("dir", type=Path, help="Directory containing images")
    parser.add_argument("last", type=int, help="Starting number for renaming")
    parser.add_argument("start_date", help="start date")
    parser.add_argument("end_date", help="end date")

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

    start_date = args.start_date
    end_date = args.end_date
    
    a = datetime.fromisoformat(start_date)
    b = datetime.fromisoformat(end_date)
    # print(datetime.fromisoformat(start_date))
    # print(datetime.fromisoformat(end_date))
    # # print([a, b])
    # images = read_images(directory, pattern)
    # print(images)
    
    # for img in images:
    #     mtime = os.path.getmtime(img)
    #     atime = os.path.getatime(img)
    #     ctime = os.path.getctime(img)
    #     # print(datetime.fromtimestamp(mtime), datetime.fromtimestamp(ctime))
    #     print(is_in_dates(img, a, b))
    # all(os.path.exists())
    for f in os.listdir(directory)[-10:]:
        p = Path(directory / f)
        print(os.path.exists(p))
    print(all((is_in_dates(Path(str(directory / f)), a, b)) for f in sorted(os.listdir(directory))))
    files = sorted((directory / f for f in os.listdir(directory)))
    x = filter(partial(is_in_dates, start_date=a, end_date=b), files)
    for f in x:
        with open(f, "rb") as file_handle:
            tags = exifread.process_file(file_handle, details=False)
        metadata = {"date": tags.get('Image DateTime')}   
        date = str(metadata["date"])
        date = date.replace(":", "-", 2)
        print(date) 
        print(datetime.fromisoformat(date))

    # if not directory.is_dir():
    #     print(f"[ERROR] Not a directory: {directory}")
    #     return

    # image_list = read_images(directory, pattern)
    # if not image_list:
    #     print(f"[INFO] No images matched: {pattern}")
    #     return

    # print(f"[INFO] Found {len(image_list)} image(s) matching '{pattern}'")
    # renamed = rename_to_end(directory, image_list, start_index)

    # print("\n[SUMMARY]")
    # for old, new in renamed:
    #     print(f"{old} -> {new}")


if __name__ == "__main__":
    main()
