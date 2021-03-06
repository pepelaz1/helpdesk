unit reports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, DB, Oracle,
  StrUtils, VirtualTrees, VirtualDBTreeEx, ExtCtrls, frxClass, frxDOAComponents, frxDesgn;

const
  EMPTY_REPORT_ID = 1;

type
  TRepNodeRec = record
    Id: Variant;
    Name: String
  end;

  TReportForm = class(TForm)
    CloseButton: TButton;
    ImageList: TImageList;
    ReportTree: TVirtualDBTreeEx;
    NewButton: TButton;
    StatusBar: TStatusBar;
    Timer: TTimer;
    EditButton: TButton;
    DeleteButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReportTreeDblClick(Sender: TObject);
    procedure ReportTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure NewButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);

  private

    procedure ExecuteReport;
    procedure DesignReport;
    procedure LoadReportForm(AReport: TComponent);
    function GetReportGroupNodeRec: TRepNodeRec;
    function CreateReportAsCopy(ACopyingReportId,
        ADstnReportGroupId: Variant; const AReportName: String): Integer;
    procedure ShowActionHintOnStatusBar(const S: String);
    function LoadReportFromBlob(AReport: TfrxReport; ABlob: TBlobField): Boolean;
    function SaveReportToBlob(AReport: TfrxReport; ABlob: TBlobField): Boolean;

  public
     procedure SaveReport( AReport : TfrxReport );
  end;

var
  ReportForm: TReportForm;

implementation

uses global,user, report_add;

{$R *.dfm}

procedure TReportForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TReportForm.FormShow(Sender: TObject);
begin

  if (GUser.UserRole < HD_ADMIN) then
  begin
    NewButton.Visible := false;
    EditButton.Visible := false;
    DeleteButton.Visible := false;
  end;


  ReportTree.Color := Module.EvenColor;
  ReportTree.DataSource.DataSet.Active := true;
  ReportTree.DBOptions := [dboReadOnly, dboAlwaysStructured, dboParentStructure,
                         dboTrackActive, dboTrackChanges, dboTrackCursor,
                         dboViewAll, dboWriteLevel, dboWriteSecondary];

  ReportTree.ExpandAll;
end;

function TReportForm.LoadReportFromBlob(AReport: TfrxReport; ABlob: TBlobField): Boolean;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    ABlob.SaveToStream(LStream);
    LStream.Position := 0;
    AReport.LoadFromStream(LStream);
  finally
    LStream.Free;
  end;

  Result := True;
end;

function TReportForm.SaveReportToBlob(AReport: TfrxReport; ABlob: TBlobField): Boolean;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    AReport.SaveToStream(LStream);
    ABlob.DataSet.Edit;
    try
      ABlob.LoadFromStream(LStream);
      ABlob.DataSet.Post;
    except
      ABlob.DataSet.Cancel;
      raise;
    end;
  finally
    LStream.Free;
  end;

  Result := True;
end;


procedure TReportForm.LoadReportForm(AReport: TComponent);
begin
  Screen.Cursor := crSQLWait;
  try
    try
      Module.BlobDataSet.Close;
      Module.BlobDataSet.SetVariable('ID', ReportTree.KeyField.Value);
      Module.BlobDataSet.Open;

      if AReport is TfrxReport then
      begin
        LoadReportFromBlob(TfrxReport(AReport), TBlobField(Module.BlobDataSet.FieldByName('SOURCE')));
        TfrxReport(Module.frxReport).FileName := Module.ReportsDataSet.FieldValues['NAME'];
      end
     except
      on E: Exception do
      begin
        if E is EOracleError then
          ShowMessage('Error. ' + E.Message);
        Module.BlobDataSet.Close;
      end

    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TReportForm.ExecuteReport;
begin
  LoadReportForm(Module.frxReport);
  Module.frxReport.ShowReport;
end;

