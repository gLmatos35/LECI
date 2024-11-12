# prioritarios: 4.1-4.9, 5.2 a.
import math

#Exercicio 4.1
impar = lambda x: x%2 != 0

#Exercicio 4.2
positivo = lambda x: x > 0

#Exercicio 4.3
comparar_modulo = lambda x, y: abs(x) < abs(y)

#Exercicio 4.4
cart2pol = lambda x, y: (math.sqrt(x**2 + y**2), math.atan2(y, x))

#Exercicio 4.5
ex5 = lambda f, g, h: lambda x, y, z: h(f(x, y), g(y, z))

#Exercicio 4.6
def quantificador_universal(lista, f):
    if not lista: return True
    return f(lista[0]) and quantificador_universal(lista[1:], f)
# or:
    # return all(f(x) for x in lista)

#Exercicio 4.8
def subconjunto(lista1, lista2):
    return all(x in lista2 for x in lista1)

#Exercicio 4.9
def menor_ordem(lista, f):
    menor = lista[0]
    for x in lista[1:]:
        if f(x,menor): menor = x
    return menor
        
#Exercicio 4.10
def menor_e_resto_ordem(lista, f):
    newList = lista[:]
    menor = lista[0]
    for x in lista[1:]:
        if f(x,menor):
            menor = x
    newList.pop(newList.index(menor))
    return (menor, newList)
    
#Exercicio 5.2
def ordenar_seleccao(lista, ordem):
    # newList = lista[:]
    # if not lista: return []
    # menor = lista[0]
    # for x in lista[1:]:
    #     if ordem(x,menor):
    #         menor = x
    # newList.pop(newList.index(menor))
    # return [menor] + ordenar_seleccao(newList, ordem)

# alternativamente (e melhor, sem recursão):
    newList = lista[:]
    for i in range(len(newList)):
        menorIndex = i
        for j in range(i + 1, len(newList)):
            if ordem(newList[j], newList[menorIndex]):
                menorIndex = j
# troca os elementos de lugar
        newList[i], newList[menorIndex] = newList[menorIndex], newList[i]
    return newList