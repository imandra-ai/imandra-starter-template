open Imandra_client_lib

(** Run a verification goal as an alcotest test case. *)
let verify_test_case ~name ?hints goal =
  Alcotest.test_case name `Quick (fun () ->
      let verify_result = Verify.top ~quiet:true ?hints goal in
      match verify_result with
      | Top_result.V_proved _ -> ()
      | Top_result.V_proved_upto _
      | Top_result.V_refuted _
      | Top_result.V_unknown _  ->
        Alcotest.fail
          (Fmt.strf "%a" Top_result.pp_view (Top_result.Verify verify_result)))

let () =
  Client.with_server ~server_name:"imandra_network_client" (fun () ->
      Tlcontext.update_exec_level NO_INTERP;
      Imandra.do_init ~linenoise:false ();
      System.add_path "../src-iml";
      System.use ~quiet:true "load.iml";
      Alcotest.run "Verficiation Goals"
        [ ( "Guass"
          , [ verify_test_case
                ~name:"Gauss' theorem holds"
                ~hints:Hints.auto
                "Gauss.gauss_theorem" ]
          )
        ])