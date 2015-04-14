unit DBGrid1;

interface

uses
  SysUtils, Classes, Controls, Grids, DBGrids;

type
  TDBGrid1 = class(TDBGrid)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Data Controls', [TDBGrid1]);
end;

end.
