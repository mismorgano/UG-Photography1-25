from pathlib import Path
import os


def rename(filename: str, newname: str):
    """It change"""


def main(dir: str):
    files = os.listdir(dir)
    files.reverse()
    for filename in files:
        base = os.path.splitext(filename)[0]
        number = base[4:]
        if (n := int(number)) >= 83 and len(number) == 4:
            old_path = os.path.join(dir, filename)
            old_path = os.path.normcase(old_path)
            n = n + 2  # rename enumeration to image
            new_name = "IMG_" + "0" * (4 - len(str(n))) + str(n) + ".JPG"
            new_path = os.path.join(dir, new_name)
            new_path = os.path.normcase(new_path)

            print(new_path, os.path.isfile(new_path))
            os.rename(old_path, new_path)
            


if __name__ == "__main__":
    main("./img")
   
