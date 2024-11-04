#STUDENT NAME: Guilherme Leitão de Matos
#STUDENT NUMBER: 114252

#DISCUSSED TPI-1 WITH: (names and numbers):
# Rafael Dias - 114258
# Gabriel Boia - 113167

from tree_search import *
from strips import *
from blocksworld import *

class MyNode(SearchNode):

    def __init__(self,state,parent,cost=0,heuristic=0,action=None,arg6=None):
        super().__init__(state,parent)
        #ADD HERE ANY CODE YOU NEED
        self.depth = 0 if parent==None else parent.depth+1
        self.cost = cost
        self.heuristic = heuristic
        self.action = action

class MyTree(SearchTree):

    def __init__(self,problem, strategy='breadth',improve=False):
        super().__init__(problem,strategy)
        #ADD HERE ANY CODE YOU NEED
        self.num_open = 0
        self.num_solution = 0
        self.num_skipped = 0
        self.num_closed = 0
        
        self.improve = improve

    def astar_add_to_open(self,lnewnodes):
        #IMPLEMENT HERE
## organizar de acordo com o pedido: 1. custo + heuristica
##                                   2. depth
##                                   3. ordem alfabetica dos estados
        self.open_nodes.extend(lnewnodes)
        self.open_nodes.sort(key=lambda node: ((node.cost+node.heuristic), (node.depth), (node.state)))          

    def informeddepth_add_to_open(self,lnewnodes):
        # IMPLEMENTAR AQUI
## organizar de acordo com o pedido: 1. custo + heuristica
##                                   2. ordem alfabetica dos estados
        lnewnodes.sort(key=lambda node: ((node.cost+node.heuristic), node.state))
        # self.open_nodes.extend(lnewnodes)
## adicionar ao inicio
        self.open_nodes[:0] = lnewnodes

    def search2(self):
        # IMPLEMENTAR AQUI
## numero inicial de open nodes (deverá ser apenas o node raiz)
        self.num_open = len(self.open_nodes)
## inicialização
        bestSolutionNode = None
## valor de infinito (equiv. a um custo+heuristica muito elevado)
        bestSolutionEval = float('inf')
        
        while self.open_nodes != []:
            node = self.open_nodes.pop(0)
## "remover o node" expandido
            self.num_open -= 1

## isto é necessário para a root, porque ela não é um node do tipo MyNode, mas sim SearchNode
            if (node.parent == None):
                node = MyNode(node.state,node.parent)
            
            if self.problem.goal_test(node.state):
                self.solution = node
## se uma solução nova for encontrada, +1 solução
                self.num_solution += 1
## se improve == False, mantem se como estava anteriormente e dá return à primeira solução
                if not self.improve:
                    return self.get_path(node)
                
                solutionNodeEval = node.cost + node.heuristic
## apenas se o custo + heuristica (algoritmo A*) da nova solução encontrada for melhor que a current best solution, é feito um update 
                if solutionNodeEval < bestSolutionEval:
                    bestSolutionNode = node
                    bestSolutionEval = solutionNodeEval

## somar mais um aos closed nodes apos ser removido da lista de open nodes (sem contar com a solução)
            self.num_closed += 1
            
            lnewnodes = []
            for a in self.problem.domain.actions(node.state):
                newstate = self.problem.domain.result(node.state,a)
                if newstate not in self.get_path(node):
## custo total desde o nó raiz
                    newCost = node.cost + self.problem.domain.cost(node.state, a)
## heuristica do nó atual ao goal
                    heuristicValue = self.problem.domain.heuristic(newstate, self.problem.goal)
## update ao newnode       
                    newnode = MyNode(newstate, node, newCost, heuristicValue, a)

## quando improve == True, apenas adicionar lnewnodes que tenham custo + heuristica inferiores ao melhor até entao encontrado
                    if self.improve:
                        if (newnode.cost + newnode.heuristic) < bestSolutionEval:
                            lnewnodes.append(newnode)
                        else:            
                            self.num_skipped += 1
## verifiquei que num dos testes me faltavam 2 soluções, daí ter adicionado nova condiçao de verificação
## um newnode gerado pode ser uma solução, daí verificar novamente
                            if self.problem.goal_test(newnode.state):
                                self.num_solution += 1
                    else:             
                        lnewnodes.append(newnode)
            
            self.add_to_open(lnewnodes)
## adicionar o número de nodes open
            self.num_open += len(lnewnodes)

        return self.get_path(bestSolutionNode) if bestSolutionNode is not None else None
 
    def check_admissible(self, node):
        # Assume that the given "node" is a solution node
        #IMPLEMENT HERE
## custo da solução
        solution_cost = node.cost
## nó inicial = nó solução
        currentNode = node
        
        while currentNode is not None:
## retornar False caso a heuristica seja superior ao custo (do nó atual até à solução)
            if currentNode.heuristic > (solution_cost - currentNode.cost):
                return False
## update do currentNode para o pai do "atual"
            currentNode = currentNode.parent
        return True


    def get_plan(self,node):
        # IMPLEMENT HERE
## feito das aulas práticas
        if node.parent == None:
            return []
## de forma recursiva, ir progressivamente ao parent do node atual até chegar ao root buscar o path
        plan = self.get_plan(node.parent)
        plan.append(node.action)
        return(plan)

    # if needed, auxiliary methods can be added here

class MyBlocksWorld(STRIPS):

    def heuristic(self, state, goal):
        # IMPLEMENT HERE
## não consegui fazer outra forma que funcionasse
## mesmo conseguindo baixar a heuristica e o numero de nodes abertos/fechados, não
## eram admissable, portanto deixei da maneira mais simples
        cost = sum(1 for block in goal if block not in state)
        return cost

