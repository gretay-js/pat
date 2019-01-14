open Test

let%bench "le" =
  simpletest (module Tree (Params_le));

let%bench "be" =
  simpletest (module Tree (Params_be));
