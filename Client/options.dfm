object OptionsForm: TOptionsForm
  Left = 248
  Top = 97
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
  ClientHeight = 288
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    520
    288)
  PixelsPerInch = 96
  TextHeight = 13
  object CloseButton: TSpeedButton
    Left = 426
    Top = 258
    Width = 81
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = CloseButtonClick
  end
  object ApplyButton: TSpeedButton
    Left = 328
    Top = 258
    Width = 89
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = ApplyButtonClick
  end
  object ColumnsGroupBox: TGroupBox
    Left = 8
    Top = 16
    Width = 501
    Height = 225
    Caption = #1057#1090#1086#1083#1073#1094#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object HideLabel: TLabel
      Left = 16
      Top = 19
      Width = 49
      Height = 13
      Caption = #1057#1082#1088#1099#1090#1100':'
    end
    object ShowLabel: TLabel
      Left = 288
      Top = 19
      Width = 59
      Height = 13
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100':'
    end
    object HideListBox: TListBox
      Left = 16
      Top = 37
      Width = 193
      Height = 174
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
    end
    object ShowListBox: TListBox
      Left = 288
      Top = 36
      Width = 193
      Height = 176
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 1
    end
    object AddButton: TButton
      Left = 232
      Top = 101
      Width = 33
      Height = 25
      Caption = '>>'
      TabOrder = 2
      OnClick = AddButtonClick
    end
    object RemoveButton: TButton
      Left = 232
      Top = 133
      Width = 33
      Height = 25
      Caption = '<<'
      TabOrder = 3
      OnClick = RemoveButtonClick
    end
  end
end
