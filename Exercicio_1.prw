//Exercicio 1 13/04/2021

#include "protheus.ch"

user function exec1()

	SET EPOCH TO 1950  // data a partir de 1950
	SET DATE BRITISH   // data formato britanico
	SET CENTURY ON     // ano com 4 digitos

	Private oDlg
	Private cNome :='Felipe Henrique Arruda'
	Private nSal := 5000.50
	Private nTel := 11961325781
	Private nNasc := 26041987
	Private oFont
	DEFINE FONT oFont Name "Arial" SIZE 12,-14 BOLD
	Define MSDialog oDlg Title "Novo Formulario" From 0,0 To 360,380 Pixel


	@15,20 Say "Nome:" FONT oFont COLOR CLR_RED Pixel Of oDlg
	@15,80 MSGet oVar Var cNome  Size 90,10  Pixel  Of oDlg

	@35,20 Say "Salario:" FONT oFont COLOR CLR_BLUE Pixel Of oDlg
	@35,80 MSGet oVar Var nSal Picture "@E 999,999.99" Size 50,10 Pixel  Of oDlg

	@55,20 Say "Telefone:" FONT oFont COLOR CLR_GREEN Pixel Of oDlg
	@55,80 MSGet oVar Var nTel Picture "@E (99) 99999-9999" Size 50,10 Pixel  Of oDlg

	@75,20 Say "Dt. Nasc:" FONT oFont COLOR CLR_RED Pixel Of oDlg
	@75,80 MSGet oVar Var nNasc Picture "@E 99/99/9999" Size 50,10 Pixel  Of oDlg

	@90,20 Button oBtnOk     Prompt "&Ok"       Size 30,15 Pixel ;
		Action (msginfo("OK"), Close(oDlg)) Of oDlg

	@90,80 Button oBtnCancel Prompt "&Cancelar" Size 30,15 Pixel ;
		Action (msginfo("Sair"), oDlg:End()) Cancel Of oDlg

	Activate MSDialog oDlg Centered

return

Static Function Close
	oDlg:End()
Return
