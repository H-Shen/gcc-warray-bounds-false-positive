# GCC `-Warray-bounds` false positive

Minimal C++ reproducer for a GCC `-Warray-bounds` false positive on an
inlined, bounds-checked `std::vector<std::pair<int, int>>` access.

The function returns before indexing when `index >= values.size()`. With GCC
13.3.0 and optimization enabled, the call using `index == values.size()` is
nevertheless diagnosed as an out-of-bounds access.

## Preconditions

The reproducer has been verified with:

- Ubuntu 24.04.5 LTS on x86-64;
- `g++ (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0`;
- Xmake `3.1.1+HEAD.3ba37a0` for the Xmake test below.

Xmake is optional when invoking `g++` directly.

## Reproduce

```bash
g++ -std=c++23 -O2 -Wall -Wextra -Werror test.cpp
```

Observed diagnostic:

```text
error: array subscript 3 is outside array bounds of
       ‘std::pair<int, int> [3]’ [-Werror=array-bounds=]
```

The Xmake test treats the expected compilation failure as success:

```bash
xmake test
```
