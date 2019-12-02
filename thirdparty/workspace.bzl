# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "ch.qos.logback:logback-classic:1.2.3", "lang": "java", "sha1": "7c4f3c474fb2c041d8028740440937705ebb473a", "sha256": "fb53f8539e7fcb8f093a56e138112056ec1dc809ebb020b59d8a36a5ebac37e0", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar", "source": {"sha1": "cfd5385e0c5ed1c8a5dce57d86e79cf357153a64", "sha256": "480cb5e99519271c9256716d4be1a27054047435ff72078d9deae5c6a19f63eb", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3-sources.jar"} , "name": "ch_qos_logback_logback_classic", "actual": "@ch_qos_logback_logback_classic//jar", "bind": "jar/ch/qos/logback/logback_classic"},
    {"artifact": "ch.qos.logback:logback-core:1.2.3", "lang": "java", "sha1": "864344400c3d4d92dfeb0a305dc87d953677c03c", "sha256": "5946d837fe6f960c02a53eda7a6926ecc3c758bbdd69aa453ee429f858217f22", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar", "source": {"sha1": "3ebabe69eba0196af9ad3a814f723fb720b9101e", "sha256": "1f69b6b638ec551d26b10feeade5a2b77abe347f9759da95022f0da9a63a9971", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3-sources.jar"} , "name": "ch_qos_logback_logback_core", "actual": "@ch_qos_logback_logback_core//jar", "bind": "jar/ch/qos/logback/logback_core"},
    {"artifact": "com.fasterxml.jackson.core:jackson-annotations:2.9.0", "lang": "java", "sha1": "07c10d545325e3a6e72e06381afe469fd40eb701", "sha256": "45d32ac61ef8a744b464c54c2b3414be571016dd46bfc2bec226761cf7ae457a", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/core/jackson-annotations/2.9.0/jackson-annotations-2.9.0.jar", "source": {"sha1": "a0ad4e203304ccab7e01266fa814115850edb8a9", "sha256": "eb1e62bc83f4d8e1f0660c9cf2f06d6d196eefb20de265cfff96521015d87020", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/core/jackson-annotations/2.9.0/jackson-annotations-2.9.0-sources.jar"} , "name": "com_fasterxml_jackson_core_jackson_annotations", "actual": "@com_fasterxml_jackson_core_jackson_annotations//jar", "bind": "jar/com/fasterxml/jackson/core/jackson_annotations"},
    {"artifact": "com.fasterxml.jackson.core:jackson-core:2.9.8", "lang": "java", "sha1": "0f5a654e4675769c716e5b387830d19b501ca191", "sha256": "d934dab0bd48994eeea2c1b493cb547158a338a80b58c4fbc8e85fb0905e105f", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/core/jackson-core/2.9.8/jackson-core-2.9.8.jar", "source": {"sha1": "ecaea301e166a0b48f11615864246de739b6619b", "sha256": "4ab3c312f46ddf259de240515c301c99c3a478a749d0ecaaf4395a157a646b33", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/core/jackson-core/2.9.8/jackson-core-2.9.8-sources.jar"} , "name": "com_fasterxml_jackson_core_jackson_core", "actual": "@com_fasterxml_jackson_core_jackson_core//jar", "bind": "jar/com/fasterxml/jackson/core/jackson_core"},
    {"artifact": "com.fasterxml.jackson.core:jackson-databind:2.9.8", "lang": "java", "sha1": "11283f21cc480aa86c4df7a0a3243ec508372ed2", "sha256": "2351c3eba73a545db9079f5d6d768347ad72666537362c8220fe3e950a55a864", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/core/jackson-databind/2.9.8/jackson-databind-2.9.8.jar", "source": {"sha1": "f66792d499a6fea6c7a743558f940e0ebf775ce3", "sha256": "d6b099786ebb86566c44b15b09fde8ba2055f84ca7e98c63677ba8219f04d580", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/core/jackson-databind/2.9.8/jackson-databind-2.9.8-sources.jar"} , "name": "com_fasterxml_jackson_core_jackson_databind", "actual": "@com_fasterxml_jackson_core_jackson_databind//jar", "bind": "jar/com/fasterxml/jackson/core/jackson_databind"},
    {"artifact": "com.fasterxml.jackson.datatype:jackson-datatype-jdk8:2.9.8", "lang": "java", "sha1": "bcd02aa9195390e23747ed40bf76be869ad3a2fb", "sha256": "6d0e43d927c63b25d94130dc95d9b26c031e4516a2b1dfb984dea99bfd49b003", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/datatype/jackson-datatype-jdk8/2.9.8/jackson-datatype-jdk8-2.9.8.jar", "source": {"sha1": "d82c445cc6e5745e7d6eb94b14ca5c2c895369d2", "sha256": "00988940ad4f4a3a93d5ea0585581cacb3a2204ef16f65a04a2fcd153640e07b", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/datatype/jackson-datatype-jdk8/2.9.8/jackson-datatype-jdk8-2.9.8-sources.jar"} , "name": "com_fasterxml_jackson_datatype_jackson_datatype_jdk8", "actual": "@com_fasterxml_jackson_datatype_jackson_datatype_jdk8//jar", "bind": "jar/com/fasterxml/jackson/datatype/jackson_datatype_jdk8"},
    {"artifact": "com.fasterxml.jackson.datatype:jackson-datatype-jsr310:2.9.8", "lang": "java", "sha1": "28ad1bced632ba338e51c825a652f6e11a8e6eac", "sha256": "ab71c4f31c3dd583ba22e15837e9142360f056ad1677f1c2cf2c832d826c8dab", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.9.8/jackson-datatype-jsr310-2.9.8.jar", "source": {"sha1": "b452bf6ebfe953921def884eb2e746218d6e2489", "sha256": "dedbf756339019128c0326b2f9e3c9753b07cc1e44fa96d880a130ad8c707ca2", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.9.8/jackson-datatype-jsr310-2.9.8-sources.jar"} , "name": "com_fasterxml_jackson_datatype_jackson_datatype_jsr310", "actual": "@com_fasterxml_jackson_datatype_jackson_datatype_jsr310//jar", "bind": "jar/com/fasterxml/jackson/datatype/jackson_datatype_jsr310"},
    {"artifact": "com.fasterxml.jackson.module:jackson-module-parameter-names:2.9.8", "lang": "java", "sha1": "c4eef0e6e20d60fb27af4bc4770dba7bcc3f6de6", "sha256": "a7e100dddfdd82c4fb60d0b98a753bd59ce743183b18d4a017d6584f2592df37", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/module/jackson-module-parameter-names/2.9.8/jackson-module-parameter-names-2.9.8.jar", "source": {"sha1": "8d2358499bdaa73ab525ce9cbce90fd8dedb2f0c", "sha256": "d755b3154d216043d1001c626dd9b11ca25358171d3f448c2cf7802af3164649", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/jackson/module/jackson-module-parameter-names/2.9.8/jackson-module-parameter-names-2.9.8-sources.jar"} , "name": "com_fasterxml_jackson_module_jackson_module_parameter_names", "actual": "@com_fasterxml_jackson_module_jackson_module_parameter_names//jar", "bind": "jar/com/fasterxml/jackson/module/jackson_module_parameter_names"},
    {"artifact": "com.fasterxml:classmate:1.3.4", "lang": "java", "sha1": "03d5f48f10bbe4eb7bd862f10c0583be2e0053c6", "sha256": "c2bfcc21467351d0f9a1558822b72dbac2b21f6b9f700a44fc6b345491ef3c88", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/classmate/1.3.4/classmate-1.3.4.jar", "source": {"sha1": "d5aa53c93626884209c1e82fdf44d2ccdaf8e9c2", "sha256": "547e994f6b31599825aff360abdefd3d404b2ff06fdaa051f6f212ddbe48dd7a", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/com/fasterxml/classmate/1.3.4/classmate-1.3.4-sources.jar"} , "name": "com_fasterxml_classmate", "actual": "@com_fasterxml_classmate//jar", "bind": "jar/com/fasterxml/classmate"},
    {"artifact": "javax.annotation:javax.annotation-api:1.3.2", "lang": "java", "sha1": "934c04d3cfef185a8008e7bf34331b79730a9d43", "sha256": "e04ba5195bcd555dc95650f7cc614d151e4bcd52d29a10b8aa2197f3ab89ab9b", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/javax/annotation/javax.annotation-api/1.3.2/javax.annotation-api-1.3.2.jar", "source": {"sha1": "65dfd2c47380bf72ec62a5b8c4ceb78a4eda1a53", "sha256": "128971e52e0d84a66e3b6e049dab8ad7b2c58b7e1ad37fa2debd3d40c2947b95", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/javax/annotation/javax.annotation-api/1.3.2/javax.annotation-api-1.3.2-sources.jar"} , "name": "javax_annotation_javax_annotation_api", "actual": "@javax_annotation_javax_annotation_api//jar", "bind": "jar/javax/annotation/javax_annotation_api"},
    {"artifact": "javax.validation:validation-api:2.0.1.Final", "lang": "java", "sha1": "cb855558e6271b1b32e716d24cb85c7f583ce09e", "sha256": "9873b46df1833c9ee8f5bc1ff6853375115dadd8897bcb5a0dffb5848835ee6c", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/javax/validation/validation-api/2.0.1.Final/validation-api-2.0.1.Final.jar", "source": {"sha1": "4b714a5167580122e46ead3317ffcdcdbd67c5f0", "sha256": "78fc8207d394c91e329be90fc051e98180bd2a35c14e0df73f66a653c7aea19f", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/javax/validation/validation-api/2.0.1.Final/validation-api-2.0.1.Final-sources.jar"} , "name": "javax_validation_validation_api", "actual": "@javax_validation_validation_api//jar", "bind": "jar/javax/validation/validation_api"},
    {"artifact": "org.apache.logging.log4j:log4j-api:2.11.2", "lang": "java", "sha1": "f5e9a2ffca496057d6891a3de65128efc636e26e", "sha256": "09b8ce1740491deefdb3c336855822b64609b457c2966d806348456c0da261d2", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/logging/log4j/log4j-api/2.11.2/log4j-api-2.11.2.jar", "source": {"sha1": "a11bdc0e8f95da31527b4f34f1a35c23e197498d", "sha256": "9c75c657aae31707b46ddfdf3a49f9a1c4b60d07abbfd5a76e9d702c0f316740", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/logging/log4j/log4j-api/2.11.2/log4j-api-2.11.2-sources.jar"} , "name": "org_apache_logging_log4j_log4j_api", "actual": "@org_apache_logging_log4j_log4j_api//jar", "bind": "jar/org/apache/logging/log4j/log4j_api"},
    {"artifact": "org.apache.logging.log4j:log4j-to-slf4j:2.11.2", "lang": "java", "sha1": "6d37bf7b046c0ce2669f26b99365a2cfa45c4c18", "sha256": "4361dd0623b7fc042ad9d6b1eabb0b6a7f92b9cfc21218308f4a386c9ad40ce5", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/logging/log4j/log4j-to-slf4j/2.11.2/log4j-to-slf4j-2.11.2.jar", "source": {"sha1": "5b26345d96fce28b017316c5840484e0e929fa33", "sha256": "22b4b2a576e0b3d92dcec4b1987219e327f32abb19cc4ae9aa491d430df6e77e", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/logging/log4j/log4j-to-slf4j/2.11.2/log4j-to-slf4j-2.11.2-sources.jar"} , "name": "org_apache_logging_log4j_log4j_to_slf4j", "actual": "@org_apache_logging_log4j_log4j_to_slf4j//jar", "bind": "jar/org/apache/logging/log4j/log4j_to_slf4j"},
    {"artifact": "org.apache.tomcat.embed:tomcat-embed-core:9.0.16", "lang": "java", "sha1": "0d7069e3d0f760035b26b68b7b6af5eaa0c1862f", "sha256": "317d6de069561e442bdffebde41f78f674c79b5b592031681aeee56fd421fb61", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/embed/tomcat-embed-core/9.0.16/tomcat-embed-core-9.0.16.jar", "source": {"sha1": "8ac536534b3bca3fad92f85b44a585a365a90e5c", "sha256": "98a6792ae4c0ba59405eec3eac57085c6475e43a98cd5d7ea2a58c75fa0b30d7", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/embed/tomcat-embed-core/9.0.16/tomcat-embed-core-9.0.16-sources.jar"} , "name": "org_apache_tomcat_embed_tomcat_embed_core", "actual": "@org_apache_tomcat_embed_tomcat_embed_core//jar", "bind": "jar/org/apache/tomcat/embed/tomcat_embed_core"},
    {"artifact": "org.apache.tomcat.embed:tomcat-embed-el:9.0.16", "lang": "java", "sha1": "baadc5c97260023078f521cfc0085797f7dde91b", "sha256": "082c155ef65368d37cc607c47b12c7d262ef808de9cd96c7049f753c8b5a6706", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/embed/tomcat-embed-el/9.0.16/tomcat-embed-el-9.0.16.jar", "source": {"sha1": "7d569a216c12285b96342736758f31417e9112cf", "sha256": "91ee6481850ee9dfa7469bb8f8cb8b2fe69499a47afa89a88d332dbebc698001", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/embed/tomcat-embed-el/9.0.16/tomcat-embed-el-9.0.16-sources.jar"} , "name": "org_apache_tomcat_embed_tomcat_embed_el", "actual": "@org_apache_tomcat_embed_tomcat_embed_el//jar", "bind": "jar/org/apache/tomcat/embed/tomcat_embed_el"},
    {"artifact": "org.apache.tomcat.embed:tomcat-embed-websocket:9.0.16", "lang": "java", "sha1": "f5eac487823c68f5d20742a99df1d94350c24d21", "sha256": "31da297c31a5f936024e14e6fd6ce9b6bb7d13933c94ab50aa0b305065624095", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/embed/tomcat-embed-websocket/9.0.16/tomcat-embed-websocket-9.0.16.jar", "source": {"sha1": "1515ca9714c29afc06e16f1515ae5aa34be11466", "sha256": "d5b0ab58b70297e728c94097c05fdb7be2ed3c943153637e8aaa1711cba7aa0f", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/embed/tomcat-embed-websocket/9.0.16/tomcat-embed-websocket-9.0.16-sources.jar"} , "name": "org_apache_tomcat_embed_tomcat_embed_websocket", "actual": "@org_apache_tomcat_embed_tomcat_embed_websocket//jar", "bind": "jar/org/apache/tomcat/embed/tomcat_embed_websocket"},
    {"artifact": "org.apache.tomcat:tomcat-annotations-api:9.0.16", "lang": "java", "sha1": "96d9fc709325f7f3ed175f52068487421747f3cf", "sha256": "98c306850683a3386a34e65a1d314f7f38123cfe73a94a60f3b9dde1488c8713", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/tomcat-annotations-api/9.0.16/tomcat-annotations-api-9.0.16.jar", "source": {"sha1": "46bf05374485a7900aaabc2612cbd6927cfe2405", "sha256": "4cabd36d06cf8d7e2d3d61e97fd58d7ba7542203ad094720b06795c5f2001e3a", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/apache/tomcat/tomcat-annotations-api/9.0.16/tomcat-annotations-api-9.0.16-sources.jar"} , "name": "org_apache_tomcat_tomcat_annotations_api", "actual": "@org_apache_tomcat_tomcat_annotations_api//jar", "bind": "jar/org/apache/tomcat/tomcat_annotations_api"},
    {"artifact": "org.hamcrest:hamcrest-core:1.3", "lang": "java", "sha1": "42a25dc3219429f0e5d060061f71acb49bf010a0", "sha256": "66fdef91e9739348df7a096aa384a5685f4e875584cce89386a7a47251c4d8e9", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar", "source": {"sha1": "1dc37250fbc78e23a65a67fbbaf71d2e9cbc3c0b", "sha256": "e223d2d8fbafd66057a8848cc94222d63c3cedd652cc48eddc0ab5c39c0f84df", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3-sources.jar"} , "name": "org_hamcrest_hamcrest_core", "actual": "@org_hamcrest_hamcrest_core//jar", "bind": "jar/org/hamcrest/hamcrest_core"},
    {"artifact": "org.hamcrest:hamcrest-library:1.3", "lang": "java", "sha1": "4785a3c21320980282f9f33d0d1264a69040538f", "sha256": "711d64522f9ec410983bd310934296da134be4254a125080a0416ec178dfad1c", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/hamcrest/hamcrest-library/1.3/hamcrest-library-1.3.jar", "source": {"sha1": "047a7ee46628ab7133129cd7cef1e92657bc275e", "sha256": "1c0ff84455f539eb3c29a8c430de1f6f6f1ba4b9ab39ca19b195f33203cd539c", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/hamcrest/hamcrest-library/1.3/hamcrest-library-1.3-sources.jar"} , "name": "org_hamcrest_hamcrest_library", "actual": "@org_hamcrest_hamcrest_library//jar", "bind": "jar/org/hamcrest/hamcrest_library"},
    {"artifact": "org.hibernate.validator:hibernate-validator:6.0.14.Final", "lang": "java", "sha1": "c424524aa7718c564d9199ac5892b05901cabae6", "sha256": "8b366c9ad8969a1f25bd81af88a9e8630e70fdf1b6229298c30b58950527802c", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/hibernate/validator/hibernate-validator/6.0.14.Final/hibernate-validator-6.0.14.Final.jar", "source": {"sha1": "1d6c97c1b8db71501d6539e323a9e361544e590f", "sha256": "80f6af9191b3d566c55f3d2477d99614814f9629bd396d50e5eb22e5041883f3", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/hibernate/validator/hibernate-validator/6.0.14.Final/hibernate-validator-6.0.14.Final-sources.jar"} , "name": "org_hibernate_validator_hibernate_validator", "actual": "@org_hibernate_validator_hibernate_validator//jar", "bind": "jar/org/hibernate/validator/hibernate_validator"},
    {"artifact": "org.jboss.logging:jboss-logging:3.3.2.Final", "lang": "java", "sha1": "3789d00e859632e6c6206adc0c71625559e6e3b0", "sha256": "cb914bfe888da7d9162e965ac8b0d6f28f2f32eca944a00fbbf6dd3cf1aacc13", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/jboss/logging/jboss-logging/3.3.2.Final/jboss-logging-3.3.2.Final.jar", "source": {"sha1": "a44f0f22bbd9ccb96952806e73f6cc16ef7d2f67", "sha256": "8eab58199828e20a57a298dc733a42ddfd5936f59217f75da35dfdc74973228a", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/jboss/logging/jboss-logging/3.3.2.Final/jboss-logging-3.3.2.Final-sources.jar"} , "name": "org_jboss_logging_jboss_logging", "actual": "@org_jboss_logging_jboss_logging//jar", "bind": "jar/org/jboss/logging/jboss_logging"},
    {"artifact": "org.slf4j:jul-to-slf4j:1.7.25", "lang": "java", "sha1": "0af5364cd6679bfffb114f0dec8a157aaa283b76", "sha256": "416c5a0c145ad19526e108d44b6bf77b75412d47982cce6ce8d43abdbdbb0fac", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/slf4j/jul-to-slf4j/1.7.25/jul-to-slf4j-1.7.25.jar", "source": {"sha1": "bcea1530927f59b5128841d3571f879ce3af2e86", "sha256": "de45a3712b794146b74a0effb1edb84105acc906208a811479a18978806c3dbd", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/slf4j/jul-to-slf4j/1.7.25/jul-to-slf4j-1.7.25-sources.jar"} , "name": "org_slf4j_jul_to_slf4j", "actual": "@org_slf4j_jul_to_slf4j//jar", "bind": "jar/org/slf4j/jul_to_slf4j"},
    {"artifact": "org.slf4j:slf4j-api:1.7.25", "lang": "java", "sha1": "da76ca59f6a57ee3102f8f9bd9cee742973efa8a", "sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar", "source": {"sha1": "962153db4a9ea71b79d047dfd1b2a0d80d8f4739", "sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar"} , "name": "org_slf4j_slf4j_api", "actual": "@org_slf4j_slf4j_api//jar", "bind": "jar/org/slf4j/slf4j_api"},
    {"artifact": "org.springframework.boot:spring-boot-autoconfigure:2.1.3.RELEASE", "lang": "java", "sha1": "58e07f69638a3ca13dffe8a2b68d284af376d105", "sha256": "81873e18da7657b6f4082c8fd93705b8d462438a2706e92e4a76cedb9f3bd23c", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-autoconfigure/2.1.3.RELEASE/spring-boot-autoconfigure-2.1.3.RELEASE.jar", "source": {"sha1": "6df39e2fbf8757ce2bf084909224e7e78f315ec7", "sha256": "a6a0266c8959850ee16ee7623cdd62374c2a6648039acf6c7a598afa59a3912c", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-autoconfigure/2.1.3.RELEASE/spring-boot-autoconfigure-2.1.3.RELEASE-sources.jar"} , "name": "org_springframework_boot_spring_boot_autoconfigure", "actual": "@org_springframework_boot_spring_boot_autoconfigure//jar", "bind": "jar/org/springframework/boot/spring_boot_autoconfigure"},
    {"artifact": "org.springframework.boot:spring-boot-starter-json:2.1.3.RELEASE", "lang": "java", "sha1": "374c3de160f59ee2de2f78f2285ecc9b593caa71", "sha256": "bbf52e2361343d34844fc9482be513728e5627dba2345c7ca29c0cef27e1fd0e", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-starter-json/2.1.3.RELEASE/spring-boot-starter-json-2.1.3.RELEASE.jar", "name": "org_springframework_boot_spring_boot_starter_json", "actual": "@org_springframework_boot_spring_boot_starter_json//jar", "bind": "jar/org/springframework/boot/spring_boot_starter_json"},
    {"artifact": "org.springframework.boot:spring-boot-starter-logging:2.1.3.RELEASE", "lang": "java", "sha1": "3ae3b090dfd65caa44e7fd12e433b68b48c24c99", "sha256": "d9e7beac64cfc82f2bd0ccbda0afea43755c6e1a84291be5b2921b79c644fbba", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-starter-logging/2.1.3.RELEASE/spring-boot-starter-logging-2.1.3.RELEASE.jar", "name": "org_springframework_boot_spring_boot_starter_logging", "actual": "@org_springframework_boot_spring_boot_starter_logging//jar", "bind": "jar/org/springframework/boot/spring_boot_starter_logging"},
    {"artifact": "org.springframework.boot:spring-boot-starter-tomcat:2.1.3.RELEASE", "lang": "java", "sha1": "653f835a6da031622636379dca873be106aeddb4", "sha256": "55c328649576740f6ea88b60447dfead20fa1eb1f96cbe91c140784621d45ac4", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-starter-tomcat/2.1.3.RELEASE/spring-boot-starter-tomcat-2.1.3.RELEASE.jar", "name": "org_springframework_boot_spring_boot_starter_tomcat", "actual": "@org_springframework_boot_spring_boot_starter_tomcat//jar", "bind": "jar/org/springframework/boot/spring_boot_starter_tomcat"},
    {"artifact": "org.springframework.boot:spring-boot-starter-web:2.1.3.RELEASE", "lang": "java", "sha1": "e65a0538c3075a0910e7273a9dbedb189761b1ae", "sha256": "511470fe37189f0e223586328a7a94aed91db26e5adca3d92c11ba483f41be53", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-starter-web/2.1.3.RELEASE/spring-boot-starter-web-2.1.3.RELEASE.jar", "name": "org_springframework_boot_spring_boot_starter_web", "actual": "@org_springframework_boot_spring_boot_starter_web//jar", "bind": "jar/org/springframework/boot/spring_boot_starter_web"},
    {"artifact": "org.springframework.boot:spring-boot-starter:2.1.3.RELEASE", "lang": "java", "sha1": "bf73ada346b2956cbd10067830ac58aa55c46176", "sha256": "0c290c97f69535c9bcd5246a2391c744d109fa9d346faa014dea8dcddf763b13", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-starter/2.1.3.RELEASE/spring-boot-starter-2.1.3.RELEASE.jar", "name": "org_springframework_boot_spring_boot_starter", "actual": "@org_springframework_boot_spring_boot_starter//jar", "bind": "jar/org/springframework/boot/spring_boot_starter"},
    {"artifact": "org.springframework.boot:spring-boot-test-autoconfigure:2.1.3.RELEASE", "lang": "java", "sha1": "f667520b788e87a38bcee2538fce16d3d1a484a5", "sha256": "08df511bc81231b20fe52d2fd9de9b53112ed4dacc9d7a999b1b6782962ec939", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-test-autoconfigure/2.1.3.RELEASE/spring-boot-test-autoconfigure-2.1.3.RELEASE.jar", "source": {"sha1": "8e7fbe82abd4e83b213a6045cb691861156668bb", "sha256": "0916b7f9acc03cf85d6def0a083c5969e86ac8a4103b08bfdbc4d6e7ef02d44f", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-test-autoconfigure/2.1.3.RELEASE/spring-boot-test-autoconfigure-2.1.3.RELEASE-sources.jar"} , "name": "org_springframework_boot_spring_boot_test_autoconfigure", "actual": "@org_springframework_boot_spring_boot_test_autoconfigure//jar", "bind": "jar/org/springframework/boot/spring_boot_test_autoconfigure"},
    {"artifact": "org.springframework.boot:spring-boot-test:2.1.3.RELEASE", "lang": "java", "sha1": "3615e9ac8c032ff246d6f30fe36642333e45881d", "sha256": "ed3c1cb85839bdeec03083af8d594e20c4f0e60a09704c10677825f34987acdb", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-test/2.1.3.RELEASE/spring-boot-test-2.1.3.RELEASE.jar", "source": {"sha1": "8dc9577a4c20058f6ff101a4c664d9ceecc903fd", "sha256": "1f2452c8edd441be5b356f05bff87ed06c5431b98e3c22cc0f7f504cb493128a", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot-test/2.1.3.RELEASE/spring-boot-test-2.1.3.RELEASE-sources.jar"} , "name": "org_springframework_boot_spring_boot_test", "actual": "@org_springframework_boot_spring_boot_test//jar", "bind": "jar/org/springframework/boot/spring_boot_test"},
    {"artifact": "org.springframework.boot:spring-boot:2.1.3.RELEASE", "lang": "java", "sha1": "92bb92cd73212cefc1e5112e3bbf1f31c154c3fd", "sha256": "b94730a5420b92201b48b044b2368fc75ace3d9095cf243350d3b396f1b125a8", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot/2.1.3.RELEASE/spring-boot-2.1.3.RELEASE.jar", "source": {"sha1": "05759c931e1287f82d132f37fcb14c396836ee42", "sha256": "0d0e54c3cdeddc1b3cd2be205ccba2cd73061def02d3f4f0d0191f38c7be64dd", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/boot/spring-boot/2.1.3.RELEASE/spring-boot-2.1.3.RELEASE-sources.jar"} , "name": "org_springframework_boot_spring_boot", "actual": "@org_springframework_boot_spring_boot//jar", "bind": "jar/org/springframework/boot/spring_boot"},
    {"artifact": "org.springframework:spring-aop:5.1.5.RELEASE", "lang": "java", "sha1": "5e6ab23bc14369b0e29881afd85ad13b79846a0e", "sha256": "3a65f53ff7b61f68a29ee672a3f683f046602e766f5a10eabab7c0dc2a827757", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-aop/5.1.5.RELEASE/spring-aop-5.1.5.RELEASE.jar", "source": {"sha1": "0992ff1c4ce798a61c8d060c3edc7b08742fa36a", "sha256": "14d8dca62e5fbd5202a76f98cbdc9f33b950d174e72ac98b6df7f655ef6bc9e4", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-aop/5.1.5.RELEASE/spring-aop-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_aop", "actual": "@org_springframework_spring_aop//jar", "bind": "jar/org/springframework/spring_aop"},
    {"artifact": "org.springframework:spring-beans:5.1.5.RELEASE", "lang": "java", "sha1": "58b10c61f6bf2362909d884813c4049b657735f5", "sha256": "7f759c26bfc4697346de39993df48b2dac49f502d5d4e5d69f19054edc4376f5", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-beans/5.1.5.RELEASE/spring-beans-5.1.5.RELEASE.jar", "source": {"sha1": "65b8846a1d79cfff2bcd44e0d40c5f95c5cb2d14", "sha256": "d85f341b1d878fb4f34211bdc3dd66cf5de54ebf0a553eea04ac3dbcefcd66ca", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-beans/5.1.5.RELEASE/spring-beans-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_beans", "actual": "@org_springframework_spring_beans//jar", "bind": "jar/org/springframework/spring_beans"},
    {"artifact": "org.springframework:spring-context:5.1.5.RELEASE", "lang": "java", "sha1": "d39299241a2c8353d83f0f0c84d3677973da7c57", "sha256": "6140252422a01d85dbd75fd2d6e8d4a7856f7c6ba6be4c5b59ff5f4b800d498b", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-context/5.1.5.RELEASE/spring-context-5.1.5.RELEASE.jar", "source": {"sha1": "9f42597b821f59087bf759695992c5ea8a1fcf0d", "sha256": "1d94266215f362424c22013624a20f6891a6eb78e98a6f68d8afd267933a25ee", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-context/5.1.5.RELEASE/spring-context-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_context", "actual": "@org_springframework_spring_context//jar", "bind": "jar/org/springframework/spring_context"},
    {"artifact": "org.springframework:spring-core:5.1.5.RELEASE", "lang": "java", "sha1": "aacc4555108f3da913a58114b2aebc819f58cce4", "sha256": "f771b605019eb9d2cf8f60c25c050233e39487ff54d74c93d687ea8de8b7285a", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-core/5.1.5.RELEASE/spring-core-5.1.5.RELEASE.jar", "source": {"sha1": "407c8f57c15605a13c76a869357181825a7a5db1", "sha256": "b7e53176f1dbb4e5122c647e7f0775b888be65d7bd967a8f079ecebc8689d35d", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-core/5.1.5.RELEASE/spring-core-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_core", "actual": "@org_springframework_spring_core//jar", "bind": "jar/org/springframework/spring_core"},
    {"artifact": "org.springframework:spring-expression:5.1.5.RELEASE", "lang": "java", "sha1": "b728a06924560ee69307a52d100e6b156d9a4a80", "sha256": "c3c25bf89de3e277926abb0f32655ff5e365e1d1eed8c8602e05b07126bba1cf", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-expression/5.1.5.RELEASE/spring-expression-5.1.5.RELEASE.jar", "source": {"sha1": "f03464511a63a756a470827c890de12b733412ba", "sha256": "ee0d12bce9f3e5bf5de79245db718c7aad4ec74087935ba1e11f8037d7187a92", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-expression/5.1.5.RELEASE/spring-expression-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_expression", "actual": "@org_springframework_spring_expression//jar", "bind": "jar/org/springframework/spring_expression"},
    {"artifact": "org.springframework:spring-jcl:5.1.5.RELEASE", "lang": "java", "sha1": "5cbd44d11a031c64c788edf1f99706b31c434469", "sha256": "194423c7c485e40706d74c01a36b1f0aad436f0b55958f06ac95bcbac65bf4e6", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-jcl/5.1.5.RELEASE/spring-jcl-5.1.5.RELEASE.jar", "source": {"sha1": "6f3212c91ac78f8cc4bcaf600f624f92a6287ca6", "sha256": "7279dc8e2dab344996afb6884351e94de76c2720bae27a79a609ad80d2b8c9c3", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-jcl/5.1.5.RELEASE/spring-jcl-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_jcl", "actual": "@org_springframework_spring_jcl//jar", "bind": "jar/org/springframework/spring_jcl"},
    {"artifact": "org.springframework:spring-test:5.1.5.RELEASE", "lang": "java", "sha1": "0693fac3c64b4617b7c2b207e45e93529f6594bd", "sha256": "f3629e1e657e5b395fef09af986b77f738d83d6beefbb8be4d70f31f5affda51", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-test/5.1.5.RELEASE/spring-test-5.1.5.RELEASE.jar", "source": {"sha1": "914fe3553db493413746a350230c4300f6d5d910", "sha256": "457ae5419abdfaa2c3cb381fdd2ced554221eb3d84e019c4df3383bda281da1e", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-test/5.1.5.RELEASE/spring-test-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_test", "actual": "@org_springframework_spring_test//jar", "bind": "jar/org/springframework/spring_test"},
    {"artifact": "org.springframework:spring-web:5.1.5.RELEASE", "lang": "java", "sha1": "c37c4363be4ad6c5f67e3f9f020497e2d599e325", "sha256": "0a7a9111a6aae028dc7ceefa3cfee76c01e70f8e61cd2289a0271b16975f76f7", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-web/5.1.5.RELEASE/spring-web-5.1.5.RELEASE.jar", "source": {"sha1": "46673f1424ad8dc3a9fc39a96730e1ee2663fc18", "sha256": "0b912b06245fed315c146ebc2e49820f70a4dbed439ea0eed711b7f6173c6bcb", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-web/5.1.5.RELEASE/spring-web-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_web", "actual": "@org_springframework_spring_web//jar", "bind": "jar/org/springframework/spring_web"},
    {"artifact": "org.springframework:spring-webmvc:5.1.5.RELEASE", "lang": "java", "sha1": "236e3bfdbdc6c86629237a74f0f11414adb4e211", "sha256": "7953dc786a5ee32a267cdf8e9be08b94f7cb52bf88dd9752e29ba17943884eb7", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-webmvc/5.1.5.RELEASE/spring-webmvc-5.1.5.RELEASE.jar", "source": {"sha1": "b2338b40c93e2f46df679a1a5a1ddca913dd111f", "sha256": "7fd51560c3be63e21ca5c06e229e7235131b1bd2191e7e7f4e56ef9de72fcac0", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/springframework/spring-webmvc/5.1.5.RELEASE/spring-webmvc-5.1.5.RELEASE-sources.jar"} , "name": "org_springframework_spring_webmvc", "actual": "@org_springframework_spring_webmvc//jar", "bind": "jar/org/springframework/spring_webmvc"},
    {"artifact": "org.yaml:snakeyaml:1.23", "lang": "java", "sha1": "ec62d74fe50689c28c0ff5b35d3aebcaa8b5be68", "sha256": "13009fb5ede3cf2be5a8d0f1602155aeaa0ce5ef5f9366892bd258d8d3d4d2b1", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/yaml/snakeyaml/1.23/snakeyaml-1.23.jar", "source": {"sha1": "1186bcf89d33080275bab74a0b0f495af5c812ef", "sha256": "ec649cde6353321553eebc3ccf7c473663113d17d724df94541de88e06101d53", "repository": "https://jcenter.bintray.com", "url": "https://jcenter.bintray.com/org/yaml/snakeyaml/1.23/snakeyaml-1.23-sources.jar"} , "name": "org_yaml_snakeyaml", "actual": "@org_yaml_snakeyaml//jar", "bind": "jar/org/yaml/snakeyaml"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
