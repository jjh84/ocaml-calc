%{
    open Ast
%}

/* The first section is for declarations, including token and type 
   specifications, precedence directives, and other output directives */

/* The tokes.
   Syntax : %token <type>uid, where the <type> is optional and 
            uid is a capitalized identifier 
            The <type> specifications mean that a token carries a value. */
%token <int> INT
%token TIMES
%token PLUS
%token LPARAN
%token RPARAN
%token EOF

/* Associate precedences and associativities to the given symbols. 

   PLUS and TIMES are left associative, 1 + 2 + 3 will parsed as (1 + 2) + 3.
   Since TIMES appears on a line after PLUS, it has higher precedences than PLUS.

*/
%left PLUS
%left TIMES

/* Declare the given symbols as entry points for the grammar. It says that
   parsing a [prog] will return a OCaml value Ast.expr. */
%start <Ast.expr> prog

%%

prog:
    | e = expr; EOF { e }
    ;

expr:
    | i = INT { Int i }
    | e1 = expr ; TIMES ; e2 = expr { Binop (Mult, e1, e2) }
    | e1 = expr ; PLUS ; e2 = expr { Binop (Add, e1, e2) }
    | LPARAN ; e = expr ; RPARAN { e }
    ;
