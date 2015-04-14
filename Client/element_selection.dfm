object ElementSelectionForm: TElementSelectionForm
  Left = 230
  Top = 213
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1080#1085#1092#1088#1072#1089#1090#1088#1091#1082#1090#1091#1088#1099
  ClientHeight = 487
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object CancelButton: TButton
    Left = 394
    Top = 405
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = CancelButtonClick
  end
  object SelectButton: TButton
    Left = 314
    Top = 405
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = SelectButtonClick
  end
  object SyncButton: TButton
    Left = 8
    Top = 405
    Width = 169
    Height = 25
    Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089' AD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = SyncButtonClick
  end
  object FilterButton: TButton
    Left = 96
    Top = 437
    Width = 81
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = FilterButtonClick
  end
  object FilterStatusBar: TStatusBar
    Left = 0
    Top = 465
    Width = 474
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Panels = <
      item
        Width = 170
      end
      item
        Width = 280
      end
      item
        Width = 50
      end>
    UseSystemFont = False
  end
  object RefreshButton: TButton
    Left = 8
    Top = 437
    Width = 81
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = RefreshButtonClick
  end
  object ElementGrid: TSxkDBGrid
    Left = 0
    Top = 8
    Width = 473
    Height = 385
    DataSource = Module.ElementDataSource
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnCellClick = ElementGridCellClick
    OnDrawColumnCell = ElementGridDrawColumnCell
    OnDblClick = ElementGridDblClick
    OnKeyPress = ElementGridKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME_DEV'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Title.Caption = #1069#1083#1077#1084#1077#1085#1090' '#1080#1085#1092#1088#1072#1089#1090#1088#1091#1082#1090#1091#1088#1099
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 251
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROOM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Title.Caption = #1055#1086#1084#1077#1097#1077#1085#1080#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 88
        Visible = True
      end>
  end
end
