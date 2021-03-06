unit SxkDBGrid;

interface

uses
  SysUtils, Classes, Controls, Grids, DBGrids, Messages, windows;

type
  TSxkDBGrid = class(TDBGrid)
  private

  protected
   function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
   function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Data Controls', [TSxkDBGrid]);
end;


function TSxkDBGrid.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  DataSource.DataSet.RecNo :=  DataSource.DataSet.RecNo + 1;
  Result := true;
end;

function TSxkDBGrid.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  DataSource.DataSet.RecNo :=  DataSource.DataSet.RecNo - 1;
  Result := true;
end;


end.
