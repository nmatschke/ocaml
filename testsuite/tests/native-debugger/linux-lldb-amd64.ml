(* TEST
   native-compiler;
   no-tsan; (* Skip, TSan inserts extra frames into backtraces *)
   linux;
   arch_amd64;
   script = "sh ${test_source_directory}/has_lldb.sh linux";
   script;
   readonly_files = "meander.ml meander_c.c lldb_test.py";
   setup-ocamlopt.byte-build-env;
   program = "${test_build_directory}/meander";
   flags = "-g";
   all_modules = "meander.ml meander_c.c";
   ocamlopt.byte;
   debugger_script = "${test_source_directory}/lldb-script";
   lldb;
   script = "sh ${test_source_directory}/sanitize.sh ${test_source_directory} \
             ${test_build_directory} ${ocamltest_response} linux-lldb-amd64";
   script;
   check-program-output;
 *)
