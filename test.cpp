#include <iostream>
#include <utility>
#include <vector>

int test(const std::vector<std::pair<int, int>>& values, unsigned index) {
    if (index >= values.size()) return 0;
    return values[index].first;
}

int main() {
    std::vector<std::pair<int, int>> values{{1,2},{3,4},{5,6}};
    if (test(values, 3) != 0)
        std::cout << "unexpected result\n";

    return 0;
}
