open Python_lib 

let () =
  if not (Py.is_initialized ()) then Py.initialize ();
  let mod_ = Py_module.create "python_gauss" in
  Py_module.set mod_ "gauss" Python_bindings.Bindings.py_gauss;
