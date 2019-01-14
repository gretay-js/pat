open Pat

let max_key = 100

let new_key () =
  Random.int max_key


(* let print t =
 *   let open Core in
 *   iter (fun i -> printf "%d " i) t;
 *   printf "\n" *)

(* let testloop ops =
 *   let t = ref Pat.empty in
 *   for i = 0 to ops do
 *     if Random.bool () then
 *       t := Pat.add (new_key ()) i !t
 *     else if Random.bool () then
 *       t := Pat.remove (new_key ()) !t
 *     else
 *       ignore (Pat.mem (new_key ()) !t)
 *   done;
 *   print !t
 *
 * let randomtest () =
 *   let seed = 42 in
 *   Random.init seed;
 *   testloop 100 *)

let simpletest (module P : S) =
  let t = ref P.empty in
  for i = 0 to 100 do
    t := P.add i i !t
  done;
  (* print !t; *)
  for i = 50 to 100 do
    t := P.remove i !t
  done;
  (* print !t *)
  ()

let () =
  simpletest (module Tree (Params_le));
  simpletest (module Tree (Params_be));
  (* simpletest (module Tree (Params_be_orig2));
   * simpletest (module Tree (Params_bsr_stub));
   * simpletest (module Tree (Params_bsr));
   * simpletest (module Tree (Params_clz)); *)

  (* randomtest () *)
  ()
