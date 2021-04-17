//Exercicio 7
#include "protheus.ch"
#Include "FwMvcDef.ch"
#Include "totvs.ch"

USER FUNCTION Exec7()

	Private oBrowse := FwMBrowse():New()				//Variavel de Browse
	oBrowse:SetAlias('ZZ0') //DEFINE TABELA
	oBrowse:SetDescripton("CHAMADOS V1") // DEFINE DESCRICAO
//oBrowse:AddLegend( "PA1_STATUS =='A' ", "GREEN", "Aberto"     ) // DEFINE LEGENDA
//oBrowse:AddLegend( "PA1_STATUS =='E' ", "RED"  , "Encerrado"  )

	oBrowse:DisableConfig()
	oBrowse:DisableDetails()
	oBrowse:DisableReport()
	oBrowse:DisableSaveConfig()
//oBrowse:SetFilterDefault("PA1_STATUS == 'A'") // FILTRO
//oBrowse:SetMenuDef('')
	oBrowse:SetWalkThru(.f.)
	oBrowse:disablelocate()
	oBrowse:setambiente(.f.)

	oBrowse:Activate()///QUANDO ATIVO ELE PROCURA NO FONTE A STATIC MENUDEF

RETURN(NIL)


//=================================================================
// MENUDEF
//
//-----------------------------------------------------------------
Static Function MenuDef()
	Local aMenu :=	{}

	ADD OPTION aMenu TITLE 'Pesquisar'      ACTION 'PesqBrw'      OPERATION 1 ACCESS 0
	ADD OPTION aMenu TITLE 'MD3_Visualizar' ACTION 'U_TELAM18A'	  OPERATION 2 ACCESS 0
	ADD OPTION aMenu TITLE 'MD3_Incluir'    ACTION 'U_TELAM18A'   OPERATION 3 ACCESS 0
	ADD OPTION aMenu TITLE 'MD3_Alterar'    ACTION 'U_TELAM18A'   OPERATION 4 ACCESS 0
	ADD OPTION aMenu TITLE 'MD3_Excluir'    ACTION 'U_TELAM18A'   OPERATION 5 ACCESS 0

Return(aMenu)

//=================================================================
// CONTROLP01
//
//-----------------------------------------------------------------
USER FUNCTION TELAM18A(_cAlias,_nReg,_nOpc)
//       INCLUIR       "ZZ0"  ,  0  ,  3
//       ALTERAR       "ZZ0"  ,RECNO,  4
	
//*****************************************************************************************************************************************
Local oGetd
Local oDlg
Local bCond     := {|| .T. }
Local bAction1  := {|| .T. }	
Local bAction2  := {|| .T. }
Local cSeek     := ""
Local aNoFields := {""}		

// Campos que nao devem entrar no aHeader e aCols
Local bWhile    := {|| }
Local cQuery    := ""

// Inicializa a Variaveis Privates.                     
PRIVATE aTrocaF3  := {}
PRIVATE aTELA[0][0],aGETS[0]
PRIVATE aHeader	  := {}
PRIVATE aHeader1  := {}
PRIVATE aCols	  := {}
PRIVATE aHeadFor  := {}
PRIVATE aColsFor  := {}
PRIVATE N         := 1

DO CASE 
	CASE _nOpc == 3
     INCLUI := .T.
     ALTERA := .F.
	CASE _nOpc == 4
     INCLUI := .F.
     ALTERA := .T.
	OTHERWISE
     INCLUI := .F.
     ALTERA := .F.
END CASE

//*************************************************************************************************************************************************

Private oDlg, oSize, aCamposC, aFieldsC, nX, aCamposD
Private aHeader := {}, aCols := {}
Private aButtons := {  {'PRODUTO', {||ALERT('TESTE')},'TEXTO 1','TEXTO 2'}, {'PRODUTO', {||ALERT('TESTE2')},'TEXTO 1','TEXTO 2'}   }



//----- dimensionamento automatico
	oSize := FwDefSize():New()
	oSize:AddObject( "CABECALHO",  100,  20, .T., .T. ) // Totalmente dimensionavel
	oSize:AddObject( "GETDADOS" ,  100,  80, .T., .T. ) // Totalmente dimensionavel
	oSize:lProp 	:= .T. // Proporcional
	oSize:aMargins 	:= { 3, 3, 3, 3 } // Espaco ao lado dos objetos 0, entre eles 3
	oSize:Process() 	   // Dispara os calculos

	nELinIni:= oSize:GetDimension("CABECALHO","LININI")
	nEColIni:= oSize:GetDimension("CABECALHO","COLINI")
	nELinEnd:= oSize:GetDimension("CABECALHO","LINEND")
	nEColEnd:= oSize:GetDimension("CABECALHO","COLEND")

    nGLinIni  := oSize:GetDimension("GETDADOS","LININI")
    nGColIni  := oSize:GetDimension("GETDADOS","COLINI")
	nGLinEnd  := oSize:GetDimension("GETDADOS","LINEND")
    nGColEnd  := oSize:GetDimension("GETDADOS","COLEND")

	nGLinEnd  := oSize:GetDimension("GETDADOS","LINEND")

