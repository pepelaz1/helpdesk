object CalendarForm: TCalendarForm
  Left = 368
  Top = 164
  BorderStyle = bsDialog
  Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1100
  ClientHeight = 288
  ClientWidth = 299
  Color = cl3DLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object YearLabel: TLabel
    Left = 178
    Top = 172
    Width = 23
    Height = 14
    Caption = #1043#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object MonthLabel: TLabel
    Left = 13
    Top = 172
    Width = 40
    Height = 14
    Caption = #1052#1077#1089#1103#1094
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object TimeLabel: TLabel
    Left = 13
    Top = 217
    Width = 44
    Height = 14
    Caption = #1042#1088#1077#1084#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object CalendarControl: TCalendar
    Left = 0
    Top = 0
    Width = 297
    Height = 164
    BorderStyle = bsNone
    Color = clWhite
    StartOfWeek = 0
    TabOrder = 0
    OnDblClick = CalendarControlDblClick
  end
  object YearEdit: TSpinEdit
    Left = 214
    Top = 169
    Width = 73
    Height = 23
    Color = clWhite
    MaxValue = 2100
    MinValue = 1980
    TabOrder = 1
    Value = 1980
    OnChange = YearEditChange
  end
  object MonthComboBox: TComboBox
    Left = 64
    Top = 169
    Width = 105
    Height = 22
    BevelKind = bkTile
    Style = csDropDownList
    Color = clWhite
    ItemHeight = 14
    TabOrder = 2
    OnChange = MonthComboBoxChange
    Items.Strings = (
      #1103#1085#1074#1072#1088#1100
      #1092#1077#1074#1088#1072#1083#1100
      #1084#1072#1088#1090
      #1072#1087#1088#1077#1083#1100
      #1084#1072#1081
      #1080#1102#1085#1100
      #1080#1102#1083#1100
      #1072#1074#1075#1091#1089#1090
      #1089#1077#1085#1090#1103#1073#1088#1100
      #1086#1082#1090#1103#1073#1088#1100
      #1085#1086#1103#1073#1088#1100
      #1076#1077#1082#1072#1073#1088#1100)
  end
  object SelectButton: TButton
    Left = 216
    Top = 251
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100
    TabOrder = 3
    OnClick = SelectButtonClick
  end
  object CancelButton: TButton
    Left = 216
    Top = 211
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object TimeEdit: TMaskEdit
    Left = 64
    Top = 213
    Width = 93
    Height = 22
    Color = clWhite
    EditMask = '!90:00:00;1;_'
    MaxLength = 8
    TabOrder = 5
    Text = '  :  :  '
  end
  object TimeButton: TSpinButton
    Left = 151
    Top = 215
    Width = 15
    Height = 18
    DownGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000000000000080800000808000008080000080
      8000008080000080800000808000000000000000000000000000008080000080
      8000008080000080800000808000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    TabOrder = 6
    UpGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000080
      8000008080000080800000808000008080000000000000000000000000000080
      8000008080000080800000808000008080000080800000808000000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    OnDownClick = TimeButtonDownClick
    OnUpClick = TimeButtonUpClick
  end
end
