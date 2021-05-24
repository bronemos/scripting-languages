import sys
from collections import defaultdict
from typing import DefaultDict, Tuple


def load_matrices(path: str) -> Tuple[DefaultDict, Tuple[int]]:
    matrix_A = defaultdict(lambda: 0)
    matrix_B = defaultdict(lambda: 0)
    with open(path, "r") as f:
        rows = [x.split("\n") for x in f.read().split("\n\n")]
        dim_A = tuple(map(int, rows[0][0].split(" ")))
        for row in rows[0][1:]:
            x, y, value = [int(v) for v in row.split(" ")]
            matrix_A[(x, y)] = value
        for row in rows[1][1:]:
            x, y, value = [int(v) for v in row.split(" ")]
            matrix_B[(x, y)] = value
        dim_B = tuple(map(int, rows[1][0].split(" ")))

    return matrix_A, dim_A, matrix_B, dim_B


def print_matrix(matrix: DefaultDict, dim: Tuple[int], name: str) -> None:
    print(f"{name}:")
    max_x, max_y = dim
    for x in range(max_x):
        for y in range(max_y):
            print(f"{matrix[(x, y)]:7.2f}", end="")
        print()


def save_matrix(path: str, matrix: DefaultDict, dim: Tuple[int]) -> None:
    with open(path, "w") as f:
        f.write(" ".join(map(str, dim)) + "\n")
        f.writelines(
            [
                f"{' '.join(map(str, key))} {value:.2f}\n"
                for key, value in matrix.items()
                if value != 0
            ]
        )


def mul_matrix(
    matrix_A: DefaultDict, dim_A: Tuple[int], matrix_B: DefaultDict, dim_B: Tuple[int]
) -> Tuple[DefaultDict, Tuple[int]]:
    if dim_A[1] != dim_B[0]:
        raise Exception
    matrix = defaultdict(lambda: 0)
    dim = (dim_A[0], dim_B[1])
    for x in range(dim_A[0]):
        for y in range(dim_B[1]):
            for z in range(dim_B[0]):
                matrix[(x, y)] += matrix_A[(x, z)] * matrix_B[(z, y)]
    print_matrix(matrix, dim, "A*B")
    return matrix, dim


def main():
    matrix_A, dim_A, matrix_B, dim_B = load_matrices(sys.argv[1])
    print_matrix(matrix_A, dim_A, "A")
    print_matrix(matrix_B, dim_B, "B")
    matrix, dim = mul_matrix(matrix_A, dim_A, matrix_B, dim_B)
    save_matrix(sys.argv[2], matrix, dim)


if __name__ == "__main__":
    main()