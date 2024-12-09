from constraintsearch import *

amigos = ["Andre", "Bernardo", "Claudio"]

domains = {"Andre":[("Bernardo","Claudio")],
		"Bernardo":[("André","Claudio"),("Claudio","Andre")],
		"Claudio":[("Andre","Bernardo"),("Bernardo","Andre")]}


edges = [(a1,a2) for a1 in amigos for a2 in amigos if a1!= a2 ]

constraint = lambda a1,t1,a2,t2: t1[0]!=t2[0] and t1[1]!=t2[1]
constraints ={ e:constraint for e in edges }

cs = ConstraintSearch(domains, constraints)

print(cs.search())
