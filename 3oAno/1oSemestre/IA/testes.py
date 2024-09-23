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

lst = [1,2,4,4]
lst2 = [5,6]
lst3 = [1,2,3,2,1]
# 1.1
# print(comprimento(lst))
# 1.2
# print(soma(lst))
# 1.3
# print(existe(lst,3))
# 1.4
# print(concat(lst2,lst2))
# 1.5
print(inverte(lst))
print(capicua(lst3))