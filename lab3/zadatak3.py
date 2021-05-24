import os
import sys
import re

lab_re = re.compile(r"Lab_[0-9]{2}_g[0-9]{2}.txt")
lab_no_re = re.compile(r"^Lab_([0-9]{2})_g[0-9]{2}.txt$")


def parse_input(path: str) -> None:
    with open(f"{path}/studenti.txt", "r") as f:
        name_dict = {
            jmbag: (name, surname)
            for jmbag, name, surname in [x.strip().split(" ") for x in f.readlines()]
        }
    lab_files = [x for x in os.listdir(path) if lab_re.match(x)]
    labs = {}
    for lab_file in lab_files:
        with open(f"{path}/{lab_file}", "r") as f:
            if (grp_no := lab_no_re.match(lab_file).group(1)) not in labs.keys():
                labs[grp_no] = {
                    jmbag: float(points)
                    for jmbag, points in [x.strip().split(" ") for x in f.readlines()]
                }
            else:
                for jmbag, points in [x.strip().split(" ") for x in f.readlines()]:
                    if jmbag in labs[grp_no]:
                        print(
                            "Warning, same student entry found in multiple separate groups!"
                        )
                    else:
                        labs[grp_no].update({jmbag: float(points)})
    print("%s %20s" % ("JMBAG", "Prezime, Ime"), end="")
    for lab_no in labs.keys():
        print("%10s" % ("L" + lab_no), end="")
    print("\n", end="")
    for jmbag, name in name_dict.items():
        print("%s %15s" % (jmbag, ",".join(name)), end="")
        for lab_dict in labs.values():
            if jmbag not in lab_dict:
                print("%10s" % ("-"), end="")
            else:
                print("%10.1f" % (lab_dict[jmbag]), end="")
        print("\n", end="")


def main():
    parse_input(sys.argv[1])


if __name__ == "__main__":
    main()