open Python_lib 

let () =
  if not (Py.is_initialized ()) then Py.initialize ();
  let mod_ = Py_module.create "enx_wrapper" in
  Py_module.set mod_ "run_sim" Python_bindings.Bindings.py_gauss;
