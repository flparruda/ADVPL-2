//Exercicio 2
#include 'protheus.ch'
User function Exec2()
	PRIVATE lCheck1 := .T.
	PRIVATE lCheck2 := .F.
	PRIVATE lCheck3 := .F.
	PRIVATE lCheck4 := .F.

	DEFINE MSDIALOG oDlg FROM 0,0 TO 270,400 PIXEL TITLE 'Exemplo da TCheckBox'
//Usando forma nativa da linguagem
	oCheck1 := TCheckBox():New(01,01,'CheckBox 001',,oDlg,100,210,,,,,,,,.T.,,,)
	oCheck2 := TCheckBox():New(11,01,'CheckBox 002',,oDlg,100,210,,,,,,,,.T.,,,)
//Usando forma equivalente
	@21,01 CheckBox oCheck4 Var lCheck3 Prompt 'CheckBox 003' Size 100,210 Pixel Of oDlg
	@31,01 CheckBox oCheck5 Var lCheck4 Prompt 'CheckBox 004' Size 100,210 Pixel Of oDlg
// Configuracao blocos codiso - seta Eventos do primeiro Check
	oCheck1:bSetGet := {|| lCheck1 } // 1
	oCheck1:bLClicked := {|| lCheck1:=!lCheck1 } // 2
	oCheck1:bWhen := {|| .T. } // 3
	oCheck1:bValid := {|| .T. } // 4
// Configuracao blocos codiso - seta Eventos do segundo Check
	oCheck2:bSetGet := {|| lCheck2 } // 1
	oCheck2:bLClicked := {|| lCheck2:=!lCheck2 } // 2
	oCheck2:bWhen := {|| .T. } // 3
	oCheck2:bValid := {|| .T. } // 4
// 1 Variável que sera alterado pelo objeto
// 2 No click altera (inverte) o conteudo da variavel informada
// 3 Se .T. habilita o item do objeto checkbox
// 4 Se bloco de codigo retornar .T. permite alteracao do item do objeto
	@ 50,10 BUTTON oFECHAR PROMPT "&Fechar" ;
		SIZE 30,15 ;
		PIXEL ;
		ACTION (MOSTRA(), ODLG:END()) ;
		OF ODLG
	ACTIVATE MSDIALOG oDlg CENTERED
Return
STATIC FUNCTION MOSTRA()
	LOCAL cRESULT := ""
	IF lCheck1 = .T.
		cRESULT += "Check 1 - clicado"+CRLF
	ENDIF
	IF lCheck2 = .T.
		cRESULT += "Check 2 - clicado"+CRLF
	ENDIF
	IF lCheck3 = .T.
		cRESULT += "Check 3 - clicado"+CRLF
	ENDIF
	IF lCheck4 = .T.
		cRESULT += "Check 4 - clicado"+CRLF
	ENDIF
	MSGINFO(cRESULT)
RETURN
