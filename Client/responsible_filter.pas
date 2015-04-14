unit responsible_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,settings;

type
  TResponsibleFormFilter = class(TForm)
    FilterGroupBox: TGroupBox;
    FieldLabel: TLabel;
    OperationLabel: TLabel;
    ValueLabel: TLabel;
    ClassTitleEdit: TEdit;
    ClassComboBox: TComboBox;
    ClassValueEdit: TEdit;
    ResponsibleTitleEdit: TEdit;
    ResponsibleComboBox: TComboBox;
    ResponsibleValueEdit: TEdit;
    Edit1: TEdit;
    ResetButton: TButton;
    FilterButton: TButton;
    CancelButton: TButton;
    procedure ResetButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClassComboBoxExit(Sender: TObject);
    procedure ResponsibleComboBoxExit(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     m_bFiltered : boolean;

     // Чтение значений контролей из GSettings
     procedure LoadControls;

     // Сохранение значение контролей в GSettings
     procedure SaveControls;
  public

     // Применение фильтра
     procedure Apply;

     property Filtered : boolean read m_bFiltered write m_bFiltered;
  end;

var
  ResponsibleFormFilter: TResponsibleFormFilter;

implementation

uses global;

{$R *.dfm}

procedure TResponsibleFormFilter.ResetButtonClick(Sender: TObject);
begin
  Module.ResetFilter( self );
end;

procedure TResponsibleFormFilter.FormShow(Sender: TObject);
begin
  Module.PaintFilter( self );
end;


procedure TResponsibleFormFilter.LoadControls;
begin
  ClassValueEdit.Text := GSettings.ClassIncident2;
  ClassComboBox.ItemIndex := GSettings.ClassIncident2Op;
  ResponsibleValueEdit.Text := GSettings.Responsible2;
  ResponsibleComboBox.ItemIndex := GSettings.Responsible2Op;
end;


procedure TResponsibleFormFilter.SaveControls;
begin
  GSettings.ClassIncident2 := ClassValueEdit.Text;
  GSettings.ClassIncident2Op := ClassComboBox.ItemIndex;
  GSettings.Responsible2 := ResponsibleValueEdit.Text;
  GSettings.Responsible2Op := ResponsibleComboBox.ItemIndex;
end;


procedure TResponsibleFormFilter.Apply;
var strNewQuery,strOldQuery : string;
begin
   try
     strNewQuery := 'select t1.name_class, t2.worker, t3.num_class, t3.id_work from personnel_view t2, classifier_view_total_used t1, responsible t3 ' +
                  'where t3.id_work = t2.id_work and t3.num_class = t1.num_class ';

     strOldQuery := strNewQuery +  ' order by t1.name_class';

     // ИТ-услуга
     if ClassValueEdit.Text <> '' then
     begin
        if ClassComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t1.name_class ' + ClassComboBox.Text  + QuotedStr(ClassValueEdit.Text)
        else if ClassComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t1.name_class),lower(' + QuotedStr(ClassValueEdit.Text) + ')) <> 0';
     end;

     // Ответственный
     if ResponsibleValueEdit.Text <> '' then
     begin
        if ResponsibleComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t2.worker ' + ResponsibleComboBox.Text  + QuotedStr(ResponsibleValueEdit.Text)
        else if ResponsibleComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t2.worker),lower(' + QuotedStr(ResponsibleValueEdit.Text) + ')) <> 0';
     end;



     strNewQuery := strNewQuery +  ' order by t1.name_class';
     Filtered := strNewQuery <> strOldQuery;

     Module.ResponsibleDataSet.SQL.Text := strNewQuery;
     Module.ResponsibleDataSet.Filtered := false;
     Module.ResponsibleDataSet.Refresh;

   finally
   end;
end;

procedure TResponsibleFormFilter.ClassComboBoxExit(Sender: TObject);
begin
  ClassComboBox.Repaint;
end;

procedure TResponsibleFormFilter.ResponsibleComboBoxExit(Sender: TObject);
begin
 ResponsibleComboBox.Repaint;
end;

procedure TResponsibleFormFilter.FilterButtonClick(Sender: TObject);
begin
  Apply;
  SaveControls;
  Close;
end;

procedure TResponsibleFormFilter.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TResponsibleFormFilter.FormCreate(Sender: TObject);
begin
  LoadControls;
end;

end.
