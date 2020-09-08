unit uFinalizarPedido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ActnList, DBGrids, ComCtrls, uFormPadrao, db;

type

  { TfrmFinalizaPedidoVenda }

  TfrmFinalizaPedidoVenda = class(TfrmPadrao)
    DBGrid1: TDBGrid;
    edtNumerosParcelas: TEdit;
    edtValorParcela: TEdit;
    grpTotalPedido: TGroupBox;
    grpTotalPedido1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    UpDown1: TUpDown;
    procedure edtNumerosParcelasChange(Sender: TObject);

  private

    procedure CalculaParcelas;


  public
    fValorTotalPedido : Currency;
  end;

var
  frmFinalizaPedidoVenda: TfrmFinalizaPedidoVenda;

implementation

{$R *.lfm}

{ TfrmFinalizaPedidoVenda }

procedure TfrmFinalizaPedidoVenda.edtNumerosParcelasChange(Sender: TObject);
begin
  CalculaParcelas;
end;

procedure TfrmFinalizaPedidoVenda.CalculaParcelas;
var
  fNumeroParcelas, fValorParcela: currency;
begin
  inherited;
  fValorTotalPedido := 300;
  //if dsItens.State in [dsEdit, dsInsert] then
  //begin
  try
    fNumeroParcelas := StrToIntDef(edtNumerosParcelas.Text,0);
  except
    fNumeroParcelas := 0;
  end;
  try
    fValorParcela :=  fValorTotalPedido/fNumeroParcelas;
  except
    fValorParcela := 0;
  end;

  edtValorParcela.Text := FormatCurr('#,###,###,##0.00', fValorParcela);
  //end;
end;

end.

