from random import random, randint

def f(x):
    if x==[]:
        return 0
    if x[0]>0:
        return x[0] + f(x[1:])
    return f(x[1:])

def g(x):
    if x==[]:
        return [[]]
    y = g(x[1:])
    print(f"x = {x}")
    print(f"y = {y}")
    print(f"+ .. = {[ [x[0]]+z for z in y ]}")
    return y + [ [x[0]]+z for z in y ]

# def randomListGen(size):
#     lst = []
#     for i in range(0, size):
#         signal = random() < 0.5
#         if signal:  value = -int(random()*7.5)
#         else:       value = int(random()*7.5)
#         lst.append(value)
#     return lst

def randomListGen2(size):
    return [randint(-7, 7) for _ in range(size)]

if __name__ == "__main__":
    size = 3
    ind = []
    lista = randomListGen2(size)
    ind = list(range(0,size))
    # print da lista e os seus indices
    print("Indices:   ", " ".join(f"{i:2}" for i in ind))
    print("List:     [", " ".join(f"{v:2}" for v in lista)," ]")

## 1.
    print(f"\nf(lista) = {f(lista)}")
    sum = 0
    for value in lista:
        if value > 0:
            sum += value
    print(f"Soma dos positivos da lista = {sum}")
    # (como era obvio, sim,  a função f(x) soma todos os positivos de uma lista)

## 2.
    print(f"\ng(lista) = {g(lista)}")