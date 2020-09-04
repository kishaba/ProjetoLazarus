unit uLanPedidoVenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DBDateTimePicker, DateTimePicker, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ActnList, DBCtrls, DBGrids,
  uFormPadrao, DB, sqldb, LCLType;

type

  { TfrmLanPedidoVenda }

  TfrmLanPedidoVenda = class(TfrmPadrao)
    actFinalizaPedido: TAction;
    btnFinalizaPedido: TImage;
    btnGravarProduto: TImage;
    btnPesquisaProduto: TImage;
    btnBuscaPedido: TImage;
    dsItens: TDataSource;
    edtData: TDateTimePicker;
    DBEdit7: TDBEdit;
    edtCodigo: TDBEdit;
    edtCodigoCliente: TDBEdit;
    edtCodigoProduto: TEdit;
    edtDesProduto: TEdit;
    edtNumeroPedido: TDBEdit;
    edtQuantidade: TEdit;
    edtReferencia: TDBEdit;
    edtTipoOperacao: TDBEdit;
    edtValorTotal: TEdit;
    edtValorUnitario: TEdit;
    grdProdutos: TDBGrid;
    frmLanPedidoVenda: TGroupBox;
    grpPedido: TGroupBox;
    grpProduto: TGroupBox;
    btnExcluirProduto: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblF10: TLabel;
    lblValorTotal: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblValorTotal1: TLabel;
    lblValorTotal2: TLabel;
    Panel3: TPanel;
    procedure actEditaExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure btnBuscaPedidoClick(Sender: TObject);
    procedure btnFinalizaPedidoClick(Sender: TObject);
    procedure btnExcluirProdutoClick(Sender: TObject);
    procedure btnGravarProdutoClick(Sender: TObject);
    procedure btnPesquisaProdutoClick(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: char);
    procedure edtValorUnitarioChange(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdProdutosCellClick(Column: TColumn);
  private
    procedure BuscaPedido(CodPedido: integer);
    procedure BuscaProduto(CodProduto: integer);
    function TiraMascaraFloat(sValor: string): string;
    procedure CalculaTotais;
    procedure TotalizaPedido;
    procedure limpacampos;

  public
    fTotal: currency;
  end;

var
  frmLanPedidoVenda: TfrmLanPedidoVenda;

implementation

{$R *.lfm}
uses
  uPesquisa, uDtmGlobal,uFinalizarPedido;

{ TfrmLanPedidoVenda }

procedure TfrmLanPedidoVenda.FormShow(Sender: TObject);
begin
  edtData.Date := now;
end;

procedure TfrmLanPedidoVenda.grdProdutosCellClick(Column: TColumn);
begin
  edtCodigoProduto.Text:=grdProdutos.columns.items[1].field.text;
  edtDesProduto.Text:=grdProdutos.columns.items[2].field.text;
  edtValorUnitario.Text:=grdProdutos.columns.items[3].field.text;
  edtQuantidade.Text:=grdProdutos.columns.items[4].field.text;
  edtValorTotal.Text:=grdProdutos.columns.items[5].field.text;
end;

procedure TfrmLanPedidoVenda.BuscaPedido(CodPedido: integer);
begin
  dtmGlobal.qryConsultaPedido.Close;
  dtmGlobal.qryConsultaPedido.ParamByName('codpedido').AsInteger := CodPedido;
  dtmGlobal.qryConsultaPedido.Open;

  edtReferencia.Text := dtmGlobal.qryConsultaPedidoREFERENCIA.AsString;
  edtNumeroPedido.Text := dtmGlobal.qryConsultaPedidoNUMEROPEDIDO.AsString;
  edtData.Date := dtmGlobal.qryConsultaPedidoDATAEMISSAO.AsDateTime;
  edtTipoOperacao.Text := dtmGlobal.qryConsultaPedidoTIPOPERACAO.AsString;
  edtCodigoCliente.Text := dtmGlobal.qryConsultaPedidoCODIGOCLIENTE.AsString;
  if edtNumeroPedido.Text <> '' then
  begin
    grdProdutos.Enabled := True;
    edtCodigoProduto.Enabled := True;
    edtValorUnitario.Enabled := True;
    edtQuantidade.Enabled := True;
    dsItens.DataSet.Open;
    dtmGlobal.qryItemPedido.Close;
    dtmGlobal.qryItemPedido.ParamByName('codpedido').AsInteger :=
      dtmGlobal.qryConsultaPedidoCODPEDIDO.AsInteger;
    dtmGlobal.qryItemPedido.ParamByName('numeropedido').AsInteger :=
      dtmGlobal.qryConsultaPedidoNUMEROPEDIDO.AsInteger;
    dtmGlobal.qryItemPedido.Open;
  end;
end;

procedure TfrmLanPedidoVenda.BuscaProduto(CodProduto: integer);
begin
  dtmGlobal.qryBuscaProduto.Close;
  dtmGlobal.qryBuscaProduto.ParamByName('codproduto').AsInteger := CodProduto;
  dtmGlobal.qryBuscaProduto.Open;
  edtDesProduto.Text := dtmGlobal.qryBuscaProduto.FieldByName('descricao').AsString;
  if edtDesProduto.Text <> '' then
  begin
    edtCodigoProduto.Text := IntToStr(CodProduto);
    edtValorUnitario.SetFocus;
  end;
end;

function TfrmLanPedidoVenda.TiraMascaraFloat(sValor: string): string;
var
  sAux: string;
begin
  if DecimalSeparator = ',' then
    sAux := trim(StringReplace(sValor, '.', '', [rfReplaceAll]))
  else
    sAux := trim(StringReplace(sValor, ',', '', [rfReplaceAll]));
  Result := sAux;
end;

procedure TfrmLanPedidoVenda.CalculaTotais;
var
  fQuantidade, fValorUnitario: currency;
begin
  inherited;

  //if dsItens.State in [dsEdit, dsInsert] then
  //begin
  try
    fValorUnitario := Trunc(StrToFloatDef(TiraMascaraFloat(edtValorUnitario.Text), 0));
  except
    fValorUnitario := 0;
  end;
  try
    fQuantidade := StrToFloatDef(TiraMascaraFloat(edtQuantidade.Text), 0);
  except
    fQuantidade := 0;
  end;

  edtValorTotal.Text := FormatCurr('#,###,###,##0.00', fQuantidade * fValorUnitario);
  //end;
end;

procedure TfrmLanPedidoVenda.TotalizaPedido;
begin
  ftotal := 0;
  //vai pra o final da tabela
  dtmGlobal.qryItemPedido.open;
  dtmGlobal.qryItemPedido.First;
  while not dtmGlobal.qryItemPedido.EOF do
  begin
    ftotal := ftotal + dtmGlobal.qryItemPedidoVALORTOTALITEM.Value;
    dtmGlobal.qryItemPedido.Next;
  end;
  //recebe o valor
  lblValorTotal.Caption := FormatFloat('#,##0.00', ftotal);
end;

procedure TfrmLanPedidoVenda.limpacampos;
var i: integer;
begin
  for I := 0 to ComponentCount-1 do
  begin
    if Components[i] is TDBEdit then
    begin
      TDBEdit(Components[i]).Text    := '';
    end
    else if Components[i] is TEdit then
    begin
      TDBComboBox(Components[i]).Text    := '';
    end;
  end;
end;

procedure TfrmLanPedidoVenda.actSalvarExecute(Sender: TObject);
begin
  dsPadrao.DataSet.FieldByName('DATAEMISSAO').AsDateTime := edtData.Date;
  inherited;
  grpProduto.Enabled:=true;
end;

procedure TfrmLanPedidoVenda.actEditaExecute(Sender: TObject);
begin
  inherited;
  edtCodigo.Enabled:=False;
  grpProduto.Enabled:=False;
end;

procedure TfrmLanPedidoVenda.actIncluirExecute(Sender: TObject);
begin
  inherited;
  dsItens.DataSet.close;
  grpProduto.Enabled:=False;
  limpacampos;
end;

procedure TfrmLanPedidoVenda.btnBuscaPedidoClick(Sender: TObject);
begin
  frmPesquisa := tfrmPesquisa.Create(self, ['codpedido', 'referencia',
    'numeropedido'], 'pedido', 'codpedido');
  try
    if frmPesquisa.ShowModal = mrYes then
    begin
      edtCodigo.Text := frmPesquisa.edtRetorno.Text;
      BuscaPedido(StrToInt(frmPesquisa.edtRetorno.Text));
      TotalizaPedido;
      grpProduto.Enabled:=true;
    end
    else
      edtCodigo.Clear;
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmLanPedidoVenda.btnFinalizaPedidoClick(Sender: TObject);
begin
  frmFinalizaPedidoVenda.ShowModal;
end;

procedure TfrmLanPedidoVenda.btnExcluirProdutoClick(Sender: TObject);
begin
  if MessageDlg('Deseja mesmo excluir o item?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    dsItens.DataSet.Delete;
  end;
  TotalizaPedido;
end;

procedure TfrmLanPedidoVenda.btnGravarProdutoClick(Sender: TObject);
begin
  dtmGlobal.transItemPedido.Active:=false;
  dtmGlobal.transBuscaProximoItem.Active:=false;
  dsItens.DataSet.Open;
  dtmGlobal.qryItemPedido.Close;

  dsItens.DataSet.Open;
  dsItens.DataSet.Insert;
  dtmGlobal.qryItemPedidoCODPEDIDO.AsInteger := StrToInt(edtCodigo.Text);
  dtmGlobal.qryItemPedidoNUMEROPEDIDO.AsInteger := StrToInt(edtNumeroPedido.Text);
  dtmGlobal.qryItemPedidoCODPRODUTO.AsInteger := StrToInt(edtCodigoProduto.Text);
  dtmGlobal.qryItemPedidoDESCRICAO.AsString := edtDesProduto.Text;
  dtmGlobal.qryItemPedidoQUANTIDADE.AsCurrency := StrToCurr(edtQuantidade.Text);
  dtmGlobal.qryItemPedidoVALORUNITARIO.AsCurrency := StrToCurr(edtValorUnitario.Text);
  dtmGlobal.qryItemPedidoVALORTOTALITEM.AsCurrency := StrToCurr(edtValorTotal.Text);


  dtmGlobal.qryBuscaProximoItemPedido.Close;
  dtmGlobal.qryBuscaProximoItemPedido.ParamByName('CODPEDIDO').AsInteger :=StrToInt(edtCodigo.Text);
  dtmGlobal.qryBuscaProximoItemPedido.ParamByName('NUMEROPEDIDO').AsInteger :=StrToInt(edtNumeroPedido.Text);
  dtmGlobal.qryBuscaProximoItemPedido.Open;

  //ShowMessage( dtmGlobal.qryBuscaProximoItemPedidoNOVOITEM.AsString);
  dtmGlobal.qryItemPedidoITEMPEDIDO.AsInteger :=dtmGlobal.qryBuscaProximoItemPedidoNOVOITEM.AsInteger;
  dtmGlobal.qryItemPedido.Open;
  dsItens.DataSet.post;
  TotalizaPedido;
end;

procedure TfrmLanPedidoVenda.btnPesquisaProdutoClick(Sender: TObject);
begin
  frmPesquisa := tfrmPesquisa.Create(self, ['codproduto', 'descricao'],
    'produto', 'codproduto');
  try
    if frmPesquisa.ShowModal = mrYes then
    begin
      edtCodigoProduto.Text := frmPesquisa.edtRetorno.Text;
      BuscaProduto(StrToInt(frmPesquisa.edtRetorno.Text));
      edtQuantidade.clear;
      edtValorUnitario.Clear;
      edtValorTotal.Clear;
    end
    else
      edtCodigoProduto.Clear;
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmLanPedidoVenda.edtQuantidadeChange(Sender: TObject);
begin
  CalculaTotais;
end;

procedure TfrmLanPedidoVenda.edtQuantidadeKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    btnGravarProdutoClick(self);
  end;
  if ((key in ['0'..'9'] = False) and (word(key) <> vk_back)) then
    key := #0
end;

procedure TfrmLanPedidoVenda.edtValorUnitarioChange(Sender: TObject);
begin
  CalculaTotais;
end;

procedure TfrmLanPedidoVenda.edtValorUnitarioKeyPress(Sender: TObject; var Key: char);
begin
  if ((key in ['0'..'9'] = False) and (word(key) <> vk_back)) then
    key := #0;

end;

procedure TfrmLanPedidoVenda.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned((dsItens.DataSet as TSQLQuery)) then
    (dsItens.DataSet as TSQLQuery).Close;
  inherited;
end;

end.
