grammar Calculator;

program: stat* EOF;		// zero or more repetitions of stat
stat: (expr | assignment)? NEWLINE;	// optative expr followed by an end-of-line
assignment: ID '=' expr;
expr: 
	  op=('+'|'-') expr				# ExprUnary
	| expr op=('*'|'/'|'%') expr	# ExprMultDivMod
	| expr op=('+'|'-') expr		# ExprAddSub
	| Integer						# ExprInteger
	| ID							# ExprId
	| '(' expr ')'					# ExprPar
	;
Integer: [0-9]+;		// fixed point real number
ID: [a-zA-Z]+;
NEWLINE: '\r'? '\n';
WS: [ \t]+ -> skip;
COMMENT: '#' .*? '\n' -> skip;