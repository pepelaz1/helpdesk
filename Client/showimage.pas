unit showimage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, FreeBitmap, FreeImage, StdCtrls;

type
  TImageForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormResize(Sender: TObject);
  private
    FX, FY, FWidth, FHeight : integer;
    FBmpSource : TBitmap;
    FOldPos : TPoint;
    FLBtnPress : boolean;
    FLastFileName : String;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;

  public
    function LoadImage( strImage : string ) : boolean;
    function GetLastFileName : string;

  end;

var
  ImageForm: TImageForm;

implementation

{$R *.dfm}

procedure TImageForm.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin

end;

function TImageForm.LoadImage( strImage : string ) : boolean;
var  bmp : TFreeWinBitmap;
     PTempFilePath : PChar;

begin

  Caption := 'Снимок - ' + strImage;
  FLastFileName := strImage;
  bmp := TFreeWinBitmap.Create;
  if ( bmp.Load( strImage ) ) then
  begin

      // Сохраняем как JPEG
      PTempFilePath:= StrAlloc(255);
      GetTempPath(255, PTempFilePath);
      FLastFileName :=  PTempFilePath + 'tmp.jpg';
      bmp.Save(FLastFileName);
      StrDispose(PTempFilePath);


      FBmpSource.Free;
      FBmpSource := TBitmap.Create;

      FBmpSource.Width := bmp.GetWidth;
      FBmpSource.Height := bmp.GetHeight;
      FBmpSource.Handle := bmp.CopyToBitmapH;


      FX := 0;
      FY := 0;
      FWidth := FBmpSource.Width;
      FHeight := FBmpSource.Height;

      Constraints.MaxWidth := FWidth;
      Constraints.MaxHeight := FHeight;

  end
  else
  begin
    Application.MessageBox('Невозможно загрузить изображение', 'Ошибка');
    Result := false;
    exit;
  end;
  bmp.Free;


  FLBtnPress := false;
  FOldPos.x := 0;
  FOldPos.y := 0;

  Result := true;
end;


function TImageForm.GetLastFileName : string;
begin
  Result := FLastFileName;
end;

procedure TImageForm.FormCreate(Sender: TObject);
begin
  FBmpSource := TBitmap.Create;
  FLastFileName := '';
end;



procedure TImageForm.FormPaint(Sender: TObject);
var r,cr : TRect;
begin
   cr := ClientRect;

   r.Left := FX;
   r.Top := FY;
   r.Right := FX + cr.Right;
   r.Bottom := FY +  cr.Bottom;
   Canvas.CopyRect(cr, FBmpSource.Canvas, r);
end;

procedure TImageForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if (ssLeft in Shift)  then
  begin


    FOldPos.x := x;
    FOldPos.y := y;

    FLBtnPress := True;
   end;
end;

procedure TImageForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var l,t : integer;
    r : TRect;
begin
if (ssLeft in Shift) and FLBtnPress then
  begin
      r := ClientRect;

      l := x - FOldPos.x;
      t := y - FOldPos.y;

      FOldPos.x := x;
      FOldPos.y := y;
      
      FX := FX - l;
      FY := FY - t;
      if (FX < 0) then FX := 0;
      if (FY < 0) then FY := 0;
      if (FX + r.Right > FWidth) then FX := FWidth - r.Right ;
      if (FY + r.Bottom > FHeight) then FY := FHeight - r.Bottom;

      Repaint;
   end;
end;

procedure TImageForm.FormResize(Sender: TObject);
begin
   FX := 0;
   FY := 0;
   Repaint;
end;

end.
