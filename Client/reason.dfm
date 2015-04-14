object ReasonForm: TReasonForm
  Left = 322
  Top = 177
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1088#1080#1095#1080#1085#1099' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
  ClientHeight = 271
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SelectButton: TSpeedButton
    Left = 144
    Top = 242
    Width = 126
    Height = 21
    Caption = #1042#1099#1073#1088#1072#1090#1100
    OnClick = SelectButtonClick
  end
  object ReasonGrid: TSxkDBGrid
    Left = 8
    Top = 8
    Width = 265
    Height = 217
    DataSource = Module.ReasonDataSource
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnDrawColumnCell = ReasonGridDrawColumnCell
    OnDblClick = ReasonGridDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME_SOURCE'
        Title.Caption = #1048#1084#1103' '#1087#1088#1080#1095#1080#1085#1099
        Width = 240
        Visible = True
      end>
  end
end
