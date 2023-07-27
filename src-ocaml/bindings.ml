open Python_lib
open Python_lib.Let_syntax
let py_gauss = 
  let%map_open n = keyword "n" int ~docstring:"" 
in fun () -> Model.Gauss.sum_integers_up_to (Z.of_int n) |> Z.to_int |> python_of_int