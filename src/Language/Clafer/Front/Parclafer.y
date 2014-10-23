-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Language.Clafer.Front.Parclafer where
import Language.Clafer.Front.Absclafer
import Language.Clafer.Front.Lexclafer
import Language.Clafer.Front.ErrM

}

%name pModule Module

-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype { Token }

%token 
 '!' { PT _ (TS _ 1) }
 '!=' { PT _ (TS _ 2) }
 '#' { PT _ (TS _ 3) }
 '&' { PT _ (TS _ 4) }
 '&&' { PT _ (TS _ 5) }
 '(' { PT _ (TS _ 6) }
 ')' { PT _ (TS _ 7) }
 '*' { PT _ (TS _ 8) }
 '+' { PT _ (TS _ 9) }
 '++' { PT _ (TS _ 10) }
 ',' { PT _ (TS _ 11) }
 '-' { PT _ (TS _ 12) }
 '--' { PT _ (TS _ 13) }
 '->' { PT _ (TS _ 14) }
 '->>' { PT _ (TS _ 15) }
 '.' { PT _ (TS _ 16) }
 '..' { PT _ (TS _ 17) }
 '/' { PT _ (TS _ 18) }
 ':' { PT _ (TS _ 19) }
 ':=' { PT _ (TS _ 20) }
 ':>' { PT _ (TS _ 21) }
 ';' { PT _ (TS _ 22) }
 '<' { PT _ (TS _ 23) }
 '<:' { PT _ (TS _ 24) }
 '<<' { PT _ (TS _ 25) }
 '<=' { PT _ (TS _ 26) }
 '<=>' { PT _ (TS _ 27) }
 '=' { PT _ (TS _ 28) }
 '=>' { PT _ (TS _ 29) }
 '>' { PT _ (TS _ 30) }
 '>=' { PT _ (TS _ 31) }
 '>>' { PT _ (TS _ 32) }
 '?' { PT _ (TS _ 33) }
 '[' { PT _ (TS _ 34) }
 '\\' { PT _ (TS _ 35) }
 ']' { PT _ (TS _ 36) }
 '`' { PT _ (TS _ 37) }
 'abstract' { PT _ (TS _ 38) }
 'all' { PT _ (TS _ 39) }
 'disj' { PT _ (TS _ 40) }
 'else' { PT _ (TS _ 41) }
 'enum' { PT _ (TS _ 42) }
 'if' { PT _ (TS _ 43) }
 'in' { PT _ (TS _ 44) }
 'lone' { PT _ (TS _ 45) }
 'max' { PT _ (TS _ 46) }
 'min' { PT _ (TS _ 47) }
 'mux' { PT _ (TS _ 48) }
 'no' { PT _ (TS _ 49) }
 'not' { PT _ (TS _ 50) }
 'one' { PT _ (TS _ 51) }
 'opt' { PT _ (TS _ 52) }
 'or' { PT _ (TS _ 53) }
 'some' { PT _ (TS _ 54) }
 'sum' { PT _ (TS _ 55) }
 'then' { PT _ (TS _ 56) }
 'xor' { PT _ (TS _ 57) }
 '{' { PT _ (TS _ 58) }
 '|' { PT _ (TS _ 59) }
 '||' { PT _ (TS _ 60) }
 '}' { PT _ (TS _ 61) }

L_PosInteger { PT _ (T_PosInteger _) }
L_PosDouble { PT _ (T_PosDouble _) }
L_PosString { PT _ (T_PosString _) }
L_PosIdent { PT _ (T_PosIdent _) }
L_err    { _ }


%%

PosInteger    :: { PosInteger} : L_PosInteger { PosInteger (mkPosToken $1)}
PosDouble    :: { PosDouble} : L_PosDouble { PosDouble (mkPosToken $1)}
PosString    :: { PosString} : L_PosString { PosString (mkPosToken $1)}
PosIdent    :: { PosIdent} : L_PosIdent { PosIdent (mkPosToken $1)}

Module :: { Module }
Module : ListDeclaration { Module ((mkCatSpan $1)) (reverse $1) } 


Declaration :: { Declaration }
Declaration : 'enum' PosIdent '=' ListEnumId { EnumDecl ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 } 
  | Element { ElementDecl ((mkCatSpan $1)) $1 }


Clafer :: { Clafer }
Clafer : Abstract GCard PosIdent Super Card Init Elements { Clafer ((mkCatSpan $1) >- (mkCatSpan $2) >- (mkCatSpan $3) >- (mkCatSpan $4) >- (mkCatSpan $5) >- (mkCatSpan $6) >- (mkCatSpan $7)) $1 $2 $3 $4 $5 $6 $7 } 


Constraint :: { Constraint }
Constraint : '[' ListExp ']' { Constraint ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) } 


SoftConstraint :: { SoftConstraint }
SoftConstraint : '(' ListExp ')' { SoftConstraint ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) } 


