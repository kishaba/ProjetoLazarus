unit uLanPedidoVenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ActnList, DbCtrls, DBGrids, uFormPadrao, db;

type

  { TfrmPadrao1 }

  TfrmPadrao1 = class(TfrmPadrao)
    btnGravarProduto: TImage;
    btnPesquisaProduto: TImage;
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
    GroupBox1: TGroupBox;
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
  private

  public

  end;

var
  frmPadrao1: TfrmPadrao1;

implementation

{$R *.lfm}

end.

