unit uDtmGlobal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, DB, FileUtil, Dialogs;

type

  { TdtmGlobal }

  TdtmGlobal = class(TDataModule)
    conexao: TIBConnection;
    qryBuscaProximoItemPedido: TSQLQuery;
    qryBuscaProximoItemPedidoNOVOITEM: TLargeintField;
    qryConsultaPedido: TSQLQuery;
    qryBuscaProduto: TSQLQuery;
    qryConsultaPedidoCODIGOCLIENTE: TLongintField;
    qryConsultaPedidoCODPEDIDO: TLongintField;
    qryConsultaPedidoDATAEMISSAO: TDateField;
    qryConsultaPedidoNUMEROPEDIDO: TLongintField;
    qryConsultaPedidoREFERENCIA: TStringField;
    qryConsultaPedidoSTATUS: TStringField;
    qryConsultaPedidoTIPOPERACAO: TStringField;
    qryConsultaPedidoTOTALPEDIDO: TBCDField;
    qryBuscaProdutoCODPRODUTO: TLongintField;
    qryBuscaProdutoDESCRICAO: TStringField;
    qryBuscaProdutoSITUACAO: TStringField;
    qryItemPedido: TSQLQuery;
    qryItemPedidoCODPEDIDO: TLongintField;
    qryItemPedidoCODPRODUTO: TLongintField;
    qryItemPedidoDESCRICAO: TStringField;
    qryItemPedidoITEMPEDIDO: TLongintField;
    qryItemPedidoNUMEROPEDIDO: TLongintField;
    qryItemPedidoQUANTIDADE: TBCDField;
    qryItemPedidoVALORTOTALITEM: TBCDField;
    qryItemPedidoVALORUNITARIO: TBCDField;
    qryParcelaPedido: TSQLQuery;
    qryParcelaPedidoCODIGOPARCELA: TLongintField;
    qryParcelaPedidoCODIGOPEDIDO: TLongintField;
    qryParcelaPedidoDATAVENCIMENTO: TDateField;
    qryParcelaPedidoFORMAPAGAMENTO: TStringField;
    qryParcelaPedidoNUMEROPEDIDO: TLongintField;
    qryParcelaPedidoVALORPARCELA: TBCDField;
    qryEncerraPedido: TSQLQuery;
    qryPedidoCODIGOCLIENTE: TLongintField;
    qryPedidoCODPEDIDO: TLongintField;
    qryPedidoDATAEMISSAO: TDateField;
    qryPedidoNUMEROPEDIDO: TLongintField;
    qryPedidoREFERENCIA: TStringField;
    qryPedidoSTATUS: TStringField;
    qryPedidoTIPOPERACAO: TStringField;
    qryPedidoTOTALPEDIDO: TBCDField;
    qryProduto: TSQLQuery;
    qryPedido: TSQLQuery;
    qryProdutoCODPRODUTO: TLongintField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoSITUACAO: TStringField;
    transConexao: TSQLTransaction;
    transConsultaPedido: TSQLTransaction;
    transConsultaProduto: TSQLTransaction;
    transBuscaProximoItem: TSQLTransaction;
    transItemPedido: TSQLTransaction;
    transParcelaPedido: TSQLTransaction;
    transEncerraPedido: TSQLTransaction;
    transProduto: TSQLTransaction;
    transPedido: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryItemPedidoAfterDelete(DataSet: TDataSet);
    procedure qryItemPedidoAfterPost(DataSet: TDataSet);
    procedure qryPedidoAfterDelete(DataSet: TDataSet);
    procedure qryPedidoAfterPost(DataSet: TDataSet);
    procedure qryProdutoAfterPost(DataSet: TDataSet);
  private
    procedure LerConfiguracao;
  public
    sCaminhoBanco: string;
    function ConectaServidor: boolean;

  end;

var
  dtmGlobal: TdtmGlobal;

implementation

{$R *.lfm}

{ TdtmGlobal }

procedure TdtmGlobal.qryItemPedidoAfterPost(DataSet: TDataSet);
begin
  qryItemPedido.ApplyUpdates;
  transItemPedido.CommitRetaining;
end;

procedure TdtmGlobal.DataModuleCreate(Sender: TObject);
begin
  qryProduto.Transaction := transProduto;
  qryPedido.Transaction := transPedido;
  qryItemPedido.Transaction := transItemPedido;
  qryConsultaPedido.Transaction := transConsultaPedido;
  qryBuscaProximoItemPedido.Transaction := transBuscaProximoItem;
  qryBuscaProduto.Transaction := transConsultaProduto;
  qryParcelaPedido.Transaction := transParcelaPedido;
end;

procedure TdtmGlobal.qryItemPedidoAfterDelete(DataSet: TDataSet);
begin
  qryItemPedido.ApplyUpdates;
  transItemPedido.CommitRetaining;
end;

procedure TdtmGlobal.qryPedidoAfterDelete(DataSet: TDataSet);
begin
  qryPedido.ApplyUpdates;
  transPedido.CommitRetaining;
end;

procedure TdtmGlobal.qryPedidoAfterPost(DataSet: TDataSet);
begin
  qryPedido.ApplyUpdates;
  transPedido.CommitRetaining;
end;

procedure TdtmGlobal.qryProdutoAfterPost(DataSet: TDataSet);
begin
  qryProduto.ApplyUpdates;
  transProduto.CommitRetaining;
end;


procedure TdtmGlobal.LerConfiguracao;
var
  arq: TextFile; { declarando a variável "arq" do tipo arquivo texto }
  linha: string;
begin

  // [ 1 ] Associa a variável do programa "arq" ao arquivo externo "tabuada.txt"
  //       na unidade de disco "d"
 { AssignFile(arq, Application.ExeName, '.ini');

  {$I-}// desativa a diretiva de Input
  Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
  {$I+}// ativa a diretiva de Input

  if (IOResult <> 0) // verifica o resultado da operação de abertura
  then
    ShowMessage('Erro na leitura do ini !!!')
  else
  begin
    // [ 11 ] verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
    while (not EOF(arq)) do
    begin
      readln(arq, linha); // [ 6 ] Lê uma linha do arquivo
      sCaminhoBanco := (linha);
    end;

    CloseFile(arq); // [ 8 ] Fecha o arquivo texto aberto
  end;  }
end;


function TdtmGlobal.ConectaServidor: boolean;
begin
  conexao.Connected := False;
  LerConfiguracao;
  conexao.DatabaseName :='H:\GitHub\ProjetoDelphi\PROJETO.FDB';
  try
    conexao.Connected := True;
    Result := True;
  except
    begin
      Result := False;
      ShowMessage('Não foi possível efetuar a conexão do o Banco de Dados em ' +
        conexao.DatabaseName);
    end;
  end;
end;

end.
