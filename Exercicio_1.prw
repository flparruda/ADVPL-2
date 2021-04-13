//Exercicio 1 13/04/2021
#include "protheus.ch"

user function splobj06()

PRIVATE oDlg,  oFont1,oFont2,oFont3,oFont4
Private cVar1 := space(20)
Private nVar2 := 0
Private cVar3 := SPACE(20)
Private dvar4 := stod("")
Private lSair := .F.
Private bContro01 := {|| lSair := .T.}
Private bContro02 := {|| lSair := .f.}
Private MinhaCor := rgb(255,147,0)

DEFINE FONT oFont1 Name "Courier New"     SIZE 0,20 BOLD  
DEFINE FONT oFont2 Name "Arial"           SIZE 0,20 BOLD  
DEFINE FONT oFont3 Name "Lucinda Console" SIZE 0,20 BOLD  
DEFINE FONT oFont4 Name "Book Antiqua"    SIZE 0,20 BOLD  

SET EPOCH TO 1950  // data a partir de 1950
SET DATE BRITISH   // data formato britanico EUA-MM/DD/AAAA    BRITISH DD/MM/AAAA
SET CENTURY ON     //ON  ano com 4 digitos, OFF 2 DIGITOS PARA O ANO

DEFINE MSDIALOG oDlg FROM 0,0 TO 300,400  TITLE "Exercicio Picture" PIXEL

@ 010,010 SAY "Nome"     SIZE 100,30 FONT oFont1 COLOR MinhaCor  PIXEL of ODlg  
@ 035,010 SAY "Salario"  SIZE 100,30 FONT oFont2 COLOR CLR_RED   PIXEL of ODlg  
@ 060,010 SAY "Telefone" SIZE 100,30 FONT oFont3 COLOR CLR_GREEN PIXEL of ODlg  
@ 085,010 SAY "Dt Nasc"  SIZE 100,30 FONT oFont4 COLOR CLR_HRED  PIXEL of ODlg  
                  
@ 010,070 MSGET oGet1 Var cVar1 SIZE 120,15 ;
                            FONT oFont1 COLOR CLR_BLUE  PIXEL of ODlg 

@ 035,070 MSGET oGet2 Var nVar2 SIZE 120,15 ;
                       picture "@e 999,999.99" FONT oFont2 COLOR CLR_RED   PIXEL of ODlg 
                       
@ 060,070 MSGET oGet3 Var cVar3 SIZE 120,15 ;
            PICTURE "@R (999) 9999-9999 R 9999" FONT oFont3 COLOR CLR_GREEN PIXEL of ODlg 
             
@ 085,070 MSGET oGet4 Var dVar4 SIZE 120,15 ;
                   FONT oFont4 COLOR CLR_HRED PIXEL of ODlg  

oGet1:bLostFocus := bContro01
oGet2:bLostFocus := bContro02

ACTIVATE MSDIALOG oDlg CENTERED VALID lSair




return

