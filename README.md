## GCC `-Warray-bounds` false positive

Minimal C++ reproducer for a GCC `-Warray-bounds` false positive on an
inlined, bounds-checked `std::vector<std::pair<int, int>>` access.

The function returns before indexing when `index >= values.size()`. With GCC
13.3.0 and optimization enabled, the call using `index == values.size()` is
nevertheless diagnosed as an out-of-bounds access.

### Preconditions

The reproducer has been verified with:

- GCC 13.3.0;
- Xmake 3.1.1 for the Xmake test below.

Xmake is optional when invoking `g++` directly.

### Reproduce

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

### Related GCC PRs

- [PR 110620: spurious array-bounds](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110620)
  is the direct upstream match. Its reproducer also uses an inlined,
  size-guarded access to `std::vector<std::pair<int, int>>` at `-O2`. GCC's
  analysis notes that the reported access is on a path which has not yet been
  proved unreachable when the warning runs; a later optimization removes it.
  This repository demonstrates the same issue using an early-return guard and
  `index == size()` at the call site.
- [PR 56456: bogus/missing `-Warray-bounds`](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56456)
  is GCC's umbrella tracking bug for incorrect `-Warray-bounds` diagnostics;
  PR 110620 is linked to that tracker.
