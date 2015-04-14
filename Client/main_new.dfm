object MainForm: TMainForm
  Left = 79
  Top = 18
  Width = 938
  Height = 681
  BorderWidth = 1
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072#1084#1080
  Color = cl3DLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    928
    645)
  PixelsPerInch = 96
  TextHeight = 13
  object ResponsibleButton: TSpeedButton
    Left = 800
    Top = 516
    Width = 121
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1089#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = ResponsibleButtonClick
  end
  object DataButton: TSpeedButton
    Left = 792
    Top = 18
    Width = 129
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1044#1072#1085#1085#1099#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = DataButtonClick
  end
  object RefreshButton: TSpeedButton
    Left = 800
    Top = 463
    Width = 122
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = RefreshButtonClick
  end
  object SearchNumberLabel: TLabel
    Left = 798
    Top = 111
    Width = 104
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1086#1084#1077#1088#1091':'
  end
  object SearchNumberButton: TSpeedButton
    Left = 800
    Top = 162
    Width = 73
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1048#1089#1082#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = SearchNumberButtonClick
  end
  object FilterButton: TSpeedButton
    Left = 792
    Top = 52
    Width = 128
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1060#1080#1083#1100#1090#1088' '#1087#1086' '#1087#1086#1083#1103#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = FilterButtonClick
  end
  object OptionsButton: TSpeedButton
    Left = 800
    Top = 210
    Width = 81
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = OptionsButtonClick
  end
  object IncidentGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 769
    Height = 617
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1057#1087#1080#1089#1086#1082' '#1080#1085#1094#1080#1076#1077#1085#1090#1086#1074' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      769
      617)
    object IncidentGrid: TSxkDBGrid
      Left = 1
      Top = 19
      Width = 760
      Height = 590
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = Module.DataSource
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Verdana'
      TitleFont.Style = []
      OnCellClick = IncidentGridCellClick
      OnDrawColumnCell = IncidentGridDrawColumnCell
      OnDblClick = IncidentGridDblClick
      OnKeyDown = IncidentGridKeyDown
      OnKeyPress = IncidentGridKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'NUM_INCIDENT'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'INCIDENT_STR'
          Title.Caption = #8470
          Width = 68
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_STATE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WORKER'
          Width = 260
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OWNER_INC'
          Width = 270
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RESPONSIBLE_INC'
          Width = 290
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_DEVICE'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATE'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_RESOLUTION'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_CLASS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_TYPE'
          Title.Caption = #1058#1080#1087' '#1082#1083#1072#1089#1089#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
          Width = 564
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_SCALE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRIORITY'
          Visible = True
        end>
    end
  end
  object CloseButton: TButton
    Left = 800
    Top = 599
    Width = 123
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = CloseButtonClick
  end
  object SearchNumberEdit: TEdit
    Left = 800
    Top = 132
    Width = 79
    Height = 21
    Anchors = [akLeft, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BevelOuter = bvRaised
    TabOrder = 2
    OnKeyDown = SearchNumberEditKeyDown
  end
  object FilterStatusBar: TStatusBar
    Left = 0
    Top = 624
    Width = 928
    Height = 21
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaption
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Panels = <
      item
        Text = ' '#1044#1072#1085#1085#1099#1077' '#1086#1090#1092#1080#1083#1100#1090#1088#1086#1074#1072#1085#1099
        Width = 170
      end
      item
        Text = #1058#1077#1082#1091#1097#1080#1081' '#1089#1090#1086#1083#1073#1077#1094':'
        Width = 300
      end
      item
        Width = 200
      end>
    SizeGrip = False
    UseSystemFont = False
  end
  object RegisterButton: TButton
    Left = 800
    Top = 552
    Width = 121
    Height = 33
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    TabOrder = 4
    WordWrap = True
    OnClick = RegisterButtonClick
  end
end
