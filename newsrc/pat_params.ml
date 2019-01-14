external clz : int -> int = "%clzint"
external bsr : int -> int = "%bsrint"
external bsr_stub : int -> int = "%bsr_stub"

open Pat

let lowest_bit x =
  x land (-x)

(* Versions from the paper name contains orig.
   Provided to check if it is faster when implemented
   directly. *)
let highest_bit_orig_allbits n b0 b1 =
  let m = max 1 (2 * (max b0 b1)) in
  (* zero all bits below m *)
  let x' = n land (lnot  (m-1)) in
  let rec highb x m =
    let m = lowest_bit x in
    if x = m then m else highb (x land (lnot m)) (2*m)
  in highb x' m

let highest_bit_orig_ones n b0 b1=
  let m = max 1 (2 * (max b0 b1)) in
  (* zero all bits below m *)
  let x' = n land (lnot  (m-1)) in
  let rec highb x  =
    let m = lowest_bit x in
    if x = m then m else highb (x-m)
  in highb x'

let highest_bit_stub n _ _ =
  (* Original version. Provided to check if it is faster when implemented
     directly. *)
  1 lsl (bsr_stub n)

let  highest_bit_bsr n _ _ =
  (* Assumes that prefix0 not equal prefix1.
     This assumption holds for patricia trees, because branching bit
     is only computed when prefixes don't match.
     If this is violated, then bsr instruction returns undefined result,
     because (prefix0 lxor prefix1) = 0 and so there are no bits set
     and the index of the set bit is undefined. *)
  (* bsr returns the index of the highest bit set, and we need to covert
     it to the corresponding mask bit by putting 1 in that index only. *)
  1 lsl (bsr n)

let  highest_bit_clz n _ _ =
  (* implement bsr using clz. not portable because the size of int
     is hard-coded.
     Clz is implemented using either bsr or lzcnt instruction.
     lzcnt, but it is faster in our experiments. *)
  1 lsl (63 - (clz n))

let mask_le i bit =
  i land (bit - 1)

let mask_be i bit =
  (i lor (bit - 1)) land (lnot bit)

module Params_le = struct
  let mask = mask_le
  let first_bit_set = (fun x _ _ -> lowest_bit x)
end

module Params_be = struct
  let mask = mask_be
  let first_bit_set = highest_bit_orig_allbits
end

module Params_be_orig2 = struct
  let mask = mask_be
  let first_bit_set = highest_bit_orig_ones
end

module Params_be_bsr_stub = struct
  let mask = mask_be
  let first_bit_set = highest_bit_stub
end

module Params_be_bsr = struct
  let mask = mask_be
  let first_bit_set = highest_bit_bsr
end

module Params_be_clz = struct
  let mask = mask_be
  let first_bit_set = highest_bit_clz
end