Goal :: { Goal }
Goal : '<<' ListExp '>>' { Goal ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) } 


Abstract :: { Abstract }
Abstract : {- empty -} { AbstractEmpty noSpan } 
  | 'abstract' { Abstract ((mkTokenSpan $1)) }


Elements :: { Elements }
Elements : {- empty -} { ElementsEmpty noSpan } 
  | '{' ListElement '}' { ElementsList ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) }


Element :: { Element }
Element : Clafer { Subclafer ((mkCatSpan $1)) $1 } 
  | '`' Name Card Elements { ClaferUse ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkCatSpan $3) >- (mkCatSpan $4)) $2 $3 $4 }
  | Constraint { Subconstraint ((mkCatSpan $1)) $1 }
  | Goal { Subgoal ((mkCatSpan $1)) $1 }
  | SoftConstraint { Subsoftconstraint ((mkCatSpan $1)) $1 }


Super :: { Super }
Super : {- empty -} { SuperEmpty noSpan } 
  | SuperHow SetExp { SuperSome ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 }


SuperHow :: { SuperHow }
SuperHow : ':' { SuperColon ((mkTokenSpan $1)) } 
  | '->' { SuperArrow ((mkTokenSpan $1)) }
  | '->>' { SuperMArrow ((mkTokenSpan $1)) }


Init :: { Init }
Init : {- empty -} { InitEmpty noSpan } 
  | InitHow Exp { InitSome ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 }


InitHow :: { InitHow }
InitHow : '=' { InitHow_1 ((mkTokenSpan $1)) } 
  | ':=' { InitHow_2 ((mkTokenSpan $1)) }


GCard :: { GCard }
GCard : {- empty -} { GCardEmpty noSpan } 
  | 'xor' { GCardXor ((mkTokenSpan $1)) }
  | 'or' { GCardOr ((mkTokenSpan $1)) }
  | 'mux' { GCardMux ((mkTokenSpan $1)) }
  | 'opt' { GCardOpt ((mkTokenSpan $1)) }
  | NCard { GCardInterval ((mkCatSpan $1)) $1 }


Card :: { Card }
Card : {- empty -} { CardEmpty noSpan } 
  | '?' { CardLone ((mkTokenSpan $1)) }
  | '+' { CardSome ((mkTokenSpan $1)) }
  | '*' { CardAny ((mkTokenSpan $1)) }
  | PosInteger { CardNum ((mkCatSpan $1)) $1 }
  | NCard { CardInterval ((mkCatSpan $1)) $1 }


