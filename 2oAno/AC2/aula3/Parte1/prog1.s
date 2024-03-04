# Rex	...	Re5	Re4	Re3	Re2	Re1	Re0	\ and
#  1		 1	 1	 0       1 	 1	 0	/

# a nossa placa tem portos de B a F, cada um com registos TRIS, LAT e PORT
# TRIS  - definir se é input ou output
# LAT   - escrever no porto nos bits pretendidos (após definido como porto de saída)
# PORT  - ler o valor de um porto configurado como entrada

# ler, modificar, escrever      - ordem de sequência :)

# ex, Re0 como entrada
# usar TRISE
# Re31 .. Re1 => inalterados!
# 
# [TRISE address is 0xBF886100]
#
# lui $t0,0xBF88        - endereço base - isto está nos equ's btw
# lw $t1,TRISE($t0)     - ler a word guardada nesse endereço atraves o offset - 6100 no caso do TRISE
# ori $t1,$t1,0x0001    - força apenas o Re0 para 1, mantendo os outros
# sw $t1,TRISE($t0)     - guardar alteração feita

# memo:
# • TRIS  é  relativo  a  tri-state  ('0'  =>  tri-state  off,  i.e.,  o  porto  não  está  no  estado  de  alta 
# impedância, ou seja, é um porto de saída; '1' => tri-state on , i.e., o porto está no estado de 
# alta impedância, ou seja, é uma entrada);  
# • PORT diz respeito ao valor do porto de entrada;  
# • LAT refere-se a latch, i.e., ao registo que armazena o valor a enviar para o porto de saída.


# Re0 como saida e Rb0 como entrada
# em ciclo infinito, ler Rb0 e escrever em Re0

# alterar de modo a escrever agora o valor negado
# repetir usando como entrada Rd8

        .equ BASE_ADDR,0xBF88
        .equ TRISB,6040
        .equ PORTB,6050
        .equ LATB,6060
        .equ TRISE,6100
        .equ PORTE,6110
        .equ LATE,6120

        .data

        .text
        .globl main
main:   lui $t0,BASE_ADDR
        lw $t1,TRISB($t0)       # ler e guardar
        ori $t1,$t1,0x0001      # forçar Rb0 a '1'      - configurar como entrada
        sw $t1,TRISB($t0)       # salvar alteração

        # lui $t0,BASE_ADDR
        lw $t1,TRISE($t0)
        andi $t1,$t1,0xFFFE     # saída
        sw $t1,TRISE($t0)

# loop:   lw $t1,PORTB($t0)
#         lw $t2,LATE($t0)
#         andi $t1,$t1,0x0001
#         andi $t2,$t2,0xFFFE
#         or $t1,$t1,$t2
#         sw $t1,LATE($t0)
#         j loop
#         jr $ra        

loop:   lw $t1,PORTB($t0)
        andi $t1,$t1,0x0001     # guardar apenas Rb0

        lw $t2,LATE($t0)
        andi $t2,$t2,0xFFFE     # 
        or $t1,$t1,$t2
        sw $t1,LATE($t0)

        j loop
        jr $ra