object ResponsibleAddForm: TResponsibleAddForm
  Left = 223
  Top = 194
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1075#1086' '#1087#1086' '#1082#1083#1072#1089#1089#1091' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
  ClientHeight = 155
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ClassLabel: TLabel
    Left = 24
    Top = 32
    Width = 106
    Height = 13
    Caption = #1050#1083#1072#1089#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object ResponsibleLabel: TLabel
    Left = 31
    Top = 72
    Width = 100
    Height = 13
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1085#1099#1081':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object AddButton: TSpeedButton
    Left = 392
    Top = 120
    Width = 105
    Height = 22
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    OnClick = AddButtonClick
  end
  object CancelButton: TSpeedButton
    Left = 512
    Top = 120
    Width = 105
    Height = 22
    Caption = #1054#1090#1084#1077#1085#1072
    OnClick = CancelButtonClick
  end
  object ResponsibleComboBox: TComboBox
    Left = 144
    Top = 69
    Width = 473
    Height = 21
    BevelKind = bkTile
    Style = csDropDownList
    Color = clWhite
    DropDownCount = 20
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnExit = ResponsibleComboBoxExit
  end
  object ClassComboBox: TComboBox
    Left = 144
    Top = 29
    Width = 473
    Height = 21
    BevelKind = bkTile
    Style = csDropDownList
    Color = clWhite
    DropDownCount = 20
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnExit = ClassComboBoxExit
  end
end
