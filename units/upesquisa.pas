unit uPesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBGrids;

type

  { TfrmPesquisa }

  TfrmPesquisa = class(TForm)
    btnPesquisa: TImage;
    cbCampos: TComboBox;
    cbFiltro: TComboBox;
    dtsPesquisa: TDataSource;
    DBGrid1: TDBGrid;
    edtBusca: TEdit;
    edtRetorno: TEdit;
    Panel1: TPanel;
    qrySql: TSQLQuery;
    transSQl: TSQLTransaction;
    procedure btnPesquisaClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
   cCampos, cCampoRetorno, cTabela: string;
  public
    constructor Create(AOwner: TComponent; par_lstCampos: Array of string;
      par_cTabela, par_cCampoResult: string);
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.lfm}

{ TfrmPesquisa }

procedure TfrmPesquisa.btnPesquisaClick(Sender: TObject);
begin
  transSQl.Active:=false;
  if qrySql.Active then
     qrySql.Close;
  with qrySql.SQL do
      begin
        Clear;
        add('Select '+cCampos);
        add('from '+cTabela);
        add('where '+trim(cbCAMPOS.Text)+' like :cParametro');
      end;
  if cbFiltro.Text = 'parte' then
     qrySql.ParamByName('cParametro').AsString := '%'+trim(edtBusca.Text)+'%'
  else if cbFiltro.Text = 'inicio' then
     qrySql.ParamByName('cParametro').AsString := trim(edtBusca.Text)+'%'
  else if cbFiltro.Text = 'igual' then
     qrySql.ParamByName('cParametro').AsString := trim(edtBusca.Text) ;
  qrySql.Open;
end;

procedure TfrmPesquisa.DBGrid1CellClick(Column: TColumn);
begin
  edtRetorno.Clear;
  edtRetorno.Text := qrySql.FieldByName(cCampoRetorno).AsVariant;
  qrySql.Close;
  frmPesquisa.ModalResult := mrYes;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  edtBusca.SetFocus;
end;

constructor TfrmPesquisa.Create(AOwner: TComponent; par_lstCampos: array of string;
  par_cTabela, par_cCampoResult: string);
var
  n: Integer;
begin
  inherited Create(AOwner);
  // Conexao.Open;
  qrySql.Transaction:= transSQl;
  qrySql.Close;
  transSQl.Active:=false;
  cCampoRetorno := par_cCampoResult;
  cCampos := '';
  cbCampos.Clear;
  cTabela := par_cTabela;
  for n := 0 to Length(par_lstCampos) - 1 do
  begin
    cbCampos.Items.Add(par_lstCampos[n]);
    if n = 0 then
      cCampos := par_lstCampos[n]
    else
      cCampos := cCampos + ',' + par_lstCampos[n];
  end;
  cbCampos.ItemIndex := 1;
  if qrySql.Active then
    qrySql.Close;
  with qrySql.SQL do
  begin
    Clear;
    Add('Select ' + cCampos);
    Add('from ' + cTabela)
  end;
  qrySql.Open;

end;

end.

