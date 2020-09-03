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
  {dsItens.DataSet.Open;
  dtmGlobal.ItemPedido.Close;
  dtmGlobal.ItemPedido.ParamByName('CODPEDIDO').AsInteger    :=StrToInt(edtCodigo.Text);
  dtmGlobal.ItemPedido.ParamByName('NUMEROPEDIDO').AsInteger := StrToInt(edtNumeroPedido.Text);
  dtmGlobal.ItemPedido.ParamByName('CODPRODUTO').AsInteger   := StrToInt(edtCodigoProduto.Text);
  dtmGlobal.ItemPedido.ParamByName('QUANTIDADE').AsCurrency  := StrToCurr(edtQuantidade.Text);
  dtmGlobal.ItemPedido.ParamByName('VALORUNITARIO').AsCurrency := StrToCurr(edtValorUnitario.Text);
  dtmGlobal.ItemPedido.ParamByName('VALORTOTALITEM').AsCurrency := StrToInt(edtValorTotal.Text);


  dtmGlobal.qryBuscaProximoItemPedido.close;
  dtmGlobal.qryBuscaProximoItemPedido.ParamByName('CODPEDIDO').AsInteger := StrToInt(edtCodigo.Text);
  dtmGlobal.qryBuscaProximoItemPedido.ParamByName('NUMEROPEDIDO').AsInteger := StrToInt(edtCodigo.Text);
  dtmGlobal.qryBuscaProximoItemPedido.open;

  dtmGlobal.ItemPedido.ParamByName('ITEMPEDIDO').AsInteger := dtmGlobal.qryBuscaProximoItemPedido.FieldByName('NovoITEM').AsInteger+1; }


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

