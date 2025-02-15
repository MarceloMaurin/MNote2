unit frmnntrainning;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ValEdit, PairSplitter, DBGrids, EditBtn, ExtCtrls, Menus, SynEdit, setproject,
  SynHighlighterPython, SynCompletion, SynHighlighterSQL, myexamplecontrol,
   SQLEditItem, NNTrainning;
   //SynHighlighterJSON
type

  { Tfrmnntrain }

  Tfrmnntrain = class(TForm)
    btCancel: TButton;
    btSave: TButton;
    cbquerytest: TComboBox;
    cbtypenn: TComboBox;
    cbquerytrainning: TComboBox;
    edFilterValue: TEdit;
    edFilterValueTester: TEdit;
    edGroupBy: TEdit;
    edGroupByTester: TEdit;
    edInputCols: TEdit;
    edInputField: TEdit;
    edInputFieldTester: TEdit;
    edInputRef: TEdit;
    edInputRefTester: TEdit;
    edInputRefField: TEdit;
    edInputRefFieldTester: TEdit;
    edInputRefKey: TEdit;
    edInputRefKeyTester: TEdit;
    edNome: TEdit;
    edOutputCols: TEdit;
    edOutputField: TEdit;
    edOutputFieldTester: TEdit;
    fileJSONTester: TFileNameEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    melog: TMemo;
    mesqltrainning: TSynEdit;
    miReload: TMenuItem;
    Panel3: TPanel;
    pnBotton: TPanel;
    pnlog: TPanel;
    pmPython: TPopupMenu;
    Splitter1: TSplitter;
    synJSONTester: TSynEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    meComentario: TMemo;
    mesqltest: TSynEdit;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    SynAutoComplete1: TSynAutoComplete;
    //SynJSONSyn1: TSynJSONSyn;
    synJSONTrainning: TSynEdit;
    synJSONTrainning1: TSynEdit;
    synPython: TSynEdit;
    SynPythonSyn1: TSynPythonSyn;
    SynSQLSyn1: TSynSQLSyn;
    TabSheet1: TTabSheet;
    tsDataTest: TTabSheet;
    tsTrainning: TTabSheet;
    tsRunTest: TTabSheet;
    tsPython: TTabSheet;
    tsOutput: TTabSheet;
    tsInput: TTabSheet;
    tbGroup: TTabSheet;
    tsdados: TTabSheet;
    TabSheet3: TTabSheet;
    procedure btRUNClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btTrainningClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbquerytestChange(Sender: TObject);
    procedure cbquerytrainningChange(Sender: TObject);
    procedure cbtypennChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miReloadClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure synJSONTesterChange(Sender: TObject);
    procedure synPythonChange(Sender: TObject);
  private
    fitem : TNNTrainning;
    procedure reloadPython();


  public
    flgsalvar: boolean;
    procedure Load(item : TNNTrainning);
    function Save():  TNNTrainning;

  end;

var
  frmnntrain: Tfrmnntrain;

implementation

{$R *.lfm}

{ Tfrmnntrain }

procedure Tfrmnntrain.FormCreate(Sender: TObject);
begin
  flgsalvar :=false;
  meComentario.Lines.clear;
  edNome.Text:= '';
  PageControl1.PageIndex:=0;
  cbquerytrainning.Items.text := Fsetproject.SQLEdit_ListName();
  cbquerytest.Items.text := Fsetproject.SQLEdit_ListName();
end;

procedure Tfrmnntrain.miReloadClick(Sender: TObject);
begin
  reloadPython();
end;

procedure Tfrmnntrain.PageControl1Change(Sender: TObject);
begin

end;

procedure Tfrmnntrain.synJSONTesterChange(Sender: TObject);
begin

end;

procedure Tfrmnntrain.synPythonChange(Sender: TObject);
begin

end;

procedure Tfrmnntrain.reloadPython;
begin
  if(cbtypenn.ItemIndex<>-1) then
  begin
    synPython.Lines.LoadFromFile('./models/model0'+inttostr(cbtypenn.ItemIndex)+'.py');
  end;
end;