procedure TReportForm.ReportTreeDblClick(Sender: TObject);
begin
  ExecuteReport;
end;

function TReportForm.GetReportGroupNodeRec: TRepNodeRec;
begin
  if (vsHasChildren in ReportTree.FocusedNode.States) or
    (ReportTree.FocusedNode = ReportTree.RootNode)then
  begin
    Result.Id := ReportTree.KeyField.Value;
    Result.Name := VarToStr(ReportTree.ViewField.Value)
  end
  else
  begin
    Result.Id := ReportTree.ParentField.Value;
    Result.Name := VarToStr(ReportTree.NodeText[ReportTree.NodeParent[ReportTree.FocusedNode]]);
  end;
end;

procedure TReportForm.ReportTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  Ghosted := False;
  if vsHasChildren in Node.States then
  begin
    if vsExpanded in Node.States then
      ImageIndex := 1
    else
      ImageIndex := 0;
  end
  else
    ImageIndex := PDBNodeData(ReportTree.GetDBNodeData(Node)).ImgIdx;
end;

procedure TReportForm.NewButtonClick(Sender: TObject);
var
  LReportGroupNodeRec: TRepNodeRec;
  LNewReportID: Integer;
begin
  with Module do
  begin
    LReportGroupNodeRec := GetReportGroupNodeRec;
    ReportAddForm.ShowModal;
    if ( ReportAddForm.ReportName <> '')  then
    begin

      LNewReportID := CreateReportAsCopy(EMPTY_REPORT_ID, LReportGroupNodeRec.Id, ReportAddForm.ReportName);

      ReportTree.DataSource.DataSet.Refresh;
      ReportTree.UpdateTree;
      ReportTree.GoToRec(LNewReportID);

      if LReportGroupNodeRec.Name = '' then
        ShowActionHintOnStatusBar(Format('?????? ????? "%s" ??? ??????', [ReportAddForm.ReportName]))
      else
        ShowActionHintOnStatusBar(Format('?????? ????? "%s" ? ?????? "%s"', [ReportAddForm.ReportName, LReportGroupNodeRec.Name]));
     end; // if inputquery
  end; // with
  ReportTree.SetFocus;
end;

procedure TReportForm.EditButtonClick(Sender: TObject);
begin
   DesignReport;
end;

procedure TReportForm.DesignReport;
begin
  LoadReportForm(Module.frxReport);
  Module.frxReport.DesignReport;
end;


function TReportForm.CreateReportAsCopy(ACopyingReportId,
  ADstnReportGroupId: Variant; const AReportName: String): Integer;
begin
  with Module.QryCreateReportAsCopy do
  begin
    SetVariable('V_ID', ACopyingReportId);
    SetVariable('V_NAME', AReportName);
    SetVariable('V_REPORTGROUPS', ADstnReportGroupId);
    Execute;

    Result := GetVariable('V_NEW_ID');
  end;
  Module.OraSession.Commit;
end;

procedure TReportForm.ShowActionHintOnStatusBar(const S: String);
begin
  Timer.Enabled := False;
  StatusBar.Panels[0].Text := S;
  Timer.Enabled := True;
end;


procedure TReportForm.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  StatusBar.Panels[0].Text := '';
end;


procedure TReportForm.SaveReport( AReport : TfrxReport )  ;
var
  LReportID: integer;
begin
  try
    SaveReportToBlob(AReport, TBlobField(Module.BlobDataSet.FieldByName('SOURCE')));
    LReportID := ReportTree.KeyField.AsInteger;
    ReportTree.DataSource.DataSet.Refresh;
    ReportTree.UpdateTree;
    ReportTree.GoToRec(LReportID);
  finally
  end;
end;



procedure TReportForm.DeleteButtonClick(Sender: TObject);
begin
  ReportTree.DataSource.DataSet.Delete;
  ReportTree.DataSource.DataSet.Refresh;
  ReportTree.UpdateTree;
end;

end.



