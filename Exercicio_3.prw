//Exercicio 3

#Include "PROTHEUS.CH"

User Function Exec3()
	Local oBtn
	Local oSay1
	Private oGet1
	Private cGet1 := "Define variable value"
	Private oDlg

	DEFINE MSDIALOG oDlg TITLE "Selecao Arquivo" FROM 0,0 TO 100, 600 PIXEL

	@ 018, 005 SAY oSay1 PROMPT "Arquivo" SIZE 025, 007 OF oDlg  PIXEL
	@ 018, 025 MSGET oGet1 VAR cGet1 SIZE 192, 010 OF oDlg  READONLY PIXEL
	@ 018, 225 BUTTON oBtn PROMPT "Selecionar" ;
		SIZE 064, 012 OF oDlg PIXEL ;
		ACTION MYSEL()
	ACTIVATE MSDIALOG oDlg CENTERED
RETURN
//******************************************************************
STATIC function MYSEL()
	cMasc := "word|*.docx|excel|*.xlsx|pdf|*.pdf|todos|*.*"
	cTit  := "Selecionar"
	nBit  := 16+32
	cGet1 := cGetfile(cMasc,cTit,1,"",.f.,nBit)
RETURN







