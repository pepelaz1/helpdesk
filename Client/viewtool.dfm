object ViewToolForm: TViewToolForm
  Left = 219
  Top = 199
  Width = 481
  Height = 139
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1073#1088#1072#1097#1077#1085#1080#1081
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  DesignSize = (
    473
    112)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 457
    Height = 97
  end
  object IncidentAmountLabel: TLabel
    Left = 21
    Top = 28
    Width = 192
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090#1099' '#1079#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1077
  end
  object IncidentAmountLabel2: TLabel
    Left = 282
    Top = 28
    Width = 56
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1084#1077#1089#1103#1094#1072'('#1077#1074')'
  end
  object IncidentMonthMemo: TMemo
    Left = 234
    Top = 25
    Width = 39
    Height = 19
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BevelOuter = bvRaised
    MaxLength = 4
    TabOrder = 0
    WantReturns = False
    OnKeyDown = IncidentMonthMemoKeyDown
  end
  object AcceptUpCheck: TCheckBox
    Left = 26
    Top = 61
    Width = 210
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
    TabOrder = 1
  end
end
