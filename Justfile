# Shows available options
help: 
  just --list

# Installs dependencies
install:
  rm -rf build/argfiles
  jresolve --dependency-file deps/compile --output-file build/argfiles/compile
  jresolve --dependency-file deps/compile,deps/runtime --output-file build/argfiles/runtime
  jresolve --dependency-file deps/compile,deps/runtime,deps/test_compile --output-file build/argfiles/test_compile
  jresolve --dependency-file deps/compile,deps/runtime,deps/test_compile,deps/test_runtime --output-file build/argfiles/test_runtime

# Compiles the code
compile:
  rm -rf build/classes
  javac --class-path @build/argfiles/compile -d build/classes --source-path src src/Main.java

# Runs the program
run: compile
  java --class-path @build/argfiles/runtime Main

# Runs the tests
test: compile
  rm -rf build/test_classes
  javac --class-path @build/argfiles/test_compile -d build/test_classes test/TestEx.java
  java --class-path @build/argfiles/test_runtime org.junit.platform.console.ConsoleLauncher execute --scan-classpath