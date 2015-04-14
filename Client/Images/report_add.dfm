object ReportAddForm: TReportAddForm
  Left = 319
  Top = 300
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1080#1084#1103' '#1085#1086#1074#1086#1075#1086' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 92
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    404
    92)
  PixelsPerInch = 96
  TextHeight = 13
  object TitleCaption: TLabel
    Left = 16
    Top = 23
    Width = 61
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
  end
  object CloseButton: TButton
    Left = 291
    Top = 63
    Width = 81
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = CloseButtonClick
  end
  object OkButton: TButton
    Left = 35
    Top = 63
    Width = 81
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    TabOrder = 2
    OnClick = OkButtonClick
  end
  object TitleEdit: TEdit
    Left = 84
    Top = 20
    Width = 309
    Height = 23
    TabOrder = 0
  end
end
