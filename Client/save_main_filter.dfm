object SaveFilterForm: TSaveFilterForm
  Left = 253
  Top = 283
  BorderStyle = bsDialog
  Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088' '#1082#1072#1082':'
  ClientHeight = 70
  ClientWidth = 371
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
  object NameLabel: TLabel
    Left = 16
    Top = 24
    Width = 80
    Height = 13
    Caption = #1048#1084#1103' '#1092#1080#1083#1100#1090#1088#1072':'
  end
  object NameEdit: TEdit
    Left = 101
    Top = 21
    Width = 156
    Height = 21
    TabOrder = 0
  end
  object SaveButton: TButton
    Left = 265
    Top = 19
    Width = 96
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = SaveButtonClick
  end
end
