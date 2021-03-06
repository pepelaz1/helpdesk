object InitiatorFormFilter: TInitiatorFormFilter
  Left = 187
  Top = 117
  BorderStyle = bsDialog
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 294
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FilterGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 625
    Height = 241
    Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1087#1086' '#1087#1086#1083#1103#1084
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
    object InitiatorTitleEdit: TEdit
      Left = 7
      Top = 48
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 1
      Text = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object InitiatorComboBox: TComboBox
      Left = 216
      Top = 48
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnExit = InitiatorComboBoxExit
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object InitiatorValueEdit: TEdit
      Left = 319
      Top = 48
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 3
    end
    object LoginTitleEdit: TEdit
      Left = 7
      Top = 112
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 4
      Text = #1051#1086#1075#1080#1085
    end
    object LoginComboBox: TComboBox
      Left = 216
      Top = 112
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnExit = LoginComboBoxExit
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object LoginValueEdit: TEdit
      Left = 319
      Top = 112
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 6
    end
    object PhoneTitleEdit: TEdit
      Left = 7
      Top = 176
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 7
      Text = #1058#1077#1083#1077#1092#1086#1085
    end
    object PhoneComboBox: TComboBox
      Left = 216
      Top = 176
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 8
      OnExit = PhoneComboBoxExit
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object PhoneValueEdit: TEdit
      Left = 319
      Top = 176
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 9
    end
    object EmailTitleEdit: TEdit
      Left = 7
      Top = 144
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 10
      Text = #1069#1083#1077#1082#1090#1088#1086#1085#1085#1072#1103' '#1087#1086#1095#1090#1072
    end
    object EmailComboBox: TComboBox
      Left = 216
      Top = 144
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      OnExit = EmailComboBoxExit
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object EmailValueEdit: TEdit
      Left = 319
      Top = 144
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 12
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
    object AddressTitleEdit: TEdit
      Left = 7
      Top = 208
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 13
      Text = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077
    end
    object AddressComboBox: TComboBox
      Left = 216
      Top = 208
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 14
      OnExit = PhoneComboBoxExit
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object AddressValueEdit: TEdit
      Left = 319
      Top = 208
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 15
    end
    object DescrTitileEdit: TEdit
      Left = 7
      Top = 80
      Width = 202
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      ReadOnly = True
      TabOrder = 16
      Text = #1044#1086#1083#1078#1085#1086#1089#1090#1100
    end
    object DescrComboBox: TComboBox
      Left = 216
      Top = 80
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 17
      OnExit = InitiatorComboBoxExit
      Items.Strings = (
        '='
        #1074#1082#1083#1102#1095#1072#1077#1090)
    end
    object DescrValueEdit: TEdit
      Left = 319
      Top = 80
      Width = 290
      Height = 21
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvRaised
      TabOrder = 18
    end
  end
  object ResetButton: TButton
    Left = 16
    Top = 259
    Width = 91
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 2
    OnClick = ResetButtonClick
  end
  object FilterButton: TButton
    Left = 432
    Top = 259
    Width = 91
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088#1086#1074#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = FilterButtonClick
  end
  object CancelButton: TButton
    Left = 536
    Top = 259
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = CancelButtonClick
  end
end
