unit uEncerraPedido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, DBGrids;

type

  { TfrmEncerraPedido }

  TfrmEncerraPedido = class(TForm)
    btnSalva: TImage;
    dsPadrao: TDataSource;
    DBGrid1: TDBGrid;
    edtNumerosParcelas: TEdit;
    edtIntervaloParcelas: TEdit;
    edtValorParcela: TEdit;
    edtFormaPagamento: TEdit;
    grpTotalPedido: TGroupBox;
    grpTotalPedido1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    lblTotalPedido: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblFormaPagamento: TLabel;
    lblIntervalo: TLabel;
    lblDias: TLabel;
    lblF5: TLabel;
    lblNumeroPedido: TLabel;
    lblCodigoPedido: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure btnSalvaClick(Sender: TObject);
    procedure edtNumerosParcelasChange(Sender: TObject);
  private
   procedure CalculaParcelas;
   procedure EncerraPedido;
  public
   fValorTotalPedido : Currency;
  end;

var
  frmEncerraPedido: TfrmEncerraPedido;

implementation

uses
  uDtmGlobal;

{$R *.lfm}

{ TfrmEncerraPedido }

procedure TfrmEncerraPedido.edtNumerosParcelasChange(Sender: TObject);
begin
  CalculaParcelas;

end;

procedure TfrmEncerraPedido.btnSalvaClick(Sender: TObject);
var i : Integer;
begin
  dtmGlobal.qryParcelaPedido.close;
  dtmGlobal.qryParcelaPedido.open;
  dtmGlobal.transParcelaPedido.Active:=true;

  for i := 1 to StrToInt(edtNumerosParcelas.Text) do
  begin

    dtmGlobal.qryParcelaPedido.Append;
    dtmGlobal.qryParcelaPedidoCODIGOPARCELA.AsInteger := i;
    dtmGlobal.qryParcelaPedidoFORMAPAGAMENTO.AsString :=edtFormaPagamento.Text;
    dtmGlobal.qryParcelaPedidoNUMEROPEDIDO.AsInteger  :=StrToInt(lblNumeroPedido.Caption);
    dtmGlobal.qryParcelaPedidoCODIGOPEDIDO.AsInteger  :=StrToInt(lblCodigoPedido.Caption);
    dtmGlobal.qryParcelaPedidoDATAVENCIMENTO.AsDateTime:=Now+(i*StrToIntDef(edtIntervaloParcelas.Text,0));
    dtmGlobal.qryParcelaPedidoVALORPARCELA.AsCurrency:=StrToCurr(edtValorParcela.Text);
    dtmGlobal.qryParcelaPedido.Post;
    dtmGlobal.qryParcelaPedido.ApplyUpdates;
    dtmGlobal.transParcelaPedido.CommitRetaining;

  end;
  EncerraPedido;
end;

procedure TfrmEncerraPedido.CalculaParcelas;
var
  fNumeroParcelas, fValorParcela: currency;
begin
  inherited;
  fValorTotalPedido := StrToCurr(lblTotalPedido.Caption);
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
  if fNumeroParcelas > 1 then
  begin
   lblIntervalo.Visible:=true;
   edtIntervaloParcelas.Visible:=true;
   lblDias.Visible:=true;
   edtFormaPagamento.Text:= 'A PRAZO';
   edtIntervaloParcelas.Text:='30';
  end
  else
  begin
   lblIntervalo.Visible:=false;
   edtIntervaloParcelas.Visible:=false;
   lblDias.Visible:=false;
   edtIntervaloParcelas.Text:='';
   edtFormaPagamento.Text:= 'A VISTA';
  end;

end;

procedure TfrmEncerraPedido.EncerraPedido;
begin

  dtmGlobal.qryEncerraPedido.close;
  dtmGlobal.qryEncerraPedido.ParamByName('status').AsString:='FECHADO';
  dtmGlobal.qryEncerraPedido.ParamByName('totalpedido').AsCurrency:=StrToCurr(lblTotalPedido.Caption);
  dtmGlobal.qryEncerraPedido.ParamByName('codpedido').AsInteger:= StrToInt(lblCodigoPedido.Caption);
  dtmGlobal.qryEncerraPedido.ParamByName('numeropedido').AsInteger:=StrToInt(lblNumeroPedido.Caption);
  dtmGlobal.qryEncerraPedido.ExecSQL;
  dtmGlobal.transEncerraPedido.CommitRetaining;
end;

end.

