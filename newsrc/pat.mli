module type S = sig
  type 'a t
  val empty : 'a t
  val is_empty : 'a t -> bool
  val singleton : int -> 'a -> 'a t
  val mem : int -> 'a t -> bool
  val add : int -> 'a -> 'a t -> 'a t
  val remove : int -> 'a t -> 'a t
  val union : 'a t -> 'a t -> 'a t
  val subset : 'a t -> 'b t -> bool
  val inter : 'a t -> 'a t -> 'a t
  val diff : 'a t -> 'b t -> 'a t
  val cardinal : 'a t -> int
  val iter : ('a -> unit) -> 'a t -> unit
  val fold : ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b
  val for_all : ('a -> bool) -> 'a t -> bool
  val exists : ('a -> bool) -> 'a t -> bool
  val filter : ('a -> bool) -> 'a t -> 'a t
  val partition : ('a -> bool) -> 'a t -> 'a t * 'a t
  val choose : 'a t -> 'a
  val elements : 'a t -> 'a list
  val min_elt : 'a t -> 'a
  val max_elt : 'a t -> 'a
  val equal : 'a t -> 'b t -> bool
  val compare : 'a t -> 'b t -> int
  val split : int -> 'a t -> 'a t * bool * 'a t
  val find : int -> 'a t -> 'a
end

module type Params = sig
  val mask : int -> int -> int
  val first_bit_set :  int -> int -> int -> int
end

module Tree : Params -> S