procedure Tfrmnntrain.Load(item: TNNTrainning);
begin
  fitem := item;

  //Aba 1 - Description
  edNome.Text:= fitem.Nome;
  meComentario.Lines.Text:= fitem.Commentario;


  //Aba 2 - Data Trainning
  cbquerytrainning.Items.Text:= Fsetproject.SQLEdit_ListName();
  cbquerytrainning.ItemIndex:= fsetproject.sqlEditItem_indexof(fitem.SQLTrainning);

  mesqltrainning.Lines.Text:= fitem.SQLTrainning.SQL;

  //Aba 3 - Data Test
  cbquerytest.Items.text := Fsetproject.SQLEdit_ListName();
  cbquerytest.ItemIndex:= fsetproject.sqlEditItem_indexof(fitem.SQLTest);
  mesqltest.Lines.text := fitem.SQLTest.sql;

  //Aba 4 - Neural Network
  cbtypenn.Items.text :=   fitem.ListClasseNNTrainning();
  cbtypenn.ItemIndex :=  integer(fitem.ClassNNTrainning);

  //Aba 5 - Group
  edGroupBy.Text:= fitem.groupby ;

  //Aba 6 - Input
  edInputField.Text := fitem.InputField;
  edInputRef.text := fitem.InputRef;
  edInputRefField.text := fitem.InputRefField;
  edInputRefKey.text := fitem.InputRefKey;
  edInputCols.text := inttostr(fitem.InputCols);


  edInputFieldTester.Text := fitem.InputFieldTester;   //novo
  edInputRefTester.text := fitem.InputRefTester;      //novo
  edInputRefFieldTester.text := fitem.InputRefFieldTester; //novo
  edInputRefKeyTester.text := fitem.InputRefKeyTester;     //novo


  //Aba 7 - Output
  edOutputField.text := fitem.OutputField;
  edOutputCols.text := inttostr(fitem.OutputCols);

  edOutputFieldTester.text := fitem.OutputFieldTester;     //NOVO



  //Aba 8 - Python
  synPython.Text := fitem.Python;
  melog.text := fitem.logtrainning;

  //Aba 9 - JSON Trainning
  synJSONTrainning.text := fitem.jsontrainning;
  edFilterValue.text := fitem.FilterValue;
  edFilterValueTester.text := fitem.FilterValueTester; //NOVO

  //Aba 10 - RUN Test
  fileJSONTester.Text:= fitem.fileJSONTester;
  synJSONTester.text := fitem.JSONTester;

end;

function Tfrmnntrain.Save: TNNTrainning;
begin
   if (flgsalvar) then
   begin
     //fitem := item;

     //Aba 1 - Description
     fitem.Nome := edNome.Text;
     fitem.Commentario :=  meComentario.Lines.Text;


     //Aba 2 - Data Trainning
     fitem.SQLTrainning := Fsetproject.SQLEdit_Indexof(cbquerytrainning.ItemIndex ) ;

     fitem.SQLTrainning.SQL := mesqltrainning.Lines.Text;

     //Aba 3 - Data Test

     fitem.SQLTest := Fsetproject.SQLEdit_Indexof(cbquerytest.ItemIndex) ;
     fitem.SQLTest.sql := mesqltest.Lines.text;

     //Aba 4 - Neural Network

     fitem.ClassNNTrainning := TClasseNNTrainning(cbtypenn.ItemIndex) ;

     //Aba 5 - Group
     fitem.groupby := edGroupBy.Text;

     //Aba 6 - Input
     fitem.InputField := edInputField.Text;
     fitem.InputRef := edInputRef.text;
     fitem.InputRefField := edInputRefField.text;
     fitem.InputRefKey := edInputRefKey.text;
     //fitem.InputCols:= strtoint(edInputCols.text);
     fitem.InputFieldTester := edInputFieldTester.Text;
     fitem.InputRefTester := edInputRefTester.text;
     fitem.InputRefFieldTester := edInputRefFieldTester.text;
     fitem.InputRefKeyTester := edInputRefKeyTester.text;


     //Aba 7 - Output
     fitem.OutputField := edOutputField.text;
     fitem.OutputFieldTester := edOutputFieldTester.text;
     //fitem.OutputCols:= strtoint(edOutputCols.text);



     //Aba 8 - Python
     fitem.Python := synPython.Text;

     //Aba 9 - JSON Trainning
     fitem.jsontrainning := synJSONTrainning.Text;
     fitem.FilterValue:= edFilterValue.Text;
     fitem.FilterValueTester:= edFilterValueTester.Text;

     //Aba 10 - RUN Test
     fitem.fileJSONTester := fileJSONTester.Text;
     fitem.JSONTester := synJSONTester.Text;
   end;
   result := fitem;
end;

procedure Tfrmnntrain.btSaveClick(Sender: TObject);
begin
  flgsalvar:= true;
  close;
end;

procedure Tfrmnntrain.btRUNClick(Sender: TObject);
begin

end;

procedure Tfrmnntrain.btTrainningClick(Sender: TObject);
begin

end;

procedure Tfrmnntrain.Button1Click(Sender: TObject);
begin

end;

procedure Tfrmnntrain.cbquerytestChange(Sender: TObject);
begin
  if(cbquerytest.ItemIndex<> -1) then
  begin
    mesqltest.Lines.Text:=  Fsetproject.SQLEdit_Indexof(cbquerytest.ItemIndex).SQL;
  end;
end;

procedure Tfrmnntrain.cbquerytrainningChange(Sender: TObject);
begin
  if(cbquerytrainning.ItemIndex<> -1) then
  begin
    mesqltrainning.Lines.Text:=  Fsetproject.SQLEdit_Indexof(cbquerytrainning.ItemIndex).SQL;
  end;
end;

procedure Tfrmnntrain.cbtypennChange(Sender: TObject);
begin
     reloadPython();
end;

end.

