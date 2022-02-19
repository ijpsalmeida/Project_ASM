    ;Bibliotecas necessarias para ter varias funcoes
    
    ORG 100H
    include emu8086.inc 
    
    DEFINE_CLEAR_SCREEN 
    
    DEFINE_SCAN_NUM 
    
    DEFINE_PRINT_NUM 
    DEFINE_PRINT_NUM_UNS
       
;-----------------------------------------    Entrada    ----------------------------------------------------
    
    ;Serve para fazer o print da entrada no ecra 
    
    
    MOV AH, 9
    LEA DX, texto1
    INT 21h 
    
    MOV AH, 9
    LEA DX, texto2
    INT 21h 
    
    MOV AH, 9
    LEA DX, texto3
    INT 21h 
    
    MOV AH, 9
    LEA DX, texto4
    INT 21h 
    
    MOV AH, 9
    LEA DX, texto5
    INT 21h 
    
    MOV AH, 9
    LEA DX, texto6
    INT 21h 
    
    MOV AH, 9
    LEA DX, texto7
    INT 21h       
    
    JMP f1  ;Da o jump para a funcao principal
    
    texto1 db '---------------------------------------------------------------------------', 13,10,'$'
    texto2 db '|                                                                         |', 13,10,'$'
    texto3 db '|                                                                         |', 13,10,'$'
    texto4 db '|                              KIOSK ONLINE                               |', 13,10,'$'
    texto5 db '|                                                                         |', 13,10,'$'
    texto6 db '|                                                                         |', 13,10,'$'
    texto7 db '---------------------------------------------------------------------------', 13,10,'$'   
 
 
 
 
 
;------------------------------------------    Inicio    ----------------------------------------------------   
    ;Declarar variaveis para ser mais facil fazer futuras alteracoes em precos lugares ...
    
    
    ;Definir preco de bilhetes 
    
    pvip equ 25
    pvarandaprincipal equ 30
    pvarandaslaterais equ 20
    pdeficientes equ 10
    plugaresgerais equ 15
    
    ;Quantidade de lugares
    
    lvip equ 20
    lvarandaprincipal equ 15
    lvaranda equ 40
    ldeficientes equ 15
    llugaresgerais equ 350  
    
    ;Apenas servem para que os lugares sejam atualizados 
    l_vip dw lvip
    l_varandaprincipal dw lvarandaprincipal
    l_deficientes dw ldeficientes
    l_varandalateral dw lvaranda 
    l_lugaresgerais dw llugaresgerais
    
;----------------------------------------    Menu de cliente    ---------------------------------------------
    
    f1: 
 
    GOTOXY 2,10  ;Escolher o lugar no ecra para realizar a seguinte funcao
    PRINT 'Deseja adquirir bilhetes?'  ;Escreve no ecra
    
    JMP opcao
    
    
    cliente: db '           ',13,10 
             db '           ',13,10
             db '1-Sim', 13,10 
             db '2-Nao', 13,10,'$'
    
    opcao:
    MOV AH,9
    LEA DX, cliente
    INT 21H  
    
    MOV AH,7     ;Pede ao utilizador um numero e gurada em al
    INT 21H  
                                                  
    CMP AL,'1'   ;Compara o numero guardado a 1
    JE SIM       ;Caso seja igual salta para o sim
    
    CMP AL, '2'  ;Caso igual ao de cima
    JE SAIR
    
;---------------------------------------    CASO TENHA CLIENTE    -----------------------------------------------       

    SIM: 
         
    CALL CLEAR_SCREEN     ;Apaga o que esta escrito ateriormente no ecra
    
    GOTOXY 8,1
    PRINT 'Tipos de bilhetes disponiveis'
    
    GOTOXY 2,3
    PRINT '1. Lugares gerais- 15eur./un.'   
    MOV AX,l_lugaresgerais    ;Copia valor para ax
    GOTOXY 43,3 
    PRINT 'Disponiveis ' 
    GOTOXY 56,3
    CALL PRINT_NUM            ;Funcao de escrever um numero no ecra
      
    GOTOXY 2,5
    PRINT '2. Varandas laterais- 20eur./un.' 
    MOV AX,l_varandalateral
    GOTOXY 43,5
    PRINT 'Disponiveis ' 
    GOTOXY 56,5
    CALL PRINT_NUM
    
    GOTOXY 2,7
    PRINT '3. Vip - 25eur./un.' 
    MOV AX,l_vip
    GOTOXY 43,7 
    PRINT 'Disponiveis ' 
    GOTOXY 56,7
    CALL PRINT_NUM   
    
    GOTOXY 2,9
    PRINT '4. Varanda principal- 30eur./un.'  
    MOV AX,l_varandaprincipal
    GOTOXY 43,9 
    PRINT 'Disponiveis ' 
    GOTOXY 56,9
    CALL PRINT_NUM
    
    GOTOXY 2,11
    PRINT '5. Necessidades especiais - 10eur./un.' 
    MOV AX,l_deficientes
    GOTOXY 43,11 
    PRINT 'Disponiveis ' 
    GOTOXY 56,11
    CALL PRINT_NUM
    
    GOTOXY 2,17
    PRINT 'Por favor, selecione a categoria que deseja! ' 
    
    MOV AH,7
    INT 21H
    
    CMP AL,'1'
    JE LUGARESGERAIS
    
    CMP AL,'2'
    JE VARANDASLATERAIS
    
    CMP AL,'3'
    JE VIP
    
    CMP AL,'4'
    JE VARANDAPRINCIPAL
    
    CMP AL,'5'
    JE DEFICIENTES 
    
