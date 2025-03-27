#encoding: utf8

# YOUR NAME:    Guilherme Leitão de Matos
# YOUR NUMBER:  114252

# COLLEAGUES WITH WHOM YOU DISCUSSED THIS ASSIGNMENT (names, numbers):
# - Rafael Dias - 114258
# - Gabriel Boia - 113167

from semantic_network import *
from constraintsearch import *
from bayes_net import *
import itertools

class MySN(SemanticNetwork):

    def __init__(self):
        SemanticNetwork.__init__(self)
        # ADD CODE HERE IF NEEDED
        pass

    # General query method, processing different types of
    # relations according to their specificities
    def query(self,entity,relname):
        #IMPLEMENT HERE
        ldecl = self.query_local(e1=entity)
        lparent = [i.relation.entity2 for i in ldecl if not isinstance(i.relation, Association)]
        lassoc = [a for a in ldecl if isinstance(a.relation,(Association,Member))]

        # dicionario para verificar qual é o tipo mais abundante
        assocTypes = {'Member': 0, 'AssocSome': 0, 'AssocOne': 0, 'AssocNum': 0}
        
        # heranças
        queue = lparent[:]  
        while queue:
            current = queue.pop(0)  # escolhe e remove o 1º elemento da queue
            pdecl = self.query_local(e1=current)
            lparent_p = [d.relation.entity2 for d in pdecl if not isinstance(d.relation, Association)]
            lassoc.extend(d for d in pdecl if isinstance(d.relation, Association))
            queue.extend(lparent_p)
            
        # somar ao dicionario o nº de "ocorrencias" de cada tipo para dada relação 
        for a in lassoc:
            if a.relation.name == relname:
                tipo = type(a.relation).__name__
                assocTypes[tipo] += 1

        # em caso de empate, é escolhido o primeiro na ordem do dicionário
        chosen = max(assocTypes, key=assocTypes.get)
        if assocTypes[chosen] == 0:
            chosen = 'rip'
        
        if chosen == 'Member':
            return [a.relation.entity2 for a in lassoc if isinstance(a.relation, Member) and a.relation.name == 'member' and type(a.relation).__name__ == 'Member']
        
        elif chosen == 'AssocOne':
            entities = [a.relation.entity2 for a in lassoc if isinstance(a.relation, Association) and a.relation.name == relname and type(a.relation).__name__ == 'AssocOne']
            if entities:
                return [max(set(entities), key=entities.count)]
            
        elif chosen == 'AssocNum':
            values = [a.relation.entity2 for a in lassoc if isinstance(a.relation, Association) and a.relation.name == relname and type(a.relation).__name__ == 'AssocNum']
            if values:
                return [sum(values) / len(values)]
            
        elif chosen == 'AssocSome':
            return list(set([a.relation.entity2 for a in lassoc if isinstance(a.relation, Association) and a.relation.name == relname and type(a.relation).__name__ == 'AssocSome']))
        return []

class MyBN(BayesNet):

    def __init__(self):
        BayesNet.__init__(self)
        # ADD CODE HERE IF NEEDED
        pass
    
    def test_independence(self,v1,v2,given):
        #IMPLEMENT HERE
        # print(self.dependencies)
        arestas = []
    
        # simplificar self.dependencies para usar apenas a informação relevante
        result = {}
        for var, values in self.dependencies.items():
            depend = set()
            for value in values:
                depend.update(value[0])     # value[0] contém a lista de mães para cada key das dependências
            result[var] = list(depend)  

        # print(result)
        # ponto 1 do problema
        variables = {v1,v2} | set(given)
        toAdd = []
    
        # adicionar conexoes diretas
        for var in variables:
            if result[var]:
                for r in result[var]:
                    if r not in variables:
                        toAdd.append(r)

        variables.update(toAdd)   

        # adicionar num loop todas as conexoes das conexoes (e assim em diante até não haver mais)
        added = toAdd
        while(added):
            toAdd = []

            for var in added:
                if result[var]:
                    for r in result[var]:
                        if r not in variables:
                            toAdd.append(r)
            if toAdd:
                variables.update(toAdd)
                added = toAdd
            else: 
                added = []

        # criar lista de tuplos
        arestas = []
        for var in variables:
            for a in result[var]:
                if a not in given and var not in given:
                    arestas.append((var,a))

        # combinaçoes das maes, ponto 2 do problema
        for var in variables:
            if len(result.get(var, [])) > 1:
                deps = result[var]
                for i in range(len(deps)):
                    for j in range(i + 1, len(deps)):
                        arestas.append((deps[i], deps[j]))

        # ponto 3 do problema, remover as que contêm elementos presentes em given
        arestas = [ar for ar in arestas if not any(member in given for member in ar)]

        grafo = {}
        for var1, var2 in arestas:
            if var1 not in grafo:
                grafo[var1] = []
            if var2 not in grafo:
                grafo[var2] = []
            grafo[var1].append(var2)
            grafo[var2].append(var1)
            
        # print(f"grafo = {grafo}")
            
        # função auxiliar para realizar busca em profundidade
        def dfs(current, target, visited):
            if current == target:
                return True
            visited.add(current)
            for neighbor in grafo.get(current, []):
                if neighbor not in visited and neighbor not in given:
                    if dfs(neighbor, target, visited):
                        return True
            return False
        
        # verificar independencia de v1 e v2
        visited = set()
        if dfs(v1, v2, visited):
            return (list(set(arestas)), False)  # há caminho        -> dependentes
        else:
            return (list(set(arestas)), True)   # não há caminho    -> independentes

class MyCS(ConstraintSearch):

    def __init__(self,domains,constraints):
        ConstraintSearch.__init__(self,domains,constraints)
        # ADD CODE HERE IF NEEDED
        pass
 
    def search_all(self, domains=None):
        self.calls += 1

        if domains==None:
            domains = self.domains

        # se alguma variavel tiver lista de valores vazia, falha
        if any([lv == [] for lv in domains.values()]):
            return []

        # se todas as variaveis exactamente um valor, sucesso
        if all([len(lv) == 1 for lv in domains.values()]):
            return [{v: lv[0] for v, lv in domains.items()}]
        
        # seleciona a próxima variável a expandir
        var = min(
            (v for v in domains.keys() if len(domains[v]) > 1), 
            key=lambda v: len(domains[v])
        )

        solutions = []  # possiveis soluçoes

        # continuar pesquisa com todos os valores para a variavel selecionado
        for val in domains[var]:
            new_domains = dict(domains)
            new_domains[var] = [val]
            self.propagate(new_domains, var)
        # recursivamente, explorar sub soluçoes
            sub_solutions = self.search_all(new_domains)
            solutions.extend(sub_solutions)

        return solutions


def handle_ho_constraint(domains, constraints, variables, constraint):
    #     #IMPLEMENT HERE
    # criar var auxiliar
    aux_var = ''.join(variables)
    
    # criar dominio da var auxiliar
    domains[aux_var] = [
        t for t in itertools.product(*(domains[var] for var in variables)) if constraint(t)
    ]
    
    # restriçoes entre a var auxiliar e cada variavel inicial   
    for i, var in enumerate(variables):
        def makeConstraint(idx):
            return lambda v1, x1, v2, x2: (x1[idx] == x2) if v1 == aux_var else (x2[idx] == x1)

        constraints[(aux_var, var)] = makeConstraint(i)
        constraints[(var, aux_var)] = makeConstraint(i)
