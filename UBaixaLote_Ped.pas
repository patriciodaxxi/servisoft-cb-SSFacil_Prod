unit UBaixaLote_Ped;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMBaixaProd, StdCtrls, RzEdit, Mask, ToolEdit, UDMEstoque, dbXPress;

type
  TfrmBaixaLote_Ped = class(TForm)
    Label6: TLabel;
    DateEdit1: TDateEdit;
    Label7: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    fDMBaixaProd : TDMBaixaProd;

    procedure prc_Baixa_Lote;
    
    function fnc_Lote_OK : Boolean;

    function fnc_Gravar_Estoque : Integer;
    
  public
    { Public declarations }
  end;

var
  frmBaixaLote_Ped: TfrmBaixaLote_Ped;

implementation

uses rsDBUtils, uUtilPadrao, DmdDatabase;

{$R *.dfm}

procedure TfrmBaixaLote_Ped.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(fDMBaixaProd);
  Action := Cafree;
end;

procedure TfrmBaixaLote_Ped.FormShow(Sender: TObject);
begin
  fDMBaixaProd:= TDMBaixaProd.Create(Self);
  oDBUtils.SetDataSourceProperties(Self, fDMBaixaProd);
  DateEdit1.Date := Date;
  Edit1.SetFocus;
end;

procedure TfrmBaixaLote_Ped.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then
  begin
    if fnc_Lote_OK then
    begin
      prc_Baixa_Lote;
    end;
    Edit1.SelectAll;
  end;
end;

function TfrmBaixaLote_Ped.fnc_Lote_OK: Boolean;
var
  vLote : Integer;
  vTalao : Integer;
  vIDAux : Integer;
begin
  Result := False;

  Edit1.Text := Monta_Numero(Edit1.Text,0);

  if (Length(Edit1.Text) <> 7) then
  begin
    MessageDlg('*** C�digo informado incorreto!', mtError, [mbOk], 0);
    exit;
  end;
  if (copy(Edit1.Text,1,1) <> '9') then
  begin
    MessageDlg('*** C�digo informado incorreto!', mtError, [mbOk], 0);
    exit;
  end;

  vLote     := StrToInt(copy(Edit1.Text,2,6));

  fDMBaixaProd.cdsLote.Close;
  fDMBaixaProd.sdsLote.ParamByName('NUM_LOTE').AsInteger := vLote;
  fDMBaixaProd.cdsLote.Open;

  if fDMBaixaProd.cdsLote.IsEmpty then
  begin
    MessageDlg('*** Lote ' + IntToStr(vLote) + '  n�o encontrado!', mtError, [mbOk], 0);
    exit;
  end;

  if fDMBaixaProd.cdsLoteDTBAIXA.AsDateTime > 10 then
  begin
    MessageDlg('*** Lote ' + IntToStr(vLote) + '  j� baixado!', mtError, [mbOk], 0);
    exit;
  end;

  Result := True;
end;

procedure TfrmBaixaLote_Ped.prc_Baixa_Lote;
var
  vData : TDateTime;
  vHora : TTime;
  vMSGAux : String;
  ID: TTransactionDesc;
  vNumLote : Integer;
