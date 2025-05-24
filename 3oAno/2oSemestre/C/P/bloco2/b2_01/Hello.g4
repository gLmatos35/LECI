grammar Hello;				// define a grammar called Hello
main: (greetings | bye)*;	// main: (greetings | bye)*; [nao sei oq é o *]
greetings : 'hello' name;	// match keyword hello followed by an ID
bye: 'bye' name;
name: word+;
word: ID;
ID : [a-zA-Z]+;				// match lower-case IDs
WS : [ \t\r\n]+ -> skip;	// skip spaces, etc