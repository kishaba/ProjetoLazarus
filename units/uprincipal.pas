unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image4: TImage;
    Image5: TImage;
    Image8: TImage;
    Panel2: TPanel;
    Panel3: TPanel;
    pnpCada: TPanel;
    pnpCadastros: TPanel;
    pnpCadProdutos: TPanel;
    pnpPedidoVenda: TPanel;
    pnpPrincipal: TPanel;
    pnpSair: TPanel;
    pnpTitulo: TPanel;
    pnpVoltar: TPanel;
    procedure pnpCadaClick(Sender: TObject);
    procedure pnpCadProdutosClick(Sender: TObject);
    procedure pnpPedidoVendaClick(Sender: TObject);
    procedure pnpSairClick(Sender: TObject);
    procedure pnpVoltarClick(Sender: TObject);
  private
    procedure selecionaMenu(nMenu: integer);
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uCadProduto, uLanPedidoVenda;

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.pnpCadaClick(Sender: TObject);
begin
  selecionaMenu(2);
end;

procedure TfrmPrincipal.pnpCadProdutosClick(Sender: TObject);
begin
  try
    frmCadProduto := TfrmCadProduto.Create(self);
    frmCadProduto.ShowModal
  finally
    FreeAndNil(frmCadProduto);
  end;
end;

procedure TfrmPrincipal.pnpPedidoVendaClick(Sender: TObject);
begin
  try
    frmLanPedidoVenda := TfrmLanPedidoVenda.Create(self);
    frmLanPedidoVenda.edtTipoOperacao.Text := 'S';
    frmLanPedidoVenda.ShowModal
  finally
    FreeAndNil(frmLanPedidoVenda);
  end;
end;

procedure TfrmPrincipal.pnpSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.pnpVoltarClick(Sender: TObject);
begin
  selecionaMenu(1);
end;

procedure TfrmPrincipal.selecionaMenu(nMenu: integer);
begin
  if nMenu = 0 then     //esconde menu
  begin
    pnpPrincipal.Visible := False;
    pnpCadastros.Visible := False;
  end
  else if nMenu = 1 then     //mostra menu principal
  begin
    pnpPrincipal.Visible := True;
    pnpCadastros.Visible := False;
  end
  else if nMenu = 2 then //mostra menu cadastros
  begin
    pnpPrincipal.Visible := False;
    pnpCadastros.Visible := True;
  end;
end;


end.
unit uPrincipal;
{$mode objfpc}{$H+}interface
uses
Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;
type
{ TfrmPrincipal }  TfrmPrincipal = class(TForm)
Image1: TImage;
Image2: TImage;
Image3: TImage;
Image4: TImage;
Image5: TImage;
Image7: TImage;
Image8: TImage;
Panel2: TPanel;
Panel3: TPanel;
pnpCada: TPanel;
pnpCadastros: TPanel;
pnpCadClientes: TPanel;
pnpCadProdutos: TPanel;
pnpPedidoCompra: TPanel;
pnpPedidoVenda: TPanel;
pnpPrincipal: TPanel;
pnpSair: TPanel;
pnpTitulo: TPanel;
pnpVoltar: TPanel;
procedure pnpCadaClick(Sender: TObject);
procedure pnpSairClick(Sender: TObject);
procedure pnpVoltarClick(Sender: TObject);
private
procedure selecionaMenu(nMenu: integer);
public
end;
var
frmPrincipal: TfrmPrincipal;
implementation
{$R *.lfm}{ TfrmPrincipal }procedure TfrmPrincipal.pnpCadaClick(Sender: TObject);
begin
selecionaMenu(2);
end;
procedure TfrmPrincipal.pnpSairClick(Sender: TObject);
begin
Application.Terminate;
end;
procedure TfrmPrincipal.pnpVoltarClick(Sender: TObject);
begin
selecionaMenu(1);
end;
procedure TfrmPrincipal.selecionaMenu(nMenu: integer);
begin
if nMenu = 0 then     //esconde menu  begin
pnpPrincipal.Visible := False;
pnpCadastros.Visible := False;
end
else if nMenu = 1 then     //mostra menu principal  begin
pnpPrincipal.Visible := True;
pnpCadastros.Visible := False;
end
else if nMenu = 2 then //mostra menu cadastros  begin
pnpPrincipal.Visible := False;
pnpCadastros.Visible := True;
end;
end;
end.

























