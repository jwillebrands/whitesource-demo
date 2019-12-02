# Do not edit. bazel-deps autogenerates this file from.
_JAVA_LIBRARY_TEMPLATE = """
java_library(
  name = "{name}",
  exports = [
      {exports}
  ],
  runtime_deps = [
    {runtime_deps}
  ],
  visibility = [
      "{visibility}"
  ]
)\n"""

_SCALA_IMPORT_TEMPLATE = """
scala_import(
    name = "{name}",
    exports = [
        {exports}
    ],
    jars = [
        {jars}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""

_SCALA_LIBRARY_TEMPLATE = """
scala_library(
    name = "{name}",
    exports = [
        {exports}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""


def _build_external_workspace_from_opts_impl(ctx):
    build_header = ctx.attr.build_header
    separator = ctx.attr.separator
    target_configs = ctx.attr.target_configs

    result_dict = {}
    for key, cfg in target_configs.items():
      build_file_to_target_name = key.split(":")
      build_file = build_file_to_target_name[0]
      target_name = build_file_to_target_name[1]
      if build_file not in result_dict:
        result_dict[build_file] = []
      result_dict[build_file].append(cfg)

    for key, file_entries in result_dict.items():
      build_file_contents = build_header + '\n\n'
      for build_target in file_entries:
        entry_map = {}
        for entry in build_target:
          elements = entry.split(separator)
          build_entry_key = elements[0]
          if elements[1] == "L":
            entry_map[build_entry_key] = [e for e in elements[2::] if len(e) > 0]
          elif elements[1] == "B":
            entry_map[build_entry_key] = (elements[2] == "true" or elements[2] == "True")
          else:
            entry_map[build_entry_key] = elements[2]

        exports_str = ""
        for e in entry_map.get("exports", []):
          exports_str += "\"" + e + "\",\n"

        jars_str = ""
        for e in entry_map.get("jars", []):
          jars_str += "\"" + e + "\",\n"

        runtime_deps_str = ""
        for e in entry_map.get("runtimeDeps", []):
          runtime_deps_str += "\"" + e + "\",\n"

        name = entry_map["name"].split(":")[1]
        if entry_map["lang"] == "java":
            build_file_contents += _JAVA_LIBRARY_TEMPLATE.format(name = name, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "import":
            build_file_contents += _SCALA_IMPORT_TEMPLATE.format(name = name, exports=exports_str, jars=jars_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "library":
            build_file_contents += _SCALA_LIBRARY_TEMPLATE.format(name = name, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        else:
            print(entry_map)

      ctx.file(ctx.path(key + "/BUILD"), build_file_contents, False)
    return None

build_external_workspace_from_opts = repository_rule(
    attrs = {
        "target_configs": attr.string_list_dict(mandatory = True),
        "separator": attr.string(mandatory = True),
        "build_header": attr.string(mandatory = True),
    },
    implementation = _build_external_workspace_from_opts_impl
)




def build_header():
 return """"""

def list_target_data_separator():
 return "|||"

def list_target_data():
    return {
"ch/qos/logback:logback_classic": ["lang||||||java","name||||||//ch/qos/logback:logback_classic","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/ch/qos/logback/logback_classic","runtimeDeps|||L|||//ch/qos/logback:logback_core|||//org/slf4j:slf4j_api","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"ch/qos/logback:logback_core": ["lang||||||java","name||||||//ch/qos/logback:logback_core","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/ch/qos/logback/logback_core","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml:classmate": ["lang||||||java","name||||||//com/fasterxml:classmate","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/classmate","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml/jackson/core:jackson_annotations": ["lang||||||java","name||||||//com/fasterxml/jackson/core:jackson_annotations","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/core/jackson_annotations","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml/jackson/core:jackson_core": ["lang||||||java","name||||||//com/fasterxml/jackson/core:jackson_core","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/core/jackson_core","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml/jackson/core:jackson_databind": ["lang||||||java","name||||||//com/fasterxml/jackson/core:jackson_databind","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/core/jackson_databind","runtimeDeps|||L|||//com/fasterxml/jackson/core:jackson_core|||//com/fasterxml/jackson/core:jackson_annotations","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml/jackson/datatype:jackson_datatype_jdk8": ["lang||||||java","name||||||//com/fasterxml/jackson/datatype:jackson_datatype_jdk8","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/datatype/jackson_datatype_jdk8","runtimeDeps|||L|||//com/fasterxml/jackson/core:jackson_core|||//com/fasterxml/jackson/core:jackson_databind","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml/jackson/datatype:jackson_datatype_jsr310": ["lang||||||java","name||||||//com/fasterxml/jackson/datatype:jackson_datatype_jsr310","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/datatype/jackson_datatype_jsr310","runtimeDeps|||L|||//com/fasterxml/jackson/core:jackson_annotations|||//com/fasterxml/jackson/core:jackson_core|||//com/fasterxml/jackson/core:jackson_databind","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"com/fasterxml/jackson/module:jackson_module_parameter_names": ["lang||||||java","name||||||//com/fasterxml/jackson/module:jackson_module_parameter_names","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/module/jackson_module_parameter_names","runtimeDeps|||L|||//com/fasterxml/jackson/core:jackson_core|||//com/fasterxml/jackson/core:jackson_databind","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"javax/annotation:javax_annotation_api": ["lang||||||java","name||||||//javax/annotation:javax_annotation_api","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/javax/annotation/javax_annotation_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"javax/validation:validation_api": ["lang||||||java","name||||||//javax/validation:validation_api","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/javax/validation/validation_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/apache/logging/log4j:log4j_api": ["lang||||||java","name||||||//org/apache/logging/log4j:log4j_api","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/apache/logging/log4j/log4j_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/apache/logging/log4j:log4j_to_slf4j": ["lang||||||java","name||||||//org/apache/logging/log4j:log4j_to_slf4j","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/apache/logging/log4j/log4j_to_slf4j","runtimeDeps|||L|||//org/slf4j:slf4j_api|||//org/apache/logging/log4j:log4j_api","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/apache/tomcat:tomcat_annotations_api": ["lang||||||java","name||||||//org/apache/tomcat:tomcat_annotations_api","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/apache/tomcat/tomcat_annotations_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/apache/tomcat/embed:tomcat_embed_core": ["lang||||||java","name||||||//org/apache/tomcat/embed:tomcat_embed_core","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/apache/tomcat/embed/tomcat_embed_core","runtimeDeps|||L|||//org/apache/tomcat:tomcat_annotations_api","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/apache/tomcat/embed:tomcat_embed_el": ["lang||||||java","name||||||//org/apache/tomcat/embed:tomcat_embed_el","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/apache/tomcat/embed/tomcat_embed_el","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/apache/tomcat/embed:tomcat_embed_websocket": ["lang||||||java","name||||||//org/apache/tomcat/embed:tomcat_embed_websocket","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/apache/tomcat/embed/tomcat_embed_websocket","runtimeDeps|||L|||//org/apache/tomcat/embed:tomcat_embed_core","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/hamcrest:hamcrest_core": ["lang||||||java","name||||||//org/hamcrest:hamcrest_core","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/hamcrest/hamcrest_core","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/hamcrest:hamcrest_library": ["lang||||||java","name||||||//org/hamcrest:hamcrest_library","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/hamcrest/hamcrest_library","runtimeDeps|||L|||//org/hamcrest:hamcrest_core","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/hibernate/validator:hibernate_validator": ["lang||||||java","name||||||//org/hibernate/validator:hibernate_validator","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/hibernate/validator/hibernate_validator","runtimeDeps|||L|||//javax/validation:validation_api|||//org/jboss/logging:jboss_logging|||//com/fasterxml:classmate","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/jboss/logging:jboss_logging": ["lang||||||java","name||||||//org/jboss/logging:jboss_logging","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/jboss/logging/jboss_logging","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/slf4j:jul_to_slf4j": ["lang||||||java","name||||||//org/slf4j:jul_to_slf4j","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/slf4j/jul_to_slf4j","runtimeDeps|||L|||//org/slf4j:slf4j_api","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/slf4j:slf4j_api": ["lang||||||java","name||||||//org/slf4j:slf4j_api","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/slf4j/slf4j_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_aop": ["lang||||||java","name||||||//org/springframework:spring_aop","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_aop","runtimeDeps|||L|||//org/springframework:spring_beans|||//org/springframework:spring_core","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_beans": ["lang||||||java","name||||||//org/springframework:spring_beans","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_beans","runtimeDeps|||L|||//org/springframework:spring_core","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_context": ["lang||||||java","name||||||//org/springframework:spring_context","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_context","runtimeDeps|||L|||//org/springframework:spring_aop|||//org/springframework:spring_core|||//org/springframework:spring_beans|||//org/springframework:spring_expression","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_core": ["lang||||||java","name||||||//org/springframework:spring_core","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_core","runtimeDeps|||L|||//org/springframework:spring_jcl","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_expression": ["lang||||||java","name||||||//org/springframework:spring_expression","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_expression","runtimeDeps|||L|||//org/springframework:spring_core","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_jcl": ["lang||||||java","name||||||//org/springframework:spring_jcl","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_jcl","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_test": ["lang||||||java","name||||||//org/springframework:spring_test","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_test","runtimeDeps|||L|||//org/springframework:spring_core","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_web": ["lang||||||java","name||||||//org/springframework:spring_web","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_web","runtimeDeps|||L|||//org/springframework:spring_core|||//org/springframework:spring_beans","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework:spring_webmvc": ["lang||||||java","name||||||//org/springframework:spring_webmvc","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/spring_webmvc","runtimeDeps|||L|||//org/springframework:spring_beans|||//org/springframework:spring_web|||//org/springframework:spring_core|||//org/springframework:spring_aop|||//org/springframework:spring_context|||//org/springframework:spring_expression","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot": ["lang||||||java","name||||||//org/springframework/boot:spring_boot","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot","runtimeDeps|||L|||//org/springframework:spring_core|||//org/springframework:spring_context","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_autoconfigure": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_autoconfigure","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_autoconfigure","runtimeDeps|||L|||//org/springframework/boot:spring_boot","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_starter": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_starter","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_starter","runtimeDeps|||L|||//org/springframework:spring_core|||//javax/annotation:javax_annotation_api|||//org/springframework/boot:spring_boot|||//org/springframework/boot:spring_boot_autoconfigure|||//org/springframework/boot:spring_boot_starter_logging|||//org/yaml:snakeyaml","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_starter_json": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_starter_json","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_starter_json","runtimeDeps|||L|||//org/springframework:spring_web|||//org/springframework/boot:spring_boot_starter|||//com/fasterxml/jackson/module:jackson_module_parameter_names|||//com/fasterxml/jackson/datatype:jackson_datatype_jsr310|||//com/fasterxml/jackson/datatype:jackson_datatype_jdk8|||//com/fasterxml/jackson/core:jackson_databind","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_starter_logging": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_starter_logging","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_starter_logging","runtimeDeps|||L|||//ch/qos/logback:logback_classic|||//org/apache/logging/log4j:log4j_to_slf4j|||//org/slf4j:jul_to_slf4j","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_starter_tomcat": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_starter_tomcat","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_starter_tomcat","runtimeDeps|||L|||//javax/annotation:javax_annotation_api|||//org/apache/tomcat/embed:tomcat_embed_el|||//org/apache/tomcat/embed:tomcat_embed_core|||//org/apache/tomcat/embed:tomcat_embed_websocket","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_starter_web": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_starter_web","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_starter_web","runtimeDeps|||L|||//org/springframework/boot:spring_boot_starter_json|||//org/springframework:spring_web|||//org/springframework/boot:spring_boot_starter|||//org/hibernate/validator:hibernate_validator|||//org/springframework:spring_webmvc|||//org/springframework/boot:spring_boot_starter_tomcat","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_test": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_test","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_test","runtimeDeps|||L|||//org/springframework/boot:spring_boot","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/springframework/boot:spring_boot_test_autoconfigure": ["lang||||||java","name||||||//org/springframework/boot:spring_boot_test_autoconfigure","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/springframework/boot/spring_boot_test_autoconfigure","runtimeDeps|||L|||//org/springframework/boot:spring_boot_test|||//org/springframework/boot:spring_boot_autoconfigure","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"org/yaml:snakeyaml": ["lang||||||java","name||||||//org/yaml:snakeyaml","visibility||||||//:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/yaml/snakeyaml","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"]
 }


def build_external_workspace(name):
  return build_external_workspace_from_opts(name = name, target_configs = list_target_data(), separator = list_target_data_separator(), build_header = build_header())