NCard :: { NCard }
NCard : PosInteger '..' ExInteger { NCard ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 


ExInteger :: { ExInteger }
ExInteger : '*' { ExIntegerAst ((mkTokenSpan $1)) } 
  | PosInteger { ExIntegerNum ((mkCatSpan $1)) $1 }


Name :: { Name }
Name : ListModId { Path ((mkCatSpan $1)) $1 } 


Exp :: { Exp }
Exp : 'all' 'disj' Decl '|' Exp { DeclAllDisj ((mkTokenSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3) >- (mkTokenSpan $4) >- (mkCatSpan $5)) $3 $5 } 
  | 'all' Decl '|' Exp { DeclAll ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 }
  | Quant 'disj' Decl '|' Exp { DeclQuantDisj ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3) >- (mkTokenSpan $4) >- (mkCatSpan $5)) $1 $3 $5 }
  | Quant Decl '|' Exp { DeclQuant ((mkCatSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $1 $2 $4 }
  | Exp1 {  $1 }


Exp1 :: { Exp }
Exp1 : 'max' Exp2 { EGMax ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 } 
  | 'min' Exp2 { EGMin ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | Exp1 '<=>' Exp2 { EIff ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp2 {  $1 }


Exp2 :: { Exp }
Exp2 : Exp2 '=>' Exp3 { EImplies ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp3 {  $1 }


Exp3 :: { Exp }
Exp3 : Exp3 '||' Exp4 { EOr ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp4 {  $1 }


Exp4 :: { Exp }
Exp4 : Exp4 'xor' Exp5 { EXor ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp5 {  $1 }


Exp5 :: { Exp }
Exp5 : Exp5 '&&' Exp6 { EAnd ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp6 {  $1 }


Exp6 :: { Exp }
Exp6 : '!' Exp7 { ENeg ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 } 
  | Exp7 {  $1 }


Exp7 :: { Exp }
Exp7 : Exp7 '<' Exp8 { ELt ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp7 '>' Exp8 { EGt ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp7 '=' Exp8 { EEq ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp7 '<=' Exp8 { ELte ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp7 '>=' Exp8 { EGte ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp7 '!=' Exp8 { ENeq ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp7 'in' Exp8 { EIn ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp7 'not' 'in' Exp8 { ENin ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $1 $4 }
  | Exp8 {  $1 }


Exp8 :: { Exp }
Exp8 : Quant Exp12 { QuantExp ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 } 
  | Exp9 {  $1 }


Exp9 :: { Exp }
Exp9 : Exp9 '+' Exp10 { EAdd ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp9 '-' Exp10 { ESub ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp10 {  $1 }


Exp10 :: { Exp }
Exp10 : Exp10 '*' Exp11 { EMul ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp10 '/' Exp11 { EDiv ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp11 {  $1 }


Exp11 :: { Exp }
Exp11 : 'sum' Exp12 { ESumSetExp ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 } 
  | '#' Exp12 { ECSetExp ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | '-' Exp12 { EMinExp ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | Exp12 {  $1 }


Exp12 :: { Exp }
Exp12 : 'if' Exp12 'then' Exp12 'else' Exp13 { EImpliesElse ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4) >- (mkTokenSpan $5) >- (mkCatSpan $6)) $2 $4 $6 } 
  | Exp13 {  $1 }


Exp13 :: { Exp }
Exp13 : PosInteger { EInt ((mkCatSpan $1)) $1 } 
  | PosDouble { EDouble ((mkCatSpan $1)) $1 }
  | PosString { EStr ((mkCatSpan $1)) $1 }
  | SetExp { ESetExp ((mkCatSpan $1)) $1 }
  | '(' Exp ')' {  $2 }


SetExp :: { SetExp }
SetExp : SetExp '++' SetExp1 { Union ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp ',' SetExp1 { UnionCom ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | SetExp1 {  $1 }


SetExp1 :: { SetExp }
SetExp1 : SetExp1 '--' SetExp2 { Difference ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp2 {  $1 }


SetExp2 :: { SetExp }
SetExp2 : SetExp2 '&' SetExp3 { Intersection ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp3 {  $1 }


SetExp3 :: { SetExp }
SetExp3 : SetExp3 '<:' SetExp4 { Domain ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp4 {  $1 }


SetExp4 :: { SetExp }
SetExp4 : SetExp4 ':>' SetExp5 { Range ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp5 {  $1 }


SetExp5 :: { SetExp }
SetExp5 : SetExp5 '.' SetExp6 { Join ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp6 {  $1 }


SetExp6 :: { SetExp }
SetExp6 : Name { ClaferId ((mkCatSpan $1)) $1 } 
  | '(' SetExp ')' {  $2 }


Decl :: { Decl }
Decl : ListLocId ':' SetExp { Decl ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 


Quant :: { Quant }
Quant : 'no' { QuantNo ((mkTokenSpan $1)) } 
  | 'not' { QuantNot ((mkTokenSpan $1)) }
  | 'lone' { QuantLone ((mkTokenSpan $1)) }
  | 'one' { QuantOne ((mkTokenSpan $1)) }
  | 'some' { QuantSome ((mkTokenSpan $1)) }


EnumId :: { EnumId }
EnumId : PosIdent { EnumIdIdent ((mkCatSpan $1)) $1 } 


ModId :: { ModId }
ModId : PosIdent { ModIdIdent ((mkCatSpan $1)) $1 } 


LocId :: { LocId }
LocId : PosIdent { LocIdIdent ((mkCatSpan $1)) $1 } 


ListDeclaration :: { [Declaration] }
ListDeclaration : {- empty -} { []  } 
  | ListDeclaration Declaration { flip (:)  $1 $2 }


ListEnumId :: { [EnumId] }
ListEnumId : EnumId { (:[])  $1 } 
  | EnumId '|' ListEnumId { (:)  $1 $3 }


ListElement :: { [Element] }
ListElement : {- empty -} { []  } 
  | ListElement Element { flip (:)  $1 $2 }


ListExp :: { [Exp] }
ListExp : {- empty -} { []  } 
  | ListExp Exp { flip (:)  $1 $2 }


ListLocId :: { [LocId] }
ListLocId : LocId { (:[])  $1 } 
  | LocId ';' ListLocId { (:)  $1 $3 }


ListModId :: { [ModId] }
ListModId : ModId { (:[])  $1 } 
  | ModId '\\' ListModId { (:)  $1 $3 }



{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad (pp ts) $
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> "before " ++ unwords (map (id . prToken) (take 4 ts))

gp x@(PT (Pn _ l c) _) = Span (Pos (toInteger l) (toInteger c)) (Pos (toInteger l) (toInteger c + toInteger (length $ prToken x)))
pp (PT (Pn _ l c) _ :_) = Pos (toInteger l) (toInteger c)
pp (Err (Pn _ l c) :_) = Pos (toInteger l) (toInteger c)
pp _ = error "EOF"

mkCatSpan :: (Spannable c) => c -> Span
mkCatSpan = getSpan

mkTokenSpan :: Token -> Span
mkTokenSpan = gp
myLexer = tokens
}