;--------------------------------------------------------------------------------------------------------------    
    ;Parte do programa caso nao haja disponivel os bilhetes que o utilizadr deseja
    
    
    SIM2: 
        
    CALL CLEAR_SCREEN     
 
    GOTOXY 8,1
    PRINT 'Quantidade de bilhetes indisponivel, escolha outra opcao!'
    
    GOTOXY 2,3
    PRINT '1. Lugares gerais- 15eur./un.'   
    MOV AX,l_lugaresgerais
    GOTOXY 43,3 
    PRINT 'Disponiveis ' 
    GOTOXY 56,3
    CALL PRINT_NUM
      
    GOTOXY 2,5
    PRINT '2. Varandas laterais- 20eur./un.' 
    MOV AX,l_varandalateral
    GOTOXY 43,5
    PRINT 'Disponiveis ' 
    GOTOXY 56,5
    CALL PRINT_NUM
    
    GOTOXY 2,7
    PRINT '3. Vip - 25eur./un.' 
    MOV AX,l_vip
    GOTOXY 43,7 
    PRINT 'Disponiveis ' 
    GOTOXY 56,7
    CALL PRINT_NUM   
    
    GOTOXY 2,9
    PRINT '4. Varanda principal- 30eur./un.'  
    MOV AX,l_varandaprincipal
    GOTOXY 43,9 
    PRINT 'Disponiveis ' 
    GOTOXY 56,9
    CALL PRINT_NUM
    
    GOTOXY 2,11
    PRINT '5. Necessidades especiais - 10eur./un.' 
    MOV AX,l_deficientes
    GOTOXY 43,11 
    PRINT 'Disponiveis ' 
    GOTOXY 56,11
    CALL PRINT_NUM
    
    GOTOXY 2,17
    PRINT 'Por favor, selecione a categoria que deseja! ' 
    
    MOV AH,7
    INT 21H
    
    CMP AL,'1'
    JE LUGARESGERAIS
    
    CMP AL,'2'
    JE VARANDASLATERAIS
    
    CMP AL,'3'
    JE VIP
    
    CMP AL,'4'
    JE VARANDAPRINCIPAL
    
    CMP AL,'5'
    JE DEFICIENTES
    
;-------------------------------------    LUGARES GERAIS    ---------------------------------------------------


    LUGARESGERAIS: 
    
    CALL CLEAR_SCREEN   ;Apagar ecra
    
    GOTOXY 3,2  
    
    PRINT 'Quantos bilhetes deseja?'
    
    GOTOXY 30,2
    
    CALL SCAN_NUM       ;Le numero introduzido e guarda numero em cx
    
    CMP l_lugaresgerais, CX    ;Compara com a variavel defenida em cima
    
    JB SIM2                    ;Se for menor salta para a parte do programa em que nao ha os bilhetes disponiveis
    
    SUB l_lugaresgerais, CX    ;Subtrai os bilhetes que o utilizador que aos totais para atualizar valor
    
    CALL CLEAR_SCREEN
    
    MOV AX, CX           ;Passar o valor de cx para ax
    MOV BL,plugaresgerais
    MUL BL               ;Introduzir a variavel que ira multiplicar pelo ax (ja prefedenido)
    
    GOTOXY 2,2
    PRINT 'O preco a pagar pelos seus bilhetes e '  
    
    GOTOXY 40,2
    CALL PRINT_NUM 
    
    GOTOXY 45,2
    PRINT 'EUR.'
    
    JE PAGAMENTO        ;Salta para o pagamento
    
    
;-----------------------------------    VARANDAS LATERAIS    ---------------------------------------------------
  

    VARANDASLATERAIS:  
    
    CALL CLEAR_SCREEN 
    
    GOTOXY 3,2  
    
    PRINT 'Quantos bilhetes deseja?' 
    
    GOTOXY 30,2
    
    CALL SCAN_NUM 
    
    CMP l_varandalateral, CX
    
    JB SIM2
    
    SUB l_varandalateral, CX
    
    CALL CLEAR_SCREEN
    
    MOV AX, CX   
    MOV BL,pvarandaslaterais
    MUL BL       
    
    GOTOXY 2,2
    PRINT 'O preco a pagar pelos seus bilhetes e '   
    
    GOTOXY 40,2
    CALL PRINT_NUM 
    
    GOTOXY 45,2
    PRINT 'EUR.'

    JE PAGAMENTO
    
    
;-----------------------------------------    VIP    ---------------------------------------------------------   

    VIP:  
    
    CALL CLEAR_SCREEN
    
    GOTOXY 3,2  
    
    PRINT 'Quantos bilhetes deseja?' 
    
    GOTOXY 30,2
    
    CALL SCAN_NUM   
    
    CMP l_vip, CX
    
    JB SIM2
    
    SUB l_vip, CX
    
    CALL CLEAR_SCREEN
    
    MOV AX, CX
    MOV BL,pvip
    MUL BL
    
    GOTOXY 2,2
    PRINT 'O preco a pagar pelos seus bilhetes e '   
    
    GOTOXY 40,2
    CALL PRINT_NUM 
    
    GOTOXY 45,2
    PRINT 'EUR.'

    JE PAGAMENTO
    
    
;---------------------------------------    VARANDA PRINCIPAL    ---------------------------------------------------------   

    VARANDAPRINCIPAL:  
    
    CALL CLEAR_SCREEN
    
    GOTOXY 3,2  
    
    PRINT 'Quantos bilhetes deseja?' 
    
    GOTOXY 30,2
    
    CALL SCAN_NUM  
    
    CMP l_varandaprincipal, CX
    
    JB SIM2
    
    SUB l_varandaprincipal, CX
    
    CALL CLEAR_SCREEN
    
    MOV AX, CX
    MOV BL,pvarandaprincipal
    MUL BL
    
    GOTOXY 2,2
    PRINT 'O preco a pagar pelos seus bilhetes e ' 
    
    GOTOXY 40,2
    CALL PRINT_NUM 
    
    GOTOXY 45,2
    PRINT 'EUR.'

    JE PAGAMENTO
     

;-----------------------------------------    DEFICIENTES    ---------------------------------------------------------   

    DEFICIENTES:  
    
    CALL CLEAR_SCREEN
    
    GOTOXY 3,2  
    
    PRINT 'Quantos bilhetes deseja?' 
    
    GOTOXY 30,2
    
    CALL SCAN_NUM  
    
    CMP l_deficientes, CX
    
    JB SIM2
    
    SUB l_deficientes, CX
    
    CALL CLEAR_SCREEN
    
    MOV AX, CX
    MOV BL,pdeficientes
    MUL BL
    
    GOTOXY 2,2
    PRINT 'O preco a pagar pelos seus bilhetes e ' 
    
    GOTOXY 40,2
    CALL PRINT_NUM 
    
    GOTOXY 45,2
    PRINT 'EUR.'
    
    JE PAGAMENTO
 
;------------------------------------------    PAGAMENTO    ---------------------------------------------------
    
    PAGAMENTO:
    
    GOTOXY 2,5  
    PRINT 'Insira o cartao para efetuar o pagamento'
    
    GOTOXY 20,10
    PRINT 'Introduza o codigo'
    
    GOTOXY 20,12
    CALL SCAN_NUM
    
    JE f2

;--------------------------------------    COMPRA BEM SUCEDIDA    --------------------------------------------
    
     
    f2:
   
    CALL CLEAR_SCREEN 
    
    GOTOXY 15, 4
    PRINT 'Codigo aceite, compra bem sucedida!' 
    
    GOTOXY 15, 6
    PRINT 'Boa sessao!'
    
    GOTOXY 15,10
    PRINT 'Deseja comprar mais bilhetes?'
    
    GOTOXY 15,12
    PRINT '1-Sim'
    
    GOTOXY 15,13
    PRINT '2-Nao'   
    
    MOV AH,7
    INT 21H
    
    CMP AL, '1'
    JE  SIM
    
    CMP AL,'2'
    JE  SAIR
    
    
;--------------------------------   CASO NAO QUEIRA COMPRAR BILHETES    --------------------------------------     

    SAIR:
    
    CALL CLEAR_SCREEN
    
    GOTOXY 15,5  
    PRINT 'Obrigado pela sua visita!'
    
    GOTOXY 15,10
    PRINT 'Powered by Ivo Soares Almeida'
    
    END