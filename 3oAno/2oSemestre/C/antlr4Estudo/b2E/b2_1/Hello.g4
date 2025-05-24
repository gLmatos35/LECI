grammar Hello;

main: (greetings | farewells)*;	// 0 ou mais ..?

greetings: 'hello' name;
farewells: 'bye' name;

name: word+;

word: ID;
ID: [a-zA-Z]+;
WS: [ \t\r\n]+ -> skip;