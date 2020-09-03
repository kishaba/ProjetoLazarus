unit uDtmGlobal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, DB, FileUtil;

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
    qryPedidoCODIGOCLIENTE: TLongintField;
    qryPedidoCODPEDIDO: TLongintField;
    qryPedidoDATAEMISSAO: TDateField;
    qryPedidoNUMEROPEDIDO: TLongintField;
    qryPedidoREFERENCIA: TStringField;
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
    transProduto: TSQLTransaction;
    transPedido: TSQLTransaction;
  private

  public

  end;

var
  dtmGlobal: TdtmGlobal;

implementation

{$R *.lfm}

{ TdtmGlobal }

end.

