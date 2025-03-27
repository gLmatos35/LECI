grammar Calculator;
program: stat* EOF;		// zero or more repetitions of stat
stat: expr? NEWLINE;	// optative expr followed by an end-of-line
expr:						
	  op=('+'|'-') expr		# ExprUnary 
	| expr op=('*'|'/'|'%') expr	# ExprMultDivMod
	| expr op=('+'|'-') expr		# ExprAddSub
	| Integer						# ExprInteger
	| '(' expr ')'					# ExprPar
	;
Integer: [0-9]+;		// fixed point real number
NEWLINE: '\r'? '\n';
WS: [ \t]+ -> skip;
COMMENT: '#' .*? '\n' -> skip;

