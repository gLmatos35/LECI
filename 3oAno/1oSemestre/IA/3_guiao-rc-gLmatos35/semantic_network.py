# Guiao de representacao do conhecimento
# -- Redes semanticas
# 
# Inteligencia Artificial & Introducao a Inteligencia Artificial
# DETI / UA
#
# (c) Luis Seabra Lopes, 2012-2020
# v1.9 - 2019/10/20
#


# Classe Relation, com as seguintes classes derivadas:
#     - Association - uma associacao generica entre duas entidades
#     - Subtype     - uma relacao de subtipo entre dois tipos
#     - Member      - uma relacao de pertenca de uma instancia a um tipo
#

class Relation:
    def __init__(self,e1,rel,e2):
        self.entity1 = e1
#       self.relation = rel  # obsoleto
        self.name = rel
        self.entity2 = e2
    def __str__(self):
        return self.name + "(" + str(self.entity1) + "," + \
               str(self.entity2) + ")"
    def __repr__(self):
        return str(self)


# Subclasse Association
class Association(Relation):
    def __init__(self,e1,assoc,e2):
        Relation.__init__(self,e1,assoc,e2)

#   Exemplo:
#   a = Association('socrates','professor','filosofia')

# Subclasse Subtype
class Subtype(Relation):
    def __init__(self,sub,super):
        Relation.__init__(self,sub,"subtype",super)


#   Exemplo:
#   s = Subtype('homem','mamifero')

# Subclasse Member
class Member(Relation):
    def __init__(self,obj,type):
        Relation.__init__(self,obj,"member",type)

#   Exemplo:
#   m = Member('socrates','homem')

# classe Declaration
# -- associa um utilizador a uma relacao por si inserida
#    na rede semantica
#
class Declaration:
    def __init__(self,user,rel):
        self.user = user
        self.relation = rel
    def __str__(self):
        return "decl("+str(self.user)+","+str(self.relation)+")"
    def __repr__(self):
        return str(self)

#   Exemplos:
#   da = Declaration('descartes',a)
#   ds = Declaration('darwin',s)
#   dm = Declaration('descartes',m)

# classe SemanticNetwork
# -- composta por um conjunto de declaracoes
#    armazenado na forma de uma lista
#
class SemanticNetwork:
    def __init__(self,ldecl=None):
        self.declarations = [] if ldecl==None else ldecl
    def __str__(self):
        return str(self.declarations)
    def insert(self,decl):
        self.declarations.append(decl)
    def query_local(self,user=None,e1=None,rel=None,e2=None):
        self.query_result = \
            [ d for d in self.declarations
                if  (user == None or d.user==user)
                and (e1 == None or d.relation.entity1 == e1)
                and (rel == None or d.relation.name == rel)
                and (e2 == None or d.relation.entity2 == e2) ]
        return self.query_result
    def show_query_result(self):
        for d in self.query_result:
            print(str(d))


    ##########################################
    #                                        #
    #    # Member(Obj, Tipo)                 #
    #    # Subtype(T1, T2)                   #
    #    # Association(E1, AssocName, E2)    #
    #                                        #
    ##########################################
    
    # o primeiro argumento é sempre entity1 e o segundo entity2 
    
## ex1
    def list_associations(self):    # nao incluir member nem subtype #(?)
        lassoc = [d.relation.name for d in self.declarations
                  if isinstance(d.relation,Association)]
        return list(set(lassoc))
    
## ex2
    def list_objects(self):    # nao incluir member nem subtype #(?)
        lobj = [d.relation.entity1 for d in self.declarations
                  if isinstance(d.relation,Member)]
        return list(set(lobj))
    
## ex3
    def list_users(self):
        lusers = [d.user for d in self.declarations]
        return list(set(lusers))
    
## ex4
    def list_types(self):
        ltypes = [d.relation.entity1 for d in self.declarations
                  if isinstance(d.relation,Subtype)]
        ltypes += [d.relation.entity2 for d in self.declarations
                  if not isinstance(d.relation,Association)]
        return list(set(ltypes))
    
## ex5
    def list_local_associations(self, entity):    ## nao incluir "member" nem "subtype"
        llocalassoc = [d.relation.name for d in self.declarations
                  if isinstance(d.relation,Association)
                  and d.relation.entity1==entity]
        return list(set(llocalassoc))
    
## ... corrigir e fazer os outros em casa     
## ex6
    def list_relations_by_user(self, user):
        lrel = [d.relation.name for d in self.declarations
                if isinstance(d.relation, Relation)     # ?
                and d.user==user]
        return list(set(lrel))
        
## do boia - dei reset ao que tinha lol
## ex7
    def associations_by_user(self,user):
        return len(list({i.relation.name for i in self.query_local(user=user) if isinstance(i.relation,Association)}))

# boia
## ex8
    def list_local_associations_by_entity(self,entity):
        return list({(i.relation.name,i.user) for i in self.query_local(e1=entity) if isinstance(i.relation,Association)})
    
        
	## num terminal em python:
		## from sn_example import*
		## z.query_local(rel="member")
  
    # bloco de notas (telemóvel -> IA - rc) - ver esquema
  
