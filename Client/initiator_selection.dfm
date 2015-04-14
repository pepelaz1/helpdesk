object InitiatorSelectionForm: TInitiatorSelectionForm
  Left = 50
  Top = 90
  Width = 958
  Height = 596
  Caption = #1042#1099#1073#1086#1088' '#1080#1085#1080#1094#1080#1072#1090#1086#1088#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
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
  DesignSize = (
    950
    569)
  PixelsPerInch = 96
  TextHeight = 14
  object SelectButton: TButton
    Left = 779
    Top = 520
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1073#1088#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = SelectButtonClick
  end
  object CancelButton: TButton
    Left = 864
    Top = 520
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = CancelButtonClick
  end
  object InitiatorGrid: TSxkDBGrid
    Left = 8
    Top = 8
    Width = 937
    Height = 502
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = Module.InitiatorDataSource
    FixedColor = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnCellClick = InitiatorGridCellClick
    OnDrawColumnCell = InitiatorGridDrawColumnCell
    OnDblClick = InitiatorGridDblClick
    OnKeyPress = InitiatorGridKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'WORKER'
        Width = 279
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCR'
        Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
        Width = 194
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Width = 151
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADDRESS'
        Title.Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077
        Width = 328
        Visible = True
      end>
  end
  object SyncButton: TButton
    Left = 8
    Top = 520
    Width = 169
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089' AD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = SyncButtonClick
  end
  object FilterButton: TButton
    Left = 680
    Top = 520
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = FilterButtonClick
  end
  object FilterStatusBar: TStatusBar
    Left = 0
    Top = 548
    Width = 950
    Height = 21
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
        Width = 250
      end
      item
        Width = 200
      end>
    UseSystemFont = False
  end
  object RefreshButton: TButton
    Left = 184
    Top = 520
    Width = 89
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = RefreshButtonClick
  end
end
