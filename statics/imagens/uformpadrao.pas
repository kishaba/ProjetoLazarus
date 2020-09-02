unit uFormPadrao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ActnList;

type

  { TfrmPadrao }

  TfrmPadrao = class(TForm)
    actCancelar: TAction;
    actEdita: TAction;
    actExcluir: TAction;
    actIncluir: TAction;
    ActionList1: TActionList;
    actSalvar: TAction;
    btnCancela: TImage;
    btnEdita: TImage;
    btnExclui: TImage;
    btnInclui: TImage;
    btnSalva: TImage;
    dsPadrao: TDataSource;
    lblF2: TLabel;
    lblF3: TLabel;
    lblF4: TLabel;
    lblF5: TLabel;
    lblF6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure actEditaExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
  private
    procedure ControlaBotoes;
    procedure HabilitaEdicao(status:boolean);
  public

  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.lfm}

{ TfrmPadrao }

procedure TfrmPadrao.actIncluirExecute(Sender: TObject);
begin
  dsPadrao.DataSet.Open;
  dsPadrao.DataSet.INSERT;
  ControlaBotoes;
  HabilitaEdicao(true);
end;

procedure TfrmPadrao.actEditaExecute(Sender: TObject);
begin
  dsPadrao.DataSet.Open;
  dsPadrao.DataSet.Edit;
  ControlaBotoes;
  HabilitaEdicao(true);
end;

procedure TfrmPadrao.ControlaBotoes;
begin
  btnInclui.Visible  := not(dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  lblF2.Visible  := not(dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  btnEdita.Visible   := not(dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  lblF3.Visible   := not(dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  btnExclui.Visible  := not(dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  lblF4.Visible  := not(dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  btnSalva.Visible   := (dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  lblF5.Visible   := (dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  BtnCancela.Visible := (dsPadrao.DataSet.State in [dsInsert,dsEdit]);
  lblF6.Visible := (dsPadrao.DataSet.State in [dsInsert,dsEdit]);
end;

procedure TfrmPadrao.HabilitaEdicao(status: boolean);
var i: integer;
begin
  for I := 0 to ComponentCount-1 do
  begin
    if Components[i] is TDBEdit then
    begin
      TDBEdit(Components[i]).Enabled    := status;
      TDBEdit(Components[i]).Color      := clWhite;
      TDBEdit(Components[i]).Font.Color := clBlack;
    end
    else if Components[i] is TDBComboBox then
    begin
      TDBComboBox(Components[i]).Enabled    := status;
      TDBComboBox(Components[i]).Color      := clWhite;
      TDBComboBox(Components[i]).Font.Color := clBlack;
    end
    else if Components[i] is TDBLookupComboBox then
    begin
      TDBLookupComboBox(Components[i]).Enabled    := status;
      TDBLookupComboBox(Components[i]).Color      := clWhite;
      TDBLookupComboBox(Components[i]).Font.Color := clBlack;
    end;
  end;
end;

end.

