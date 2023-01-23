open Imandra_client_lib

let quiet = false
let has_error () = History.State.(error_seen () || exn_seen ())

let init () =
  Tlcontext.(update_exec_level NO_INTERP);
  Imandra.do_init ~linenoise:false ();
  Debug.setup_logs_reporter ();
  Imandra_util_frontend.Debug_frontend.set_debug_backend_stdout ();

  CCFormat.printf "Loading model...@.";
  let () =
    [ "gauss_vgs" ]
    |> CCList.iter (fun file ->
           if not (has_error ()) then
             let () = Printf.printf "Loading %s.iml\n" file in
             let _ =
               Imandra.eval_string
               @@ CCFormat.sprintf {| #use "%s.iml";; |} file
             in
             ())
  in
  ()

let run_tests () =
  if not (has_error ()) then (
    CCFormat.printf "Closing goals...@.";
    System.eval
      {| [@@@require "imandra-goals-alcotest"];;

       Imandra_goals_alcotest.run_tests ~report_name:"gauss" ()
     |})

let main () =
  try
    init ();
    run_tests ()
  with e ->
    History.State.record_exn_seen ();
    let bt = Printexc.get_raw_backtrace () in
    CCFormat.eprintf "%a" (Imandra_syntax.Util_err.pp_exn ~bt ?input:None) e

let do_exit () = if has_error () then exit 1 else exit 0

let () =
  let server_name =
    Sys.getenv_opt "IMANDRA_SERVER"
    |> CCOption.get_lazy (fun () ->
           let default = "imandra_network_client" in
           CCFormat.eprintf "IMANDRA_SERVER not set; using %S" default;
           default)
  in
  CCFormat.printf "Connecting to Imandra server...@.";
  Client.with_server ~server_name ~socket_dir:"/tmp" (fun ~stop:_stop -> main);
  do_exit ()
