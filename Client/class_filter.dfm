object ClassFormFilter: TClassFormFilter
  Left = 238
  Top = 133
  BorderStyle = bsDialog
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 243
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FilterGroupBox: TGroupBox
    Left = 7
    Top = 8
    Width = 625
    Height = 185
    Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1087#1086' '#1087#1086#1083#1103#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object FieldLabel: TLabel
      Left = 8
      Top = 24
      Width = 93
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1086#1083#1103':'
    end
    object OperationLabel: TLabel
      Left = 216
      Top = 24
      Width = 64
      Height = 13
      Caption = #1054#1087#1077#1088#1072#1094#1080#1103':'
    end
    object ValueLabel: TLabel
      Left = 320
      Top = 24
      Width = 61
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
    end
    object ClassTitleEdit: TEdit
      Left = 7
      Top = 80
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 1
      Text = #1048#1058'-'#1091#1089#1083#1091#1075#1072
    end
    object ClassComboBox: TComboBox
      Left = 216
      Top = 80
      Width = 86
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object ClassValueEdit: TEdit
      Left = 319
      Top = 80
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 3
    end
    object ClassDescTitleEdit: TEdit
      Left = 7
      Top = 112
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 4
      Text = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object ClassDescComboBox: TComboBox
      Left = 216
      Top = 112
      Width = 86
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object ClassDescValueEdit: TEdit
      Left = 319
      Top = 112
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 6
    end
    object CategoryTitleEdit: TEdit
      Left = 7
      Top = 144
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 7
      Text = #1050#1072#1090#1077#1075#1086#1088#1080#1103
    end
    object CategoryComboBox: TComboBox
      Left = 216
      Top = 144
      Width = 86
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 8
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object CategoryValueEdit: TEdit
      Left = 319
      Top = 144
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 9
    end
    object Edit1: TEdit
      Left = 577
      Top = 392
      Width = 0
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -4
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object TypeTitleEdit: TEdit
      Left = 7
      Top = 48
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 10
      Text = #1043#1088#1091#1087#1087#1072' '#1048#1058'-'#1091#1089#1083#1091#1075
    end
    object TypeComboBox: TComboBox
      Left = 216
      Top = 48
      Width = 86
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object TypeValueEdit: TEdit
      Left = 319
      Top = 48
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 12
    end
  end
  object ResetButton: TButton
    Left = 16
    Top = 203
    Width = 91
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ResetButtonClick
  end
  object FilterButton: TButton
    Left = 430
    Top = 203
    Width = 91
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088#1086#1074#1072#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = FilterButtonClick
  end
  object CancelButton: TButton
    Left = 533
    Top = 203
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = CancelButtonClick
  end
end
