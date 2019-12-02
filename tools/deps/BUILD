java_import(
    name = "bazel_deps_prebuilt",
    jars = [":parseproject_deploy.jar"],
)

java_binary(
    name = "parse",
    main_class = "com.github.johnynek.bazel_deps.ParseProject",
    runtime_deps = [":bazel_deps_prebuilt"],
)
