unit uDtmGlobal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, db, FileUtil;

type

  { TdtmGlobal }

  TdtmGlobal = class(TDataModule)
    conexao: TIBConnection;
    qryProduto: TSQLQuery;
    qryProdutoCODPRODUTO: TLongintField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoSITUACAO: TStringField;
    transConexao: TSQLTransaction;
    transProduto: TSQLTransaction;
  private

  public

  end;

var
  dtmGlobal: TdtmGlobal;

implementation

{$R *.lfm}

{ TdtmGlobal }

end.

