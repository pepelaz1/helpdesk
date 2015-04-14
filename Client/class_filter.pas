unit class_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, settings;

type
  TClassFormFilter = class(TForm)
    FilterGroupBox: TGroupBox;
    FieldLabel: TLabel;
    OperationLabel: TLabel;
    ValueLabel: TLabel;
    ClassTitleEdit: TEdit;
    ClassComboBox: TComboBox;
    ClassValueEdit: TEdit;
    ClassDescTitleEdit: TEdit;
    ClassDescComboBox: TComboBox;
    ClassDescValueEdit: TEdit;
    CategoryTitleEdit: TEdit;
    CategoryComboBox: TComboBox;
    CategoryValueEdit: TEdit;
    Edit1: TEdit;
    ResetButton: TButton;
    FilterButton: TButton;
    CancelButton: TButton;
    TypeTitleEdit: TEdit;
    TypeComboBox: TComboBox;
    TypeValueEdit: TEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFiltered : boolean;

    procedure LoadControls;
    procedure SaveControls;
  public
    property Filtered : boolean read FFiltered write FFiltered;
    procedure Apply;
  end;

var
  ClassFormFilter: TClassFormFilter;

implementation

uses global, class_selection;


{$R *.dfm}

procedure TClassFormFilter.Apply;
var strNewQuery,strOldQuery, LSortOrder : string;
begin
   try
     strNewQuery := 'select * from classifier_view_total_used t where 1=1 ';
     strOldQuery := strNewQuery;
  //   strOldQuery := strNewQuery +  ' order by t.name_class';

     // Тип класса
     if TypeValueEdit.Text <> '' then
     begin
        if TypeComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.name_type ' + TypeComboBox.Text  + QuotedStr(TypeValueEdit.Text)
        else if TypeComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t.name_type),lower(' + QuotedStr(TypeValueEdit.Text) + ')) <> 0';
     end;

     // Класс инцидента
     if ClassValueEdit.Text <> '' then
     begin
        if ClassComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.name_class ' + ClassComboBox.Text  + QuotedStr(ClassValueEdit.Text)
        else if ClassComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t.name_class),lower(' + QuotedStr(ClassValueEdit.Text) + ')) <> 0';
     end;

     // Описание
     if ClassDescValueEdit.Text <> '' then
     begin
        if ClassDescComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.description ' + ClassDescComboBox.Text  + QuotedStr(ClassDescValueEdit.Text)
        else if ClassDescComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t.description),lower(' + QuotedStr(ClassDescValueEdit.Text) + ')) <> 0';
     end;

     // Категория
     if CategoryValueEdit.Text <> '' then
     begin
        if CategoryComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.category ' + CategoryComboBox.Text  + QuotedStr(CategoryValueEdit.Text)
        else if CategoryComboBox.Text = 'включает' then
          strNewQuery := strNewQuery +
           ' and instr(lower(t.category),lower(' + QuotedStr(CategoryValueEdit.Text) + ')) <> 0';
     end;


     // Сортировка
     if (GSettings.ClassSortedBy <> '') then
     begin

       if (GSettings.ClassSortOrder = 1 ) then LSortOrder := ' desc';
       GSettings.ClassSortOrder := 1 - GSettings.ClassSortOrder;

       if ( GSettings.ClassSortedBy = 'NAME_TYPE' ) then
          strNewQuery := strNewQuery +  ' order by t.name_type' + LSortOrder
       else if  ( GSettings.ClassSortedBy = 'NAME_CLASS' ) then
          strNewQuery := strNewQuery +  ' order by t.name_class' + LSortOrder
       else if ( GSettings.ClassSortedBy = 'DESCRIPTION' ) then
          strNewQuery := strNewQuery +  ' order by t.description' + LSortOrder
       else if (GSettings.ClassSortedBy = 'CATEGORY') then
          strNewQuery := strNewQuery +  ' order by t.category' + LSortOrder;
     end;


     Filtered := strNewQuery <> strOldQuery;

     Module.ClassDataSet2.SQL.Text := strNewQuery;
     Module.ClassDataSet2.Filtered := false;
     Module.ClassDataSet2.Refresh;

   finally
   end;
end;

procedure TClassFormFilter.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TClassFormFilter.ResetButtonClick(Sender: TObject);
begin
  Module.ResetFilter( self);
end;

procedure TClassFormFilter.FilterButtonClick(Sender: TObject);
begin
  Apply;
  SaveControls;
  Close;
end;

procedure TClassFormFilter.FormCreate(Sender: TObject);
begin
  LoadControls;
end;

procedure TClassFormFilter.FormShow(Sender: TObject);
begin
 Module.PaintFilter( self );
end;

procedure TClassFormFilter.LoadControls;
begin
  TypeValueEdit.Text := GSettings.TypeClass;
  TypeComboBox.ItemIndex := GSettings.TypeClassOp;
  ClassValueEdit.Text := GSettings.ClassIncident3;
  ClassComboBox.ItemIndex := GSettings.ClassIncident3Op;
  ClassDescValueEdit.Text := GSettings.ClassDesc;
  ClassDescComboBox.ItemIndex := GSettings.ClassDescOp;
  CategoryValueEdit.Text := GSettings.Category;
  CategoryComboBox.ItemIndex := GSettings.CategoryOp;
end;

procedure TClassFormFilter.SaveControls;
begin
  GSettings.TypeClass := TypeValueEdit.Text;
  GSettings.TypeClassOp := TypeComboBox.ItemIndex;
  GSettings.ClassIncident3 := ClassValueEdit.Text;
  GSettings.ClassIncident3Op := ClassComboBox.ItemIndex;
  GSettings.ClassDesc := ClassDescValueEdit.Text;
  GSettings.ClassDescOp := ClassDescComboBox.ItemIndex;
  GSettings.Category := CategoryValueEdit.Text;
  GSettings.CategoryOp := CategoryComboBox.ItemIndex;
end;



end.