//----- variaveis M-> da MsmGET (enchoice)
// definindo enchoice/msmget
	aCamposC := FWSX3Util():GetAllFields( 'ZZ0' , .T. )
	aFieldsC := {}

	For nX := 1 To Len(aCamposC)
		If X3USO(  GetSX3Cache(aCamposC[nX],"X3_USADO")  ) .And. cNivel >= GetSX3Cache(aCamposC[nX], "X3_NIVEL")
			AADD(aFieldsC,aCamposC[nX])  // ARMAZENAR CAMPOS TRATADOS
			
			cCampo := "M->"+aCamposC[nX] // "M->ZZ0_COD"
			IF _nOpc == 3
				&cCampo := CRIAVAR( aCamposC[nX] ) // ZZ0_COD == SPACE(6), ZZ0_VALOR == 0.00 , ZZ0_DATA == '  /  /  '
			else
				cDB := "ZZ0->"+aCamposC[nX]   // "ZZ0->ZZ0_COD"
				&cCampo := &cDB  //   M->ZZ0_COD := ZZ0->ZZ0_COD
			endif
		EndIf
	Next nX

	//----- dados getdados
	//----- aheader
    
	//103 FillGetDados


	// Filtros para montagem do aCols *******************************************************************************************************************************************************************************************                       
	aHeader1 := aHeader
	aHeader:={}
	
	dbSelectArea("ZZ1")
	dbSetOrder(1)
	#IFDEF TOP	
	lQuery  := .T.	
	cQuery := "SELECT * "	
	cQuery += "FROM "+RetSqlName("ZZ1")+" ZZ1 "	
	cQuery += "WHERE ZZ1.ZZ1_FILIAL='"+xFilial("ZZ1")+"' AND "	
	cQuery += "ZZ1.ZZ1_COD='"+ZZ0->ZZ0_COD+"' AND "	
	cQuery += "ZZ1.D_E_L_E_T_<>'*' "	
	cQuery += "ORDER BY "+SqlOrder(ZZ1->(IndexKey()))	
	dbSelectArea("ZZ1")	
	dbCloseArea()
	#ENDIF
	cSeek  := xFilial("ZZ1")+ZZ0->ZZ0_COD
	bWhile := {|| ZZ1_FILIAL+ZZ1_NUM }

	// Montagem do aHeader e aCols                           
	FillGetDados(_nOpc,"ZZ1",1,cSeek,bWhile,{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,cQuery,/*bMontCols*/,IIF(_nOpc==3,.T.,.F.),/*aHeaderAux*/,/*aColsAux*/,/*bafterCols*/,/*bBeforeCols*/,/*bAfterHeader*/,"ZZ1")
	If lQuery	
		dbSelectArea("ZZ1")	
		dbCloseArea()	
		ChkFile("ZZ1",.F.)
	EndIf
		

	//*************************************************************************************************************************************************************************************************************************************************
aAlterFields := NIL//{"ZZ0_COD"}

//----- montando tela
	DEFINE MSDIALOG oDlg TITLE 'TITULO' PIXEL FROM oSize:aWindSize[1],oSize:aWindSize[2];
		TO oSize:aWindSize[3],oSize:aWindSize[4]

	#define GD_INSERT	1
	#define GD_UPDATE	2
	#define GD_DELETE	4

	oEnch := MsMGet():New("ZZ0",0,_NOPC,nil,nil,nil,aFieldsC,{nELinIni,nEColIni,nELinEnd,nEColEnd},aAlterFields,nil,nil,nil,nil,oDlg,,.T.)
	
	oGD   := MsNewGetDados():New(;
		nGLinIni,nGColIni,nGLinEnd,nGColEnd,;
		 GD_INSERT+GD_UPDATE+GD_DELETE,;
		"AllwaysTrue", "AllwaysTrue", "+ZZ1_ITEM", aAlterFields,;
		, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeader, aCols)

	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||oDlg:End()},{||oDlg:End()},,aButtons)

RETURN






/*
------------------------------------------------------------
Lista de cores para utilizar na Legenda
01	WHITE	  BR_BRANCO
02	GRAY	  BR_CINZA
03	GREEN	  BR_VERDE
04	RED	      BR_VERMELHO
05	BROWN	  BR_MARROM
06	BLUE	  BR_AZUL
07	YELLOW	  BR_AMARELO
08	BLACK	  BR_PRETO
09	PINK	  BR_PINK
10	F12_MARR  BR_VIOLETA
11	ORANGE	  BR_PRETO_0
12	LIGHTBLU  BR_PRETO_1
13	 	      BR_PRETO_3
14	 	      BR_CANCEL
15	 	      BR_VERDE_ESCURO
16	 	      BR_MARROM
17	 	      BR_MARRON_OCEAN
18	 	      BR_AZUL_CLARO
----------------------------------------------------------
*/
