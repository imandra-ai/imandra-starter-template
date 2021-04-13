open Imandra_client_lib

let quiet = true

let () =
  let server_name =
    Sys.getenv_opt "IMANDRA_SERVER"
    |> CCOpt.get_lazy (fun () ->
           let default = "imandra_network_client" in
           CCFormat.eprintf "IMANDRA_SERVER not set; using %S" default ;
           default )
  in
  CCFormat.printf "Connecting to Imandra server...@." ;
  Client.with_server ~server_name ~socket_dir:"/tmp" (fun () ->
      Tlcontext.update_exec_level NO_INTERP ;
      Imandra.do_init ~linenoise:false () ;

      CCFormat.printf "Loading model...@." ;
      System.eval ~quiet {||} ;
      System.use ~quiet "gauss_vgs.iml" ;

      (* Add more VG files here *)
      CCFormat.printf "Closing goals...@." ;
      System.eval
        ~quiet
        {| [@@@require "imandra-goals-alcotest"];;
         Imandra_goals_alcotest.run_tests ~report_name:"gauss" ()
         |} )
