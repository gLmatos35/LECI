import itertools

class BayesNet:

    def __init__(self, ldep=None):  # Why not ldep={}? See footnote 1.
        if not ldep:
            ldep = {}
        self.dependencies = ldep

    # The network data is stored in a dictionary that
    # associates the dependencies to each variable:
    # { v1:deps1, v2:deps2, ... }
    # These dependencies are themselves given
    # by another dictionary that associates conditional
    # probabilities to conjunctions of mother variables:
    # { mothers1:cp1, mothers2:cp2, ... }
    # The conjunctions are frozensets of pairs (mothervar,boolvalue)
    def add(self,var,mothers,prob):
        self.dependencies.setdefault(var,{})[frozenset(mothers)] = prob

    # Joint probability for a given conjunction of
    # all variables of the network
    def jointProb(self,conjunction):
        prob = 1.0
        for (var,val) in conjunction:
            for (mothers,p) in self.dependencies[var].items():
                if mothers.issubset(conjunction):
                    prob*=(p if val else 1-p)
        return prob

# o que o stor mostrou (nao a resoluçao, mas o que usar para resolver):
# list(itertools.product([True,False],repeat=3))
# list(zip(('a','b','c'),(True, False, True)))
    def individualProb(self, var, val):
        # id as variaveis ascendentes
        variables = [ v for v in self.dependencies if v != var ]
        # variables = [ v for v in self.dependencies.keys() if v != var ]
        
        # gerar todas as conjunções das variaveis ascendentes
        cartesian = list(itertools.product((True, False),repeat = len(variables)))
        cartesian = [ x+(val,) for x in cartesian ]
        conjunctions = [ list(zip(variables + [var], x)) for x in cartesian ]
        
        # calcular o somatorio das probabilidades conjuntas
        return sum(self.jointProb(c) for c in conjunctions)
        
# Footnote 1:
# Default arguments are evaluated on function definition,
# not on function evaluation.
# This creates surprising behaviour when the default argument is mutable.
# See:
# http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments