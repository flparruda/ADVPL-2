//Exercicio 4

#INCLUDE "protheus.ch"
USER FUNCTION Exec4()
PRIVATE oDLG
PRIVATE oRADIO
PRIVATE aRADIO := {}
PRIVATE nRADIO := 0
AADD(aRADIO,"ITEM 1")
AADD(aRADIO,"ITEM 2")
AADD(aRADIO,"ITEM 3")
DEFINE MSDIALOG oDlg TITLE "Exemplo usando tRADIO" ;
 FROM 200,380 TO 430,700 PIXEL
@ 005, 010 RADIO oRADIO ;
 VAR nRADIO ;
 ITEMS aRADIO[1],aRADIO[2],aRADIO[3] ;
 SIZE 70,10 ;
 PIXEL ;
 OF oDLG
@ 070,010 BUTTON "Fechar" SIZE 050,015 PIXEL OF oDLG ;
 ACTION ( MSGINFO("Item selecionado "+CVALTOCHAR(nRADIO)), oDLG:END() )

ACTIVATE MSDIALOG oDlg VALID .T. CENTERED
RETURN 
