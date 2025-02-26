(* TEST
   native-compiler;
   no-tsan; (* Skip, TSan inserts extra frames into backtraces *)
   linux;
   arch_arm64;
   script = "sh ${test_source_directory}/has_gdb.sh";
   script;
   readonly_files = "meander.ml meander_c.c gdb_test.py";
   setup-ocamlopt.byte-build-env;
   program = "${test_build_directory}/meander";
   flags = "-g";
   all_modules = "meander.ml meander_c.c";
   ocamlopt.byte;
   debugger_script = "${test_source_directory}/gdb-script";
   gdb;
   script = "sh ${test_source_directory}/sanitize.sh ${test_source_directory} \
   ${test_build_directory} ${ocamltest_response} linux-gdb-arm64";
   script;
   check-program-output;
 *)
