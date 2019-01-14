# Patricia tree implementation

Fast Mergeable Integer Maps (1998)
by Chris Okasaki , Andrew Gill
http://ittc.ku.edu/~andygill/papers/IntMap98.pdf

Implemented in ocaml by Leo White.

Modified to expirement with ocaml intrinsics for bsr and clz, which
can be used to implement "big endian" variant of patricia trees from
the original paper.
