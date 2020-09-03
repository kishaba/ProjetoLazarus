unit uLanPedidoVenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DBDateTimePicker, DateTimePicker, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ActnList, DbCtrls, DBGrids,
  uFormPadrao, db,sqldb;

type

  { TfrmLanPedidoVenda }

  TfrmLanPedidoVenda = class(TfrmPadrao)
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
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblValorTotal: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel3: TPanel;
    procedure actSalvarExecute(Sender: TObject);
    procedure btnBuscaPedidoClick(Sender: TObject);
    procedure btnGravarProdutoClick(Sender: TObject);
    procedure btnPesquisaProdutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure BuscaPedido(CodPedido: Integer);
    procedure BuscaProduto(CodProduto: Integer);

  public
    fTotal : CURRENCY;
  end;

var
  frmLanPedidoVenda: TfrmLanPedidoVenda;

implementation

{$R *.lfm}
uses
  uPesquisa,uDtmGlobal;

{ TfrmLanPedidoVenda }

procedure TfrmLanPedidoVenda.FormShow(Sender: TObject);
begin
  edtData.Date:= now;
end;

procedure TfrmLanPedidoVenda.BuscaPedido(CodPedido: Integer);
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
    grdProdutos.Enabled := true;
    edtCodigoProduto.Enabled := true;
    edtValorUnitario.Enabled := true;
    edtQuantidade.Enabled := true;
    dsItens.DataSet.Open;
    dtmGlobal.qryItemPedido.Close;
    dtmGlobal.qryItemPedido.ParamByName('codpedido').AsInteger    := dtmGlobal.qryConsultaPedidoCODPEDIDO.AsInteger;
    dtmGlobal.qryItemPedido.ParamByName('numeropedido').AsInteger := dtmGlobal.qryConsultaPedidoNUMEROPEDIDO.AsInteger;
    dtmGlobal.qryItemPedido.Open;
  end;
end;

procedure TfrmLanPedidoVenda.BuscaProduto(CodProduto: Integer);
begin
  dtmGlobal.qryBuscaProduto.Close;
  dtmGlobal.qryBuscaProduto.ParamByName('codproduto').AsInteger := CodProduto;
  dtmGlobal.qryBuscaProduto.open;
  edtDesProduto.Text := dtmGlobal.qryBuscaProduto.FieldByName
    ('descricao').AsString;
  if edtDesProduto.Text <> '' then
  begin
    edtCodigoProduto.Text := IntToStr(CodProduto);
    edtValorUnitario.SetFocus;
  end;
end;

procedure TfrmLanPedidoVenda.actSalvarExecute(Sender: TObject);
begin
  dsPadrao.DataSet.FieldByName('DATAEMISSAO').AsDateTime := edtData.Date;
  inherited;
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
    end
    else
      edtCodigo.Clear;
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmLanPedidoVenda.btnGravarProdutoClick(Sender: TObject);
begin
  dsItens.DataSet.Open;
  dtmGlobal.qryItemPedido.Close;;
  dtmGlobal.qryItemPedido.open;
  dsItens.DataSet.Open;
  dsItens.DataSet.Insert;
  dtmGlobal.qryItemPedidoCODPEDIDO.AsInteger   := StrToInt(edtCodigo.Text);
  dtmGlobal.qryItemPedidoNUMEROPEDIDO.AsInteger   := StrToInt(edtNumeroPedido.Text);
  dtmGlobal.qryItemPedidoCODPRODUTO.AsInteger   := StrToInt(edtCodigoProduto.Text);
  dtmGlobal.qryItemPedidoDESCRICAO.AsString    := edtDesProduto.Text;
  dtmGlobal.qryItemPedidoQUANTIDADE.AsCurrency  := StrToCurr(edtQuantidade.Text);
  dtmGlobal.qryItemPedidoVALORUNITARIO.AsCurrency := StrToCurr(edtValorUnitario.Text);
  dtmGlobal.qryItemPedidoVALORTOTALITEM.AsCurrency := StrToInt(edtValorTotal.Text);

  dtmGlobal.qryBuscaProximoItemPedido.close;
  dtmGlobal.qryBuscaProximoItemPedido.ParamByName('CODPEDIDO').AsInteger := StrToInt(edtCodigo.Text);
  dtmGlobal.qryBuscaProximoItemPedido.ParamByName('NUMEROPEDIDO').AsInteger := StrToInt(edtNumeroPedido.Text);
  dtmGlobal.qryBuscaProximoItemPedido.Open;

 // ShowMessage( dtmGlobal.qryBuscaProximoItemPedidoNOVOITEM.AsString);
  dtmGlobal.qryItemPedidoITEMPEDIDO.AsInteger := dtmGlobal.qryBuscaProximoItemPedidoNOVOITEM.AsInteger;
  dsItens.DataSet.post;
  dtmglobal.transItemPedido.CommitRetaining;
  dtmGlobal.qryItemPedido.ApplyUpdates;
  dtmGlobal.transBuscaProximoItem.Active:=False;


  ftotal := 0;
  //vai pra o final da tabela
  dtmGlobal.qryItemPedido.First;
  while not  dtmGlobal.qryItemPedido.EOF do
  begin
    ftotal := ftotal + dtmGlobal.qryItemPedidoVALORTOTALITEM.Value;
    dtmGlobal.qryItemPedido.Next;
  end;
  //recebe o valor
  lblValorTotal.Caption  := FormatFloat('#,##0.00', ftotal);



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
    end
    else
      edtCodigoProduto.Clear;
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmLanPedidoVenda.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if Assigned((dsItens.DataSet as TSQLQuery)) then
    (dsItens.DataSet as TSQLQuery).Close;
  inherited;
end;

end.

