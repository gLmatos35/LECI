# Aula 1
#Exercicio 1.1
import functools


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
    
def existe(lista, elem):
    newList = lista[:]
    if len(newList) == 0:
        return False
    if elem == newList[0]:
        return True
    else:
        return existe(newList[1:],elem)
    
def concat(l1, l2):
    newList = l1[:]
    if len(l2) == 0:
        return newList
    newList.append(l2[0])
    return concat(newList, l2[1:])
    
def inverte(lista):
    newList = lista[:]
    if len(newList) == 0: return newList
    return [newList[-1]] + inverte(newList[:-1])     
    
# def capicua(lista):
    # return inverte(lista) == lista

def capicua(lista):
    newList = lista[:]
    if len(newList) <= 1: return True
    if newList[0] == newList[-1]:
        newList.pop(0)
        newList.pop(-1)
    return capicua(newList)

# def min_restantes(lista):
#     newList = lista[:]
#     if not newList: return None
#     if len(newList) == 1: return (newList[0],[])
#     temp, novaLista = max_min(lista[1:])
#     menor = newList[0] if newList[0] < temp else temp
#     listaRestantes = novaLista if lista[0] == menor else [lista[0]] + novaLista
#     return (menor,listaRestantes)

# def min_restantes(lista):
#     if not lista:
#         return None
#     if len(lista) == 1:
#         return (lista[0], [])
    
#     # Recursão para obter o menor e a lista dos restantes
#     menor, novaLista = min_restantes(lista[1:])
    
#     # Verifica se o primeiro elemento é menor do que o menor da sublista
#     if lista[0] < menor:
#         return (lista[0], lista[1:])  # lista[1:] inclui todos os elementos exceto o menor
#     else:
#         return (menor, [lista[0]] + novaLista)  # Mantém lista[0] na lista dos restantes

def min_restantes(lista):
    newList = lista[:]
    if not newList: return None
    if len(newList) == 1: return (newList[0],[])
    # ...
    # versao acima está corrigida mas sadly pelo gpt, fazer novamente

lst = [1,2,4,4]
lst2 = [5,6]
lst3 = [1,2,3,2,1]
lst4 = [4,3,2,6,1,8]
# 1.1
# print(comprimento(lst))
# 1.2
# print(soma(lst))
# 1.3
# print(existe(lst,3))
# 1.4
# print(concat(lst2,lst2))
# 1.5
# print(inverte(lst))
# print(capicua(lst3))
# 3.5
print(min_restantes(lst4))

print(functools.reduce(lambda r,h:1+r, [1,2,3,4,5],0))
    
    