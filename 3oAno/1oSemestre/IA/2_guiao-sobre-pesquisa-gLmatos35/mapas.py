from constraintsearch import *

region = ['A', 'B', 'C', 'D', 'E']
colors = ['red', 'blue', 'green', 'yellow', 'white']

domains = {v:colors for v in region }

edges = [('E',R) for R in region if R!= 'E' ]
edges += [('A','B'),('B','C'),('C','D'),('D','A')]
edges += [(v2,v1) for (v1,v2) in edges]

def different_color(r1,c1,r2,c2):
	return c1!=c2

constraints = { e:different_color for e in edges }

cs = ConstraintSearch(domains, constraints)

print(cs.search())
