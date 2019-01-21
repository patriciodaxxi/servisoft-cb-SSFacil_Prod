program SSFacil_Prod;

uses
  Forms,
  UMenu in 'UMenu.pas' {fMenu},
  DmdDatabase in '..\ssfacil\DmdDatabase.pas' {dmDatabase: TDataModule},
  uUtilPadrao in '..\ssfacil\uUtilPadrao.pas',
  UEscolhe_Filial in '..\ssfacil\UEscolhe_Filial.pas' {frmEscolhe_Filial},
  rsDBUtils in '..\rslib\nova\rsDBUtils.pas',
  LogProvider in '..\logs\src\LogProvider.pas',
  LogTypes in '..\logs\src\LogTypes.pas',
  uNFeComandos in '..\ssfacil\uNFeComandos.pas',
  UDMCadLote in 'UDMCadLote.pas' {DMCadLote: TDataModule},
  UDMLoteImp in 'UDMLoteImp.pas' {DMLoteImp: TDataModule},
  UGerar_Lote_SL in 'UGerar_Lote_SL.pas' {frmGerar_Lote_SL},
  UAltQtdLote in 'UAltQtdLote.pas' {frmAltQtdLote},
  UProcesso_ES in 'UProcesso_ES.pas' {frmProcesso_ES},
  UDMEstoque in '..\ssfacil\UDMEstoque.pas' {DMEstoque: TDataModule},
  UDMBaixaProd in 'UDMBaixaProd.pas' {DMBaixaProd: TDataModule},
  UConsLote2 in 'UConsLote2.pas' {frmConsLote2},
  USel_Pessoa in '..\ssfacil\USel_Pessoa.pas' {frmSel_Pessoa},
  UGerar_Lote_Aux in 'UGerar_Lote_Aux.pas' {frmGerar_Lote_Aux},
  UBaixaMaterialOP in 'UBaixaMaterialOP.pas' {frmBaixa_Material_OP},
  UDMBaixaMaterialOP in 'UDMBaixaMaterialOP.pas' {DMBaixaMaterial: TDataModule},
  UBaixaLoteMatEst in 'UBaixaLoteMatEst.pas' {frmLoteMaterialEstoque},
  UGerar_Lote_Calc in 'UGerar_Lote_Calc.pas' {frmGerar_Lote_Calc},
  USel_Produto in '..\ssfacil\USel_Produto.pas' {frmSel_Produto},
  UDMSel_Produto in '..\ssfacil\UDMSel_Produto.pas' {DMSel_Produto: TDataModule},
  USel_Produto_Preco in '..\ssfacil\USel_Produto_Preco.pas' {frmSel_Produto_Preco},
  URelLote2 in 'URelLote2.pas' {fRelLote2},
  UDMRel in '..\ssfacil\UDMRel.pas' {DMRel: TDataModule},
  SelfPrintDefs in '..\ssfacil\sendmail\SelfPrintDefs.pas',
  SendMail in '..\ssfacil\sendmail\SendMail.pas',
  SendMailOptions in '..\ssfacil\sendmail\SendMailOptions.pas' {FormSendMailOptions},
  URelLote_Res in '..\ssfacil\pcp\URelLote_Res.pas' {fRelLote_Res},
  UDMCadLote_Calc in 'UDMCadLote_Calc.pas' {DMCadLote_Calc: TDataModule},
  UMostraItens_Ped in 'UMostraItens_Ped.pas' {frmMostraItens_Ped},
  UConsMapaProd in 'UConsMapaProd.pas' {frmConsMapaProd},
  UDMMapaProd in 'UDMMapaProd.pas' {DMMapaProd: TDataModule},
  UConsPedLote in 'UConsPedLote.pas' {frmConsPedLote},
  UDMConsPedLote in '..\ssfacil\cupomfiscal\UDMConsPedLote.pas' {DMConsPedLote: TDataModule},
  USel_Produto_Lote in '..\ssfacil\PedidoLoja\USel_Produto_Lote.pas' {frmSel_Produto_Lote},
  UDMBaixaProd_Calc in 'UDMBaixaProd_Calc.pas' {DMBaixaProd_Calc: TDataModule},
  UBaixaTalao_Calc in 'UBaixaTalao_Calc.pas' {frmBaixaTalao_Calc},
  UBaixaLote_Calc in 'UBaixaLote_Calc.pas' {frmBaixaLote_Calc},
  UConsLote_Calc in 'UConsLote_Calc.pas' {frmConsLote_Calc},
  UDMLoteImp_Calc in 'UDMLoteImp_Calc.pas' {DMLoteImp_Calc: TDataModule},
  UBaixaLoteGeral_Calc in 'UBaixaLoteGeral_Calc.pas' {frmBaixaLoteGeral_Calc},
  UBaixaLoteGeral in 'UBaixaLoteGeral.pas' {frmBaixaLoteGeral},
  UDMCadDocEstoque in '..\ssfacil\UDMCadDocEstoque.pas' {DMCadDocEstoque: TDataModule},
  UCadDocEstoqueCB in 'UCadDocEstoqueCB.pas' {frmCadDocEstoqueCB},
  UDMConferencia in '..\ssfacil\UDMConferencia.pas' {DMConferencia: TDataModule},
  ULiberacao_Fat2 in 'ULiberacao_Fat2.pas' {frmLiberacao_Fat2},
  UGerar_Lote_Bol in 'UGerar_Lote_Bol.pas' {frmGerar_Lote_Bol},
  UCancelaLote in 'UCancelaLote.pas' {frmCancelaLote},
  UDMCancelaLote in 'UDMCancelaLote.pas' {DMCancelaLote: TDataModule},
  UGerar_Lote_Proc in 'UGerar_Lote_Proc.pas' {frmGerar_Lote_Proc},
  UGerar_Lote_Aux2 in 'UGerar_Lote_Aux2.pas' {frmGerar_Lote_Aux2},
  UInfDtProd in 'UInfDtProd.pas' {frmInfDtProd},
  UConsLoteProc in 'UConsLoteProc.pas' {frmConsLoteProc},
  UConsRemessa_Prod in 'UConsRemessa_Prod.pas' {frmConsRemessa_Prod},
  UDMConsRemessa_Prod in 'UDMConsRemessa_Prod.pas' {DMConsRemessa_Prod: TDataModule},
  USel_OrdemProd in '..\ssfacil\USel_OrdemProd.pas' {frmSel_OrdemProd},
  UDMPedido_Talao in 'UDMPedido_Talao.pas' {DMPedido_Talao: TDataModule},
  UGerar_Pedido_Talao in 'UGerar_Pedido_Talao.pas' {frmGerar_Pedido_Talao},
  ULiberacao_Ped in 'ULiberacao_Ped.pas' {frmLiberacao_Ped},
  ULiberacao_Fat_Ped in '..\ssfacil\ULiberacao_Fat_Ped.pas' {frmLiberacao_Fat_Ped},
  uDmCadPreFat in 'uDmCadPreFat.pas' {DMCadPreFat: TDataModule},
  uCadPreFat in 'uCadPreFat.pas' {frmCadPreFat},
  UConsRefDtEntr in 'UConsRefDtEntr.pas' {frmConsRefDtEntr},
  UConsBaixa_Proc2 in 'UConsBaixa_Proc2.pas' {frmConsBaixa_Proc2},
  UGerar_Lote_Ped in 'UGerar_Lote_Ped.pas' {frmGerar_Lote_Ped},
  UConsPedidoProc in 'UConsPedidoProc.pas' {frmConsPedidoProc},
  UDMConsPedido in 'UDMConsPedido.pas' {DMConsPedido: TDataModule},
  UConsPed in 'UConsPed.pas' {frmConsPed},
  UConfParcial in 'UConfParcial.pas' {frmConfParcial},
  ULeVolume in 'ULeVolume.pas' {frmLeVolume},
  UConsTalao_Etiq in 'UConsTalao_Etiq.pas' {frmConsTalao_Etiq},
  UGerar_Talao_Ajuste in 'UGerar_Talao_Ajuste.pas' {frmGerar_Talao_Ajuste},
  USel_PedItem in 'USel_PedItem.pas' {frmSel_PedItem},
  UGerar_Lote_AuxEst in '..\ssfacil\UGerar_Lote_AuxEst.pas' {frmGerar_Lote_AuxEst},
  UDMEstoque_Res in '..\ssfacil\UDMEstoque_Res.pas' {DMEstoque_Res: TDataModule},
  UBaixaLote_Ped in 'UBaixaLote_Ped.pas' {frmBaixaLote_Ped},
  UBaixaTalao_Calc2 in 'UBaixaTalao_Calc2.pas' {frmBaixaTalao_Calc2},
  UBaixaLote_Calc2 in 'UBaixaLote_Calc2.pas' {frmBaixaLote_Calc2},
  uNFeConsts in '..\NFe 4.00\NFESrv\uNFeConsts.pas',
  UDMConsProc in 'UDMConsProc.pas' {DMConsProc: TDataModule},
  UConsProc in 'UConsProc.pas' {frmConsProc},
  UDMConsLote in 'UDMConsLote.pas' {DMConsLote: TDataModule},
  UConsMatLote2 in 'UConsMatLote2.pas' {frmConsMatLote2},
  URelMatLote2 in 'URelMatLote2.pas' {fRelMatLote2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SSFacil - Produ��o';
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfMenu, fMenu);
  Application.Run;
end.
