object ResponsibleForm: TResponsibleForm
  Left = 79
  Top = 49
  BorderStyle = bsDialog
  Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1077' '#1087#1086' '#1082#1083#1072#1089#1089#1072#1084' '#1080#1085#1094#1080#1076#1077#1085#1090#1086#1074
  ClientHeight = 454
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ResponsibleGrid: TSxkDBGrid
    Left = 8
    Top = 8
    Width = 729
    Height = 385
    DataSource = Module.ResponsibleDataSource
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnCellClick = ResponsibleGridCellClick
    OnDrawColumnCell = ResponsibleGridDrawColumnCell
    OnKeyDown = ResponsibleGridKeyDown
    OnKeyPress = ResponsibleGridKeyPress
    Columns = <
      item
        Color = clWhite
        Expanded = False
        FieldName = 'NAME_CLASS'
        Title.Caption = #1048#1058'-'#1091#1089#1083#1091#1075#1072
        Width = 469
        Visible = True
      end
      item
        Color = clWhite
        Expanded = False
        FieldName = 'WORKER'
        Width = 233
        Visible = True
      end>
  end
  object AddButton: TButton
    Left = 488
    Top = 400
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = AddButtonClick
  end
  object RemoveButton: TButton
    Left = 576
    Top = 400
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = RemoveButtonClick
  end
  object CloseButton: TButton
    Left = 664
    Top = 400
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = CloseButtonClick
  end
  object FilterButton: TButton
    Left = 8
    Top = 400
    Width = 89
    Height = 25
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
    Top = 433
    Width = 743
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
        Width = 50
      end>
    UseSystemFont = False
  end
  object RefreshButton: TButton
    Left = 104
    Top = 400
    Width = 81
    Height = 25
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
