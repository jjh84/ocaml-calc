# 계산기

[CS3110](https://cs3110.github.io/textbook/chapters/interp/calculator.html)의 Interpreter에서 학습한 계산기 프로그램. `dune` 개발환경으로 옮김.

## 사용방법

라이브러리로 구현되어 있기 때문에 `utop`에 로드하여 실험하는게 편하다. 실제로 인터프리터이므로 이게 자연스럽기도 하다.

```
$ dune utop
utop # open Calc;;
utop # interp "1+2+3";;
- : string = "6"
utop # parse "1+2+3";;
- : Calc__Ast.expr =
Calc__.Ast.Binop (Calc__.Ast.Add,
 Calc__.Ast.Binop (Calc__.Ast.Add, Calc__.Ast.Int 1, Calc__.Ast.Int 2),
 Calc__.Ast.Int 3)
```
