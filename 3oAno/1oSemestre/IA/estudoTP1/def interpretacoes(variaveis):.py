def interpretacoes(variaveis):
    resultado = [[]]
    
    for variavel in variaveis:
        novas_combinacoes = []
        for interpretacao in resultado:
            novas_combinacoes.append(interpretacao + [(variavel, True)])
            novas_combinacoes.append(interpretacao + [(variavel, False)])
        resultado = novas_combinacoes
    
    return resultado

# Exemplo de uso
resultado = interpretacoes(["a", "b"])
print(resultado)
