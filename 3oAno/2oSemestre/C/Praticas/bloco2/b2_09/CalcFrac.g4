grammar CalcFrac;

main: (NL | (stat ';' NL?))* EOF;

stat: print
	| defVar
	;

print: 'print' expr;
defVar: expr '->' VAR;

expr: expr op=('*'|':') expr	#PrdDiv
	| expr op=('+'|'-') expr	#SumSub
	| '(' expr ')'				#Parent
	| n=num ('/' d=NUM)?		#Frac
	| VAR						#VarExpr
	| 'read' STRING				#Input
	| 'reduce' expr				#reduce
	;

num: op=('+'|'-')? NUM;

VAR: [a-z]+;
NUM: [0-9]+;
STRING: [a-zA-Z]+;
NL: '\r'? '\n';
COMMENT: '//' .*? '\n' -> skip;
WS: [ \t]+ -> skip;