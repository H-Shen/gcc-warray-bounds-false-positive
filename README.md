# GCC `-Warray-bounds` false positive

Minimal C++ reproducer for a GCC `-Warray-bounds` false positive on an
inlined, bounds-checked `std::vector<std::pair<int, int>>` access.

The function returns before indexing when `index >= values.size()`. With GCC
13.3.0 and optimization enabled, the call using `index == values.size()` is
nevertheless diagnosed as an out-of-bounds access.

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

