load("@npm_bazel_protractor//:index.bzl", "protractor_web_test_suite")
load("@npm_bazel_typescript//:index.bzl", "ts_library")

ts_library(
    name = "e2e",
    testonly = 1,
    srcs = glob(["src/*.ts"]),
    tsconfig = "//angular/src:tsconfig-test",
    deps = [
        "@npm//@types/jasmine",
        "@npm//jasmine",
        "@npm//protractor",
    ],
)

protractor_web_test_suite(
    name = "prodserver_test",
    on_prepare = ":protractor.on-prepare.js",
    server = "//angular/src:prodserver",
    deps = [":e2e"],
)

protractor_web_test_suite(
    name = "devserver_test",
    on_prepare = ":protractor.on-prepare.js",
    server = "//angular/src:devserver",
    deps = [":e2e"],
)
