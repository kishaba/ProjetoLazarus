unit uCadProduto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ActnList, DbCtrls, DBGrids, uFormPadrao, db,LCLType;

type

  { TfrmCadProduto }

  TfrmCadProduto = class(TfrmPadrao)
    edtCodigo: TDBEdit;
    edtDescricao: TDBEdit;
    edtlocalizar: TEdit;
    grdConsulta: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure actCancelarExecute(Sender: TObject);
    procedure actEditaExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnEditaClick(Sender: TObject);
    procedure btnExcluiClick(Sender: TObject);
    procedure btnIncluiClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure edtDescricaoKeyPress(Sender: TObject; var Key: char);
    procedure edtlocalizarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

uses
  uDtmGlobal;

{$R *.lfm}

{ TfrmCadProduto }

procedure TfrmCadProduto.edtlocalizarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {if key = VK_RETURN then
  begin
   grdConsulta.Enabled := true;
    grdConsulta.SetFocus;
  end
  else
  if Length(edtlocalizar.Text)>0 then
  begin
   dsPadrao.DataSet.Open;
   dsPadrao.DataSet.Locate('DESCRICAO', edtlocalizar.Text,
       [loPartialKey,loCaseInsensitive]);
  end}

  if key = VK_RETURN then
  begin
    grdConsulta.Enabled := true;
    grdConsulta.SetFocus;
  end
  else
  if Length(edtlocalizar.Text)>0 then
  begin
    dtmGlobal.qryProduto.FilterOptions:=[foCaseInsensitive];
    dtmGlobal.qryProduto.Filter:='descricao = "*'+edtlocalizar.Text+'*"';
    dtmGlobal.qryProduto.Filtered:=True;
  end
  else dtmGlobal.qryProduto.Filtered:=false;
end;

procedure TfrmCadProduto.btnIncluiClick(Sender: TObject);
begin

  actIncluir.Execute;

end;

procedure TfrmCadProduto.btnSalvaClick(Sender: TObject);
begin
  //ShowMessage(edtDescricao.Text);
  actSalvar.Execute;
end;

procedure TfrmCadProduto.edtDescricaoKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if key = #13 then
  begin
   actSalvar.Execute;
  end;


end;

procedure TfrmCadProduto.btnEditaClick(Sender: TObject);
begin
  actEdita.Execute;
end;

procedure TfrmCadProduto.btnCancelaClick(Sender: TObject);
begin
  actCancelar.Execute;
end;

procedure TfrmCadProduto.actIncluirExecute(Sender: TObject);
begin
   edtCodigo.Text := '';
   edtDescricao.Text := '';
   grdConsulta.Enabled := false;
   inherited;
   edtDescricao.SetFocus;
end;

procedure TfrmCadProduto.actSalvarExecute(Sender: TObject);
begin
  edtlocalizar.Text:=edtDescricao.Text;
  inherited;
  grdConsulta.Enabled := true;
end;

procedure TfrmCadProduto.actEditaExecute(Sender: TObject);
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadProduto.actCancelarExecute(Sender: TObject);
begin
  inherited;
  grdConsulta.Enabled := true;
end;

procedure TfrmCadProduto.btnExcluiClick(Sender: TObject);
begin
  actExcluir.Execute;
end;


procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  dsPadrao.DataSet.Open;
  edtlocalizar.SetFocus;
end;


end.