begin
  Memo1.Lines.Clear;
  vMSGAux := '';
  if DateEdit1.Date > 10 then
    vData := DateEdit1.Date
  else
    vData := Date;
  if trim(RzDateTimeEdit1.Text) <> '' then
    vHora := RzDateTimeEdit1.Time
  else
    vHora := Now;

  ID.TransactionID  := 2;
  ID.IsolationLevel := xilREADCOMMITTED;
  dmDatabase.scoDados.StartTransaction(ID);
  try
    fDMBaixaProd.cdsLote.Edit;
    if fDMBaixaProd.cdsLoteDTENTRADA.IsNull then
    begin
      fDMBaixaProd.cdsLoteDTENTRADA.AsDateTime := vData;
      fDMBaixaProd.cdsLoteHRENTRADA.AsDateTime := vHora;
      vMSGAux                                  := 'Entrada em Produ��o';
    end
    else
    if fDMBaixaProd.cdsLoteDTBAIXA.IsNull then
    begin
      fDMBaixaProd.cdsLoteDTBAIXA.AsDateTime    := vData;
      fDMBaixaProd.cdsLoteHRBAIXA.AsDateTime    := vHora;
      fDMBaixaProd.cdsLoteQTD_PRODUZIDO.AsFloat := fDMBaixaProd.cdsLoteQTD.AsFloat;
      fDMBaixaProd.cdsLoteQTD_PENDENTE.AsFloat  := 0;
      vMSGAux                                   := 'Encerrada a Produ��o';

      fDMBaixaProd.cdsLoteID_MOVESTOQUE.AsInteger := fnc_Gravar_Estoque;
    end;
    vNumLote := fDMBaixaProd.cdsLoteNUM_LOTE.AsInteger;
    fDMBaixaProd.cdsLote.Post;
    fDMBaixaProd.cdsLote.ApplyUpdates(0);
    dmDatabase.scoDados.Commit(ID);

    fDMBaixaProd.cdsLote.Close;
    fDMBaixaProd.sdsLote.ParamByName('NUM_LOTE').AsInteger := vNumLote;
    fDMBaixaProd.cdsLote.Open;

    Memo1.Lines.Add('OP: ' + fDMBaixaProd.cdsLoteNUM_LOTE.AsString);
    Memo1.Lines.Add('');
    Memo1.Lines.Add('Pedido OC: ' + fDMBaixaProd.cdsLoteOBS_PED.AsString);
    Memo1.Lines.Add('');
    Memo1.Lines.Add(vMSGAux);

  except
      on e: Exception do
      begin
        dmDatabase.scoDados.Rollback(ID);
        raise Exception.Create('Erro ao gravar Baixa Processo: ' + #13+#13 + e.Message);
      end;
  end;

end;

procedure TfrmBaixaLote_Ped.Edit1Change(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

function TfrmBaixaLote_Ped.fnc_Gravar_Estoque: Integer;
var
  fDMEstoque: TDMEstoque;
  vPreco : Real;
begin
  Result := 0;
  fDMBaixaProd.qProd.Close;
  fDMBaixaProd.qProd.ParamByName('ID').AsInteger := fDMBaixaProd.cdsLoteID_PRODUTO.AsInteger;
  fDMBaixaProd.qProd.Open;
  if StrToFloat(FormatFloat('0.00000',fDMBaixaProd.qProdPRECO_CUSTO.AsFloat)) > 0 then
    vPreco := StrToFloat(FormatFloat('0.00000',fDMBaixaProd.qProdPRECO_CUSTO.AsFloat))
  else
    vPreco := StrToFloat(FormatFloat('0.00000',fDMBaixaProd.qProdPRECO_VENDA.AsFloat));

  fDMEstoque := TDMEstoque.Create(Self);
  try
    Result := fDMEstoque.fnc_Gravar_Estoque(0,
                                            fDMBaixaProd.cdsLoteFILIAL.AsInteger,
                                            1,
                                            fDMBaixaProd.cdsLoteID_PRODUTO.AsInteger,
                                            fDMBaixaProd.cdsLoteNUM_LOTE.AsInteger, // Numero nota
                                            fDMBaixaProd.cdsLoteID_CLIENTE.AsInteger, // Cliente
                                            0, // CFOP
                                            0, // ID nota fiscal
                                            0, // ID Centro Custo
                                            'E', //Tipo Nota  Entrada e Sa�da
                                            'LOT',
                                            fDMBaixaProd.cdsLoteUNIDADE.AsString,
                                            fDMBaixaProd.cdsLoteUNIDADE.AsString,
                                            '', //serie
                                            '', //Tamanho
                                            Date,
                                            vPreco,
                                            fDMBaixaProd.cdsLoteQTD.AsFloat,
                                            0, //%ICMS
                                            0, //%IPI
                                            0, //Desconto
                                            0, //% Trib ICMS
                                            0, //Valor Frete
                                            fDMBaixaProd.cdsLoteQTD.AsFloat,
                                            vPreco,
                                            0, //Desconto
                                            0,
                                            fDMBaixaProd.cdsLoteUNIDADE.AsString,
                                            fDMBaixaProd.cdsLoteID_COMBINACAO.AsInteger, // Cor
                                            '',
                                            'S',
                                            vPreco,
                                            0,
                                            0,
                                            0,
                                            0);

  finally
    FreeAndNil(fDMEstoque);
  end;
end;

end.