## ex9
    def predecessor(self, pred, desc):      ## recursividade com retrocesso - resultado final é como se fosse pesquisa em profundidade
        # lista de filhos da entidade pred
        lchild = [d.relation.entity1 for d in self.declarations
                  if d.relation.entity2 == pred
                  and not isinstance(d.relation,Association)]
        # identificar uma situação terminal e fazer recursão
        for c in lchild:
            if c == desc: return True
            return self.predecessor(c,desc)
        
## ex10 - semelhante ao 9, so fiz copy paste nao alterei nada ainda
    # def predecessor_path(self, pred, desc):
    #     lchild = [d.relation.entity1 for d in self.declarations
    #               if d.relation.entity2 == pred
    #               and not isinstance(d.relation,Association)]
    #     # identificar uma situação terminal e fazer recursão
    #     for c in lchild:
    #         if c == desc: return [c]
    #         return [c] + self.predecessor(c,desc)
## corrigir o meu acima depois    
## boia
    def predecessor_path(self,predecessor,descendent):
        lchild = [i.relation.entity1 for i in self.declarations if i.relation.entity2 == predecessor and not isinstance(i.relation,Association)]
        for i in lchild:
            if i == descendent:
                return [predecessor,i]
            if self.predecessor(i,descendent):
                return [predecessor] + self.predecessor_path(i,descendent)
        return None  
  
    	## num terminal em python:
		## from sn_example import*
		## z.query_local(e1='mamífero')
  
## ex11 - ainda não está totalmente correto
    # falta considerar a assoc dada (que é opcional ser ou não fornecida)
    # def query(self, entity, assoc=None):
    #     ldecl = self.query_local(e1=entity)
    #     lparent = [d.relation.entity2 for d in ldecl
    #                if not isinstance(d.relation, Association)]
    #     lassoc = [ d for d in ldecl if isinstance(d.relation, Association)]
        
    #     for p in lparent:
    #         lassoc += self.query(p)
        # return lassoc if assoc==None else [... for .. rel. ...]
## corrigir/terminar o acima

## aqui para frente é do boia
## ex11a
    def query(self,entity,association=None):
        ldecl = self.query_local(e1=entity)
        lparent = [i.relation.entity2 for i in ldecl if not isinstance(i.relation,Association)]
        lassoc = [i for i in ldecl if isinstance(i.relation,Association)]
        for i in lparent:
            lassoc += self.query(i)
        return lassoc if association == None else list({i for i in lassoc if i.relation.name == association})

## ex11b
    def query2(self,entity,relation=None):
        ldecl_subtype = self.query_local(e1=entity,rel='subtype')
        ldecl_member = self.query_local(e1=entity,rel='member')
        return ldecl_member + ldecl_subtype + self.query(entity) if relation == None else list(i for i in ldecl_member + ldecl_subtype + self.query(entity) if i.relation.name == relation)

## ex12
    def query_cancel(self,entity,association):
        ldecl = self.query_local(e1=entity)
        lassoc = [i for i in ldecl if isinstance(i.relation,Association) and i.relation.name == association]
        for i in lassoc:
            if i.relation.name == association:
                return lassoc
        lparent = [i.relation.entity2 for i in ldecl if not isinstance(i.relation,Association)]
        for i in lparent:
            lassoc += [j for j in self.query_cancel(i,association) if j not in lassoc]
        return lassoc

## ex13
    def query_down(self,type, association):
        descendents = [i.relation.entity1 for i in self.query_local(e2=type)]
        decl_list = list()
        for i in descendents:
            decl_list += [j for j in self.query_local(e1=i) if j.relation.name == association] + self.query_down(i,association)
        return decl_list

## ex14
    def query_induce(self,type,association):
        dict_count = dict()
        for i in self.query_down(type,association):
            if i.relation.entity2 in dict_count.keys():
                dict_count[i.relation.entity2] += 1
            else:
                dict_count[i.relation.entity2] = 1
        for i in dict_count.keys():
            if dict_count[i] == max(dict_count.values()):
                return i

## ex15     ## estava a dar problemas, não vi sequer
    # def query_local_assoc(self,entity,assoc):
    #     ldecl = [i for i in self.query_local(e1=entity,e2=assoc) if isinstance(i.relation,Association) or isinstance(i.relation,AssocNum) or isinstance(i.relation,AssocOne)]
    #     for i in ldecl:
    #         if isinstance(i.relation,AssocNum):
    #             return sum([i.relation.entity2 for i in ldecl])/len(ldecl)
    #         elif isinstance(i.relation,AssocOne):
    #             most_frequent = self.query_induce(entity,assoc)
    #             if i.relation.entity2 == most_frequent:
    #                 most_frequent_count += 1 
    #             return (most_frequent,most_frequent_count/len(ldecl))
        
## falta o 16