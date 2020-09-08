program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, uPrincipal, uFormPadrao, uDtmGlobal, uCadProduto,
  uPesquisa, uLanPedidoVenda, uFinalizarPedido, uEncerraPedido
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal );
  Application.CreateForm(TfrmPadrao, frmPadrao);
  Application.CreateForm(TdtmGlobal, dtmGlobal);
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  Application.CreateForm(TfrmLanPedidoVenda, frmLanPedidoVenda);
  Application.CreateForm(TfrmFinalizaPedidoVenda, frmFinalizaPedidoVenda);
  Application.CreateForm(TfrmEncerraPedido, frmEncerraPedido);
  Application.Run;
end.

