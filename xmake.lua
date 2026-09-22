set_project("gcc-warray-bounds-false-positive")
set_languages("c++23")

target("gcc-warray-bounds-false-positive")
    set_kind("binary")
    set_default(false)

    add_files("test.cpp")

    add_cxxflags(
        "-O2",
        "-Wall",
        "-Wextra",
        "-Werror",
        {force = true}
    )

    add_tests("compile_fail", {
        build_should_fail = true
    })
