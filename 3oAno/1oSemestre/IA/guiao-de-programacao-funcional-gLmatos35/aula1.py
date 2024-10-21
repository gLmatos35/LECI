#Exercicio 1.1
def comprimento(lista):
    newList = lista[:]
    if len(newList) == 0:
        return 0
    else:
        return 1 + comprimento(newList[1:])
    
#Exercicio 1.2
def soma(lista):
    newList = lista[:]
    if len(newList) == 0:
        return 0
    elem = newList[0]
    newList.pop(0)
    return elem + soma(newList)
    
#Exercicio 1.3
def existe(lista, elem):
    newList = lista[:]
    if len(newList) == 0:
        return False
    if elem == newList[0]:
        return True
    else:
        return existe(newList[1:],elem)

#Exercicio 1.4    
def concat(l1, l2):
    newList = l1[:]
    if len(l2) == 0:
        return newList
    newList.append(l2[0])
    return concat(newList, l2[1:])

#Exercicio 1.5   
def inverte(lista):
    newList = lista[:]
    if len(newList) == 0: return newList
    return [newList[-1]] + inverte(newList[:-1])     

#Exercicio 1.6    
# def capicua(lista):
    # return inverte(lista) == lista

def capicua(lista):
    newList = lista[:]
    if len(newList) <= 1: return True
    return newList[0] == newList[-1] and capicua(newList[1:-1])

#Exercicio 1.7
def concat_listas(lista):
    newList = lista[0]
    if len(lista) <= 1: return newList
    if len(lista) == 2: return concat(newList,lista[1])
    return concat(newList,lista[1]) + concat_listas(lista[2:])
## pedir para ver do rafa visto que apaguei a minha outra soluçao e esta parece mais scuffed do que devia ser
     
#Exercicio 1.8
def substitui(lista, original, novo):
    newList = lista[:]
    if not(existe(newList,original)): return newList
    if newList[0] == original:
        return [novo] + substitui(newList[1:], original, novo)
    else: return [newList[0]] + substitui(newList[1:], original, novo)

#Exercicio 1.9
def fusao_ordenada(lista1, lista2):
    if not lista1:
        return lista2
    if not lista2:
        return lista1
    return ([lista1[0]] + fusao_ordenada(lista1[1:], lista2) 
        if lista1[0] < lista2[0] 
        else [lista2[0]] + fusao_ordenada(lista1, lista2[1:]))

    
#Exercicio 1.10
def lista_subconjuntos(lista):
	pass
    ## how?


#Exercicio 2.1
def separar(lista):
    newList = lista[:]
    if not lista: return ([],[])
    first, second = separar(lista[1:])
    return ([lista[0][0]] + first, [lista[0][1]] + second)

#Exercicio 2.2
def remove_e_conta(lista, elem):
    newList = lista[:]
    if not newList: return ([],0)
    novaLista, ocorrencias = remove_e_conta(lista[1:], elem)
    if newList[0] == elem:
        return (novaLista, ocorrencias + 1)
    else:
        return ([newList[0]] + novaLista, ocorrencias)

# #Exercicio 2.3
# def num_ocorrencias(lista):
#     newList = lista[:]
#     # if len(newList) == 1:    
#     elem, contagem = newList[1:]
#     # rip    

#Exercicio 3.1
def cabeca(lista):
    newList = lista[:]
    if len(newList) == 0: return None
    else: return newList[0]

#Exercicio 3.2
def cauda(lista):
    newList = lista[:]
    if len(newList) == 0: return None
    else: return newList[1:]

#Exercicio 3.3
def juntar(l1, l2):
    newList1 = l1[:]
    newList2 = l2[:]
    if len(newList1) != len(newList2): return None
    if len(newList1) == 0: return []
    return [(newList1[0],newList2[0])] + juntar(newList1[1:],newList2[1:])    

#Exercicio 3.4
def menor(lista):
    newList = lista[:]
    if not newList: return None
    if len(newList) == 1: return newList[0] 
    else:
        temp = menor(lista[1:])
        return newList[0] if newList[0] < temp else temp

#Exercicio 3.5
# def min_restantes(lista):
#     newList = lista[:]
#     if not newList: return None
#     if len(newList) == 1: return (newList[0],[])
#     temp, novaLista = max_min(lista[1:])
#     menor = newList[0] if newList[0] < temp else temp
#     listaRestantes = [newList[0]] + novaLista if newList[0] != menor else novaLista
#     return (menor,listaRestantes)
#  corrigido em testes.py

#Exercicio 3.6
def max_min(lista):
    newList = lista[:]
    if not newList: return None
    if len(newList) == 1: return (newList[0], newList[0])
    maior, menor = max_min(newList[1:])
    
    maior = newList[0] if newList[0] > maior else maior
    menor = newList[0] if newList[0] < menor else menor
    
    return (maior, menor)