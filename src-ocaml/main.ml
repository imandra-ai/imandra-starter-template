let () =
  Printf.printf "Enter a positive integer: %!" ;
  let n = Scanf.scanf "%d" (fun x -> x) in
  Format.printf
    "@.The sum of the integers from 1 to %d is %a@."
    n
    Z.pp_print
    (Model.Gauss.sum_integers_up_to (Z.of_int n))
