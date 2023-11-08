# Shows available options
help: 
  just --list

# Installs dependencies
install: 
  rm -rf build/argfiles
  jresolve --output-file build/argfiles/annotation_processing \
           @deps/annotation_processing
  jresolve --output-file build/argfiles/compile \
           @deps/default @deps/compile
  jresolve --output-file build/argfiles/runtime \
           @deps/default @deps/runtime
  jresolve --output-file build/argfiles/test_compile \
           @deps/default @deps/runtime @deps/test_default
  jresolve --output-file build/argfiles/test_runtime \
           @deps/default @deps/runtime @deps/test_default @deps/test_runtime

# Compiles the code
compile: 
  rm -rf build/modules/dev.mccue.disco
  rm -rf build/modules/dev.mccue.disco.util
  rm -rf build/generated-sources
  javac --module-path @build/argfiles/compile \
        -d build/modules \
        --processor-module-path @build/argfiles/annotation_processing \
        -s build/generated-sources \
        --module-source-path . \
        --module dev.mccue.disco,dev.mccue.disco.util

# Runs the app
run: compile
  java --module-path @build/argfiles/runtime \
       -m dev.mccue.disco/dev.mccue.disco.Stews

# Runs the tests
test: compile
  rm -rf build/modules/dev.mccue.disco.test
  javac --module-path @build/argfiles/test_compile \
        -d build/modules \
        --module-source-path . \
        --module dev.mccue.disco.test
  java --module-path @build/argfiles/test_runtime \
       --add-modules ALL-MODULE-PATH \
       org.junit.platform.console.ConsoleLauncher execute --scan-modules

# Packages the app
package type='app-image': compile
  rm -rf build/package
  jpackage --module-path @build/argfiles/runtime \
           --add-modules dev.mccue.disco \
           --type {{type}} \
           --dest build/package \
           --module dev.mccue.disco/dev.mccue.disco.Stews

# Links the dependencies into a jre
link: compile
  rm -rf build/jre
  jlink --module-path @build/argfiles/runtime \
        --add-modules dev.mccue.disco \
        --output build/jre