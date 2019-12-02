load("@k8s_deploy//:defaults.bzl", "k8s_deploy")

package(default_visibility = ["//:__subpackages__"])

k8s_deploy(
    name = "deploy",
    images = {
        "gcr.io/internal-200822/src:nodejs_image": "//angular/src:image",
    },
    template = ":deployment.yaml",
)
