import sys
from typing import List


def load_data(path: str) -> List[List[float]]:
    with open(path, "r") as f:
        return [
            sorted([float(el) for el in x.strip().split(" ")]) for x in f.readlines()
        ]


def calculate_output(data: List[List[float]]) -> None:
    print(data)
    header = f"Hyp#{'#'.join(['Q' + str(x * 10) for x in range(1, 10)])}"
    print(header)
    for count, data_row in enumerate(data, start=1):
        row = f"{count:03d}"
        for quantile in range(1, 10):
            index = round(float(quantile) / 10 * len(data_row))
            row += f"#{data_row[index - 1]}"
        print(row)


def main():
    data = load_data(sys.argv[1])
    calculate_output(data)


if __name__ == "__main__":
    main()