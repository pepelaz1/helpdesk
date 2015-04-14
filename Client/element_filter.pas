unit element_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, settings;

type
  TElementFormFilter = class(TForm)
    FilterGroupBox: TGroupBox;
    FieldLabel: TLabel;
    OperationLabel: TLabel;
    ValueLabel: TLabel;
    ElementTitleEdit: TEdit;
    ElementComboBox: TComboBox;
    ElementValueEdit: TEdit;
    RoomTitleEdit: TEdit;
    RoomComboBox: TComboBox;
    RoomValueEdit: TEdit;
    PhoneTitleEdit: TEdit;
    PhoneComboBox: TComboBox;
    PhoneValueEdit: TEdit;
    Edit1: TEdit;
    ResetButton: TButton;
    FilterButton: TButton;
    CancelButton: TButton;
    procedure ResetButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ElementComboBoxExit(Sender: TObject);
    procedure RoomComboBoxExit(Sender: TObject);
    procedure PhoneComboBoxExit(Sender: TObject);
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
  ElementFormFilter: TElementFormFilter;

implementation

uses global;

{$R *.dfm}

procedure TElementFormFilter.ResetButtonClick(Sender: TObject);
begin
  Module.ResetFilter( self );
end;

procedure TElementFormFilter.FormShow(Sender: TObject);
begin
  Module.PaintFilter( self );
end;

procedure TElementFormFilter.FilterButtonClick(Sender: TObject);
begin
  Apply;
  SaveControls;
  Close;
end;

procedure TElementFormFilter.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TElementFormFilter.LoadControls;
begin
  ElementValueEdit.Text := GSettings.Element2;
  ElementComboBox.ItemIndex := GSettings.Element2Op;
  RoomValueEdit.Text := GSettings.Room;
  RoomComboBox.ItemIndex := GSettings.RoomOp;
  PhoneValueEdit.Text := GSettings.Phone2;
  PhoneComboBox.ItemIndex := GSettings.Phone2Op;
end;

procedure TElementFormFilter.SaveControls;
begin
 GSettings.Element2 := ElementValueEdit.Text;
 GSettings.Element2Op := ElementComboBox.ItemIndex;
 GSettings.Room := RoomValueEdit.Text;
 GSettings.RoomOp := RoomComboBox.ItemIndex;
 GSettings.Phone2 :=PhoneValueEdit.Text;
 GSettings.Phone2Op := PhoneComboBox.ItemIndex;
end;

procedure TElementFormFilter.Apply;
var strNewQuery,strOldQuery : string;
begin
   try
     strNewQuery := 'select  * from infrastructure_view t where 1=1 ';
//     strOldQuery := strNewQuery +  ' order by t.name_device';

     // Элемент инфраструктуры
     if ElementValueEdit.Text <> '' then
     begin
        if ElementComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.name_dev ' + ElementComboBox.Text  + QuotedStr(ElementValueEdit.Text)
        else if ElementComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t.name_dev),lower(' + QuotedStr(ElementValueEdit.Text) + ')) <> 0';
     end;

     // Помещение
     if RoomValueEdit.Text <> '' then
     begin
        if RoomComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.room ' + RoomComboBox.Text  + QuotedStr(RoomValueEdit.Text)
        else if RoomComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t.room),lower(' + QuotedStr(RoomValueEdit.Text) + ')) <> 0';
     end;

     // Телефон
     if PhoneValueEdit.Text <> '' then
     begin
        if PhoneComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.phone ' + PhoneComboBox.Text  + QuotedStr(PhoneValueEdit.Text)
        else if PhoneComboBox.Text = 'включает' then
          strNewQuery := strNewQuery + ' and instr(lower(t.phone),lower(' + QuotedStr(PhoneValueEdit.Text) + ')) <> 0';
     end;

    // strNewQuery := strNewQuery +  ' order by t.name_device';
     Filtered := strNewQuery <> strOldQuery;

     Module.ElementDataSet.SQL.Text := strNewQuery;
     Module.ElementDataSet.Filtered := false;
     Module.ElementDataSet.Refresh;

   finally
   end;
end;

procedure TElementFormFilter.ElementComboBoxExit(Sender: TObject);
begin
  ElementComboBox.Repaint;
end;

procedure TElementFormFilter.RoomComboBoxExit(Sender: TObject);
begin
  RoomComboBox.Repaint;
end;

procedure TElementFormFilter.PhoneComboBoxExit(Sender: TObject);
begin
 PhoneComboBox.Repaint;
end;

procedure TElementFormFilter.FormCreate(Sender: TObject);
begin
 LoadControls;
end;

end.
