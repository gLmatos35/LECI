
# Module: tree_search
# 
# This module provides a set o classes for automated
# problem solving through tree search:
#    SearchDomain  - problem domains
#    SearchProblem - concrete problems to be solved
#    SearchNode    - search tree nodes
#    SearchTree    - search tree with the necessary methods for searhing
#
#  (c) Luis Seabra Lopes
#  Introducao a Inteligencia Artificial, 2012-2020,
#  Inteligência Artificial, 2014-2023

from abc import ABC, abstractmethod

# Dominios de pesquisa
# Permitem calcular
# as accoes possiveis em cada estado, etc
class SearchDomain(ABC):

    # construtor
    @abstractmethod
    def __init__(self):
        pass

    # lista de accoes possiveis num estado
    @abstractmethod
    def actions(self, state):
        pass

    # resultado de uma accao num estado, ou seja, o estado seguinte
    @abstractmethod
    def result(self, state, action):
        pass

    # custo de uma accao num estado
    @abstractmethod
    def cost(self, state, action):
        pass

    # custo estimado de chegar de um estado a outro
    @abstractmethod
    def heuristic(self, state, goal):
        pass

    # test if the given "goal" is satisfied in "state"
    @abstractmethod
    def satisfies(self, state, goal):
        pass


# Problemas concretos a resolver
# dentro de um determinado dominio
class SearchProblem:
    def __init__(self, domain, initial, goal):
        self.domain = domain
        self.initial = initial
        self.goal = goal
    def goal_test(self, state):
        return self.domain.satisfies(state,self.goal)

# Nos de uma arvore de pesquisa
class SearchNode:
    def __init__(self,state,parent, cost=0, heuristic=0): 
        self.state = state
        self.parent = parent
## ex 8 - modificado também o parâmetro de entrada
        self.cost = cost
## ex 2
        self.depth = 0 if parent==None else parent.depth+1
## ex 12 - modificado também o parâmetro de entrada      
        self.heuristic = heuristic
    def __str__(self):
        return "no(" + str(self.state) + "," + str(self.parent) + ")"
    def __repr__(self):
        return str(self)

# Arvores de pesquisa
class SearchTree:
    
    # construtor
    def __init__(self,problem, strategy='breadth'): 
        self.problem = problem
        root = SearchNode(problem.initial, None)
        self.open_nodes = [root]
        self.strategy = strategy
        self.solution = None
        self.highest_cost_nodes = [root]
        self.average_depth = 0
        
    # obter o caminho (sequencia de estados) da raiz ate um no
    def get_path(self,node):
        if node.parent == None:
            return [node.state]
        path = self.get_path(node.parent)
        path += [node.state]
        return(path)

    # procurar a solucao
    def search(self, limit=None):
# os nós terminais estao na fila
# pode ser usado o length dessa fila e um contador para os nao terminais
## ex 5
        self.non_terminals = 0
        #self.terminals = 0
        while self.open_nodes != []:
            node = self.open_nodes.pop(0)
            if self.problem.goal_test(node.state):
                # self.solution é o nó final da pesquisa, vai ser utilizado
                # na property do ex 3
                self.solution = node
## ex 5
                self.terminals = len(self.open_nodes) + 1 # len da lista de nodes terminais + o node final [?]
                return self.get_path(node)
## ex 5 - após serem removidos da lista de nodes, são considerados nodes não terminais
            self.non_terminals += 1
## ex 4 - se este nó não pode ser expandido, passa ao próximo
            if limit != None and node.depth==limit:
                continue
            lnewnodes = []
            for a in self.problem.domain.actions(node.state):
                newstate = self.problem.domain.result(node.state,a)
## ex 1 caso não esteja no path, terá de ser expandido
                if newstate not in self.get_path(node):
## ex 8 atualizar o novoCusto e passa lo para a o novo searchNode
                    newCost = node.cost + self.problem.domain.cost(node.state,a)
                    
## ex 12 a cada expansão, calcular a heurística (pode ou não ser o node final)
## a heurística é a distância entre os pontos inicial e final
## passar o valor de heuristica tambem na criaçao no newnode
                    heuristicVal = self.problem.domain.heuristic(newstate, self.problem.goal)
                    newnode = SearchNode(newstate,node,newCost,heuristicVal)
                    lnewnodes.append(newnode)
## ex 15
                    if newnode.cost > self.highest_cost_nodes[0].cost:
                        self.highest_cost_nodes = [newnode]
                    elif newnode.cost  == self.highest_cost_nodes[0].cost:
                        self.highest_cost_nodes.append(newnode)            

## ex 16, errado - completar depois
            # totalDepth = 0
            # for node in self.open_nodes:
            #     totalDepth += node.depth
            # self.average_depth = totalDepth/len(self.open_nodes)

            self.add_to_open(lnewnodes)
        return None

    # juntar novos nos a lista de nos abertos de acordo com a estrategia
    def add_to_open(self,lnewnodes):
        if self.strategy == 'breadth':
            self.open_nodes.extend(lnewnodes)
        elif self.strategy == 'depth':
            self.open_nodes[:0] = lnewnodes
        elif self.strategy == 'uniform':
## ex 10
            self.open_nodes.extend(lnewnodes)
            self.open_nodes.sort(key=lambda node: node.cost)
## ex 13 adicionar estratégia gulosa, que toma decisões com base na heurística e nao
## no custo acumulado
        elif self.strategy == 'greedy':
            self.open_nodes.extend(lnewnodes)
            self.open_nodes.sort(key=lambda node: node.heuristic)
## ex 14 estratégia A*, toma decisões com base na soma da heuristica e o custo acumulado
        elif self.strategy == 'a*':
            self.open_nodes.extend(lnewnodes)
            self.open_nodes.sort(key=lambda node: node.cost+node.heuristic)            

## ex 3
    @property
    def length(self):
        return self.solution.depth
    
## ex 6
    @property
    def avg_branching(self):
        return (self.terminals + self.non_terminals - 1)/self.non_terminals
    
    @property
    def cost(self):
        return (self.solution.cost)