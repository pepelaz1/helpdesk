object ClassSelectionForm: TClassSelectionForm
  Left = 144
  Top = 132
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1048#1058'-'#1091#1089#1083#1091#1075#1080
  ClientHeight = 568
  ClientWidth = 790
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
  object ClassGrid: TSxkDBGrid
    Left = 8
    Top = 8
    Width = 777
    Height = 497
    DataSource = Module.ClassDataSource2
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnCellClick = ClassGridCellClick
    OnDrawColumnCell = ClassGridDrawColumnCell
    OnDblClick = ClassGridDblClick
    OnKeyPress = ClassGridKeyPress
    OnTitleClick = ClassGridTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME_TYPE'
        Title.Caption = #1043#1088#1091#1087#1087#1072' '#1048#1058'-'#1091#1089#1083#1091#1075
        Width = 377
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME_CLASS'
        Title.Caption = #1048#1058'-'#1091#1089#1083#1091#1075#1072
        Width = 406
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CATEGORY'
        Title.Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
        Width = 300
        Visible = True
      end>
  end
  object FilterStatusBar: TStatusBar
    Left = 0
    Top = 549
    Width = 790
    Height = 19
    Panels = <
      item
        Width = 180
      end
      item
        Width = 250
      end
      item
        Width = 50
      end>
    SizeGrip = False
  end
  object FilterButton: TButton
    Left = 8
    Top = 517
    Width = 97
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = FilterButtonClick
  end
  object SelectButton: TButton
    Left = 626
    Top = 517
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = SelectButtonClick
  end
  object CancelButton: TButton
    Left = 710
    Top = 517
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object RefreshButton: TButton
    Left = 112
    Top = 517
    Width = 89
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
end
