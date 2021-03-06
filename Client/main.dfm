object MainForm: TMainForm
  Left = 162
  Top = 19
  Width = 920
  Height = 696
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
    910
    667)
  PixelsPerInch = 96
  TextHeight = 13
  object ResponsibleButton: TSpeedButton
    Left = 800
    Top = 583
    Width = 110
    Height = 21
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
  object SearchNumberLabel: TLabel
    Left = 171
    Top = 556
    Width = 104
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1086#1084#1077#1088#1091':'
  end
  object FilterButton: TSpeedButton
    Left = 7
    Top = 583
    Width = 137
    Height = 20
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
    Left = 441
    Top = 550
    Width = 137
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = OptionsButtonClick
  end
  object IncidentAmountLabel1: TLabel
    Left = 171
    Top = 587
    Width = 223
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090#1099' '#1079#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1077
  end
  object IncidentAmountLabel2: TLabel
    Left = 444
    Top = 587
    Width = 66
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1084#1077#1089#1103#1094#1072'('#1077#1074')'
  end
  object RequestButton: TSpeedButton
    Left = 711
    Top = 583
    Width = 84
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1103#1074#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    Visible = False
    OnClick = RequestButtonClick
  end
  object ReportButton: TSpeedButton
    Left = 588
    Top = 550
    Width = 63
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1095#1077#1090#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = ReportButtonClick
  end
  object IncidentGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 902
    Height = 539
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
      902
      539)
    object IncidentGrid: TSxkDBGrid
      Left = 1
      Top = 19
      Width = 893
      Height = 512
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
          FieldName = 'INCIDENT_STR'
          Title.Caption = #8470#1087'.'#1087
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_STATE'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INCIDENT_TYPE'
          Title.Caption = #1058#1080#1087
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WORKER'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OWNER_INC'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RESPONSIBLE_INC'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_DEVICE'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATE'
          Width = 150
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
          Title.Caption = #1048#1058'-'#1059#1089#1083#1091#1075#1072
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_TYPE'
          Title.Caption = #1043#1088#1091#1087#1087#1072' '#1048#1058'-'#1091#1089#1083#1091#1075
          Width = 370
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME_SCALE'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRIORITY'
          Visible = True
        end>
    end
  end
  object SearchNumberEdit: TEdit
    Left = 279
    Top = 553
    Width = 79
    Height = 21
    Anchors = [akLeft, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BevelOuter = bvRaised
    TabOrder = 1
    OnKeyDown = SearchNumberEditKeyDown
  end
  object FilterStatusBar: TStatusBar
    Left = 0
    Top = 646
    Width = 910
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
  object IncidentMonthMemo: TMemo
    Left = 400
    Top = 585
    Width = 39
    Height = 19
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BevelOuter = bvRaised
    MaxLength = 4
    TabOrder = 3
    WantReturns = False
    OnChange = IncidentMonthMemoChange
    OnKeyDown = IncidentMonthMemoKeyDown
    OnKeyPress = IncidentMonthMemoKeyPress
  end
  object CloseButton: TBitBtn
    Left = 801
    Top = 614
    Width = 106
    Height = 22
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1042#1099#1093#1086#1076
    ModalResult = 2
    TabOrder = 4
    OnClick = CloseButtonClick
    Glyph.Data = {
      DA050000424DDA050000000000003604000028000000190000000F0000000100
      080000000000A4010000CE0E0000CE0E00000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF0101A4FFFFFFFFFFFF0101FFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FF010101A4FFFFFFFF0101A4FFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFF010101A4FFFF010101FFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFF010101A4010101FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFF0101010101FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFF010101A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFF0101
      010101A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF010101FF010101
      A4FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF010101FFFFFF010101A4FFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FF010101FFFFFFFFFF010101FFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FF0101FFFFFFFFFFFFFF0101FFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    NumGlyphs = 2
  end
  object RefreshButton: TBitBtn
    Left = 8
    Top = 614
    Width = 105
    Height = 22
    Anchors = [akLeft]
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 5
    OnClick = RefreshButtonClick
    Kind = bkRetry
  end
  object SearchNumberButton: TBitBtn
    Left = 360
    Top = 551
    Width = 75
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1048#1089#1082#1072#1090#1100
    TabOrder = 6
    OnClick = SearchNumberButtonClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      20000000000000040000C40E0000C40E00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF0000
      00FF000000FF000000FF000000FFFFFFFFFF000000000000000000000000FFFF
      FFFF000000FF000000FF000000FF000000FF000000FFFFFFFFFF000000FFFFFF
      FFFF000000FF000000FF000000FFFFFFFFFF000000000000000000000000FFFF
      FFFF000000FFFFFFFFFF000000FF000000FF000000FFFFFFFFFF000000FFFFFF
      FFFF000000FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000000FFFFFFFFFF000000FF000000FF000000FFFFFFFFFF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FFFFFFFFFF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FFFFFFFFFF000000FF0000
      00FFFFFFFFFF000000FF000000FF000000FF000000FF000000FF000000FFFFFF
      FFFF000000FF000000FF000000FF000000FF000000FFFFFFFFFF000000FF0000
      00FFFFFFFFFF000000FF000000FF000000FFC0C0C0FF000000FF000000FFFFFF
      FFFF000000FF000000FF000000FF000000FF000000FFFFFFFFFF000000FF0000
      00FFFFFFFFFF000000FF000000FF000000FFC0C0C0FF000000FF000000FFFFFF
      FFFF000000FF000000FF000000FF000000FF000000FFFFFFFFFFFFFFFFFF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000000FFFFFFFFFF000000FF000000FF000000FFFFFFFFFF000000FFFFFF
      FFFF000000FF000000FF000000FFFFFFFFFFFFFFFFFF0000000000000000FFFF
      FFFF000000FF000000FF000000FF000000FF000000FFFFFFFFFF000000FF0000
      00FF000000FF000000FF000000FFFFFFFFFF000000000000000000000000FFFF
      FFFFFFFFFFFF000000FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF0000
      00FF000000FF000000FFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000FFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF00000000FFFFFFFF0000
      00FFFFFFFFFF000000FFFFFFFFFF000000000000000000000000000000000000
      0000FFFFFFFF000000FF000000FF000000FFFFFFFFFF00000000FFFFFFFF0000
      00FF000000FF000000FFFFFFFFFF000000000000000000000000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000}
  end
  object RegisterButton: TBitBtn
    Left = 730
    Top = 549
    Width = 177
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    TabOrder = 7
    OnClick = RegisterButtonClick
    Glyph.Data = {
      C6050000424DC605000000000000360400002800000014000000140000000100
      0800000000009001000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4
      A4A4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000A4A4FFFFFFFFFFFFFFFF
      FFFFFFFFFF00FAFAFA00A4A4FFFFFFFFFFFFFFFFFFFFFFA4A400FAFAFA00A4A4
      A4A4A4FFFFFFFFFFFFFFFFA4A400FAFAFA00A4A4A4A4A4FFFFFFFFFFFF000000
      0000FAFAFA0000000000A4FFFFFFFFFFFF00FAFAFAFAFAFAFAFAFAFAFA00A4FF
      FFFFFFFFFF00FAFAFAFAFAFAFAFAFAFAFA00A4FFFFFFFFFFFF00FAFAFAFAFAFA
      FAFAFAFAFA00A4FFFFFFFFFFFF0000000000FAFAFA0000000000FFFFFFFFFFFF
      FFFFFFFFFF00FAFAFA00A4A4FFFFFFFFFFFFFFFFFFFFFFFFFF00FAFAFA00A4A4
      FFFFFFFFFFFFFFFFFFFFFFFFFF00FAFAFA00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF}
  end
  object DataButton: TBitBtn
    Left = 7
    Top = 552
    Width = 153
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = #1044#1072#1085#1085#1099#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    TabOrder = 8
    OnClick = DataButtonClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      20000000000000040000C40E0000C40E00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000262F38FF0000000000000000CF6B6CFFC968
      69FFB25B5CFF994D4EFF7F3F3FFF6C8F9FFF6A8B9CFF597687FF435869FF2835
      43FF6C8F9FFF00000000455261FF2396C3FF29353EFF00000000CF6B6BFFE88E
      8FFFE6898AFFE27E80FFB65B5BFF6C8F9FFF58C5E1FF4DBEDDFF4DBEDDFF2670
      8BFF1F2A33FF4F5E6FFF21A1D0FF30B8E9FF599CB7FF4F6776FFD27172FFA66C
      6CFFA06364FF955858FF8C4B4BFF7094A5FF58848EFF5B6763FF5D5448FF5B52
      46FF646463FF398099FF3DBBE8FF66AFCCFF758591FF00000000D67879FFF6AA
      ABFFF09D9EFFEA8F90FFCB6868FF73858AFF76756BFFB39E7FFFE7DC9FFFE5D7
      A3FFADA797FF616D6BFF6698A9FF758591FF0000000000000000DA8283FFC37F
      7FFFBC7475FFAF6767FFA45959FF7D7C77FFAA9784FFFFFEC6FFFFF4BAFFFFF2
      B8FFFEECC9FFAFA895FF6F665EFF000000000000000000000000DF8A8BFFFDB9
      BBFFF9B0B1FFF3A4A4FFCE6E6DFF8C8176FFDDCBABFFFFFFDBFFFFFCDFFFFFFC
      D4FFFFF1BAFFE5D0A8FF857467FF000000000000000000000000E39394FFFFBD
      BEFFFDB7B9FFF7ADAEFFCF7170FF9B9187FFDCCEB0FFFFFFF0FFFFFCF4FFFFFC
      E3FFFFF6C5FFE6D2A0FFB6A47DFF000000000000000000000000E79B9CFFFFBD
      BEFFFFBDBEFFFBB5B6FFD17473FFA0A5A2FFB5AB9BFFFFFFFFFFFFFFFBFFFFFF
      E1FFFFFFCAFFB6A47DFFD2BF98FF000000000000000000000000ECA4A5FFFFBD
      BEFFFFBDBEFFFEBCBDFFD27676FF99B5BDFFB3B5ABFFC0B3ACFFF1E6CDFFEDE2
      BFFFB9AD91FF726155FF00000000000000000000000000000000F0ACADFFCD85
      85FFC57A7BFFB86C6CFFAC5D5DFF8FC4D6FF78ABB8FF93A7A7FF9D9B92FF8E8A
      81FF72898AFF515256FF00000000000000000000000000000000F4B3B4FFFFBD
      BEFFFFBDBEFFFFBDBEFFD37979FF92CADBFFA8F3FBFFA8F3FBFFA8F3FBFF4DBE
      DDFF49AFCCFF435161FF00000000000000000000000000000000F5B6B7FFF5B6
      B7FFEDA7A9FFE39394FFCF7171FF8FC3D5FF85B4C7FF7AA4B4FF7095A6FF6A8B
      9CFF57ABC5FF495869FF0000000000000000000000000000000000000000D6A2
      9DFF927C6CFFE5E0DCFFFFFFFFFFCB9497FF91B2B9FF907B6CFFE5E0DCFFFFFF
      FFFF6A8B9CFF55697AFF00000000000000000000000000000000000000000000
      0000C69992FF957D6EFFF4ECE8FFE6D3C9FFCB9196FF8CABB3FF86837DFFF4EC
      E8FFE2F3F5FF6A8B9CFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
  end
end
