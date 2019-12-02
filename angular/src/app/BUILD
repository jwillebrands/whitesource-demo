load("@npm_angular_bazel//:index.bzl", "ng_module")

package(default_visibility = ["//:__subpackages__"])

# We don't import from these, but the generated ngfactory code will
NG_FACTORY_ADDED_IMPORTS = [
    "@npm//@angular/animations",
    "@npm//@angular/cdk",
    "@npm//@angular/material",
    "@npm//@angular/forms",
]

ng_module(
    name = "app",
    srcs = glob(["*.ts"]),
    assets = ["app.component.html"],
    tsconfig = "//angular/src:tsconfig.json",
    deps = NG_FACTORY_ADDED_IMPORTS + [
        "//angular/src/app/hello-world",
        "//angular/src/app/home",
        "//angular/src/app/todos",
        "//angular/src/shared/material",
        "@npm//@angular/core",
        "@npm//@angular/router",
        "@npm//@angular/platform-browser",
        "@npm//@ngrx/store",
    ],
)
