unit fast_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, oracledata, dbgrids;

type
  TFastFilterForm = class(TForm)
    FilterStatic: TStaticText;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    m_Grid : TDBGrid;
    m_Form : TForm;
    m_DS : TOracleDataSet;
    m_FilterString : string;

    m_bFiltered : boolean;

    procedure Apply;
  public

    procedure SetFilter( key : char; form : TForm;
      ds : TOracleDataSet; grid : TDBGrid; var ff : boolean);

    property Filtered : boolean read m_bFiltered write m_bFiltered;
  end;

var
  FastFilterForm: TFastFilterForm;

implementation

uses main, initiator_selection, element_selection, class_selection,
  responsible, global;

{$R *.dfm}





procedure TFastFilterForm.SetFilter( key : char; form : TForm;
      ds : TOracleDataSet; grid : TDBGrid; var ff : boolean);
begin
 m_Grid := grid;
 m_Form := form;
 m_DS := ds;

 m_FilterString := key;
 FilterStatic.Caption := m_FilterString;
 FilterStatic.Color := Module.EvenColor;
 Apply;
end;

procedure TFastFilterForm.Apply;
begin
  m_DS.Filter :=  m_Grid.Columns[m_Grid.SelectedIndex].FieldName + '=' + QuotedStr(FilterStatic.Caption +'*');
  m_DS.Filtered := true;

  if FilterStatic.Caption = '' then Filtered := false else Filtered := true;
end;

procedure TFastFilterForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #8 then
   m_FilterString := copy(FilterStatic.Caption,1,length(FilterStatic.Caption)-1)
  else if (key = #27) or (key = #13) then
  begin
    Close;
    exit;
  end
  else

  m_FilterString := m_FilterString + key;
  FilterStatic.Caption := m_FilterString;
  Apply;
end;

end.
