open Ast

(** [is_value e] is whether [e] is a value. *)
let is_value e =
  match e with
  | Int _ -> true
  | _ -> false

(** [step e] takes a single step of evaluation of [e]. *)
let rec step e =
  match e with
  | Int _ -> failwith "Does not step"
  | Binop (bop, e1, e2) when is_value e1 && is_value e2 ->
    step_bop bop e1 e2
  | Binop (bop, e1, e2) when is_value e1 -> 
    Binop (bop, e1, step e2)
  | Binop (bop, e1, e2) -> Binop (bop, step e1, e2)

(** [step_bop bop v1 v2] implements the primitive operation
    [v1 bop v2]. Requires: [v1] and [v2] are both values. *)
and step_bop bop e1 e2 =
    match bop, e1, e2 with
    | Add, Int a, Int b -> Int (a + b)
    | Mult, Int a, Int b -> Int (a * b)
    | _ -> failwith "precondition violated"

(** [eval e] fully evaluates [e] to a value. *)
let rec eval e =
  if is_value e then e
  else e |> step |> eval

(** [parse s] parses [s] into an AST. *)
let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

(** [string_of_val e] converts [e] to a string.
    Requires: [e] is a value. *)
let string_of_val e =
  match e with
  | Int i -> string_of_int i
  | Binop _ -> failwith "precondition violated"

let interp s =
  s |> parse |> eval |> string_of_val