object MainFormFilter: TMainFormFilter
  Left = 152
  Top = 41
  BorderStyle = bsDialog
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 543
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FilterLabel: TLabel
    Left = 40
    Top = 516
    Width = 53
    Height = 14
    Caption = #1060#1080#1083#1100#1090#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object FilterButton: TButton
    Left = 471
    Top = 480
    Width = 91
    Height = 25
    Caption = #1060#1080#1083#1100#1090#1088#1086#1074#1072#1090#1100
    Default = True
    TabOrder = 0
    OnClick = FilterButtonClick
  end
  object CancelButton: TButton
    Left = 571
    Top = 480
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = CancelButtonClick
  end
  object ResetButton: TButton
    Left = 16
    Top = 480
    Width = 91
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 2
    OnClick = ResetButtonClick
  end
  object SaveButton: TButton
    Left = 253
    Top = 512
    Width = 97
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = SaveButtonClick
  end
  object FilterCombo: TComboBox
    Left = 104
    Top = 514
    Width = 145
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = FilterComboChange
    OnExit = FilterComboExit
  end
  object SaveAsButton: TButton
    Left = 361
    Top = 512
    Width = 97
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
    TabOrder = 5
    OnClick = SaveAsButtonClick
  end
  object DeleteButton: TButton
    Left = 471
    Top = 512
    Width = 91
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 6
    OnClick = DeleteButtonClick
  end
  object FilterPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 665
    Height = 473
    ActivePage = CustomTabSheet
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 7
    OnChange = FilterPageControlChange
    object FilterTabSheet: TTabSheet
      Caption = #1055#1086' '#1087#1086#1083#1103#1084
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 93
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1086#1083#1103':'
      end
      object Label2: TLabel
        Left = 240
        Top = 8
        Width = 64
        Height = 13
        Caption = #1054#1087#1077#1088#1072#1094#1080#1103':'
      end
      object Label3: TLabel
        Left = 351
        Top = 8
        Width = 61
        Height = 13
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      end
      object IncidentTitleNumEdit: TEdit
        Left = 7
        Top = 32
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 0
        Text = #1053#1086#1084#1077#1088' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      end
      object StatusTitleEdit: TEdit
        Left = 7
        Top = 64
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 1
        Text = #1057#1090#1072#1090#1091#1089
      end
      object InitiatorTitleEdit: TEdit
        Left = 7
        Top = 128
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 2
        Text = #1048#1085#1085#1080#1094#1080#1072#1090#1086#1088
      end
      object OwnerTitleEdit: TEdit
        Left = 7
        Top = 160
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 3
        Text = #1042#1083#1072#1076#1077#1083#1077#1094
      end
      object ResponsibleTitleEdit: TEdit
        Left = 7
        Top = 192
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 4
        Text = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      end
      object InfrastructureTitleEdit: TEdit
        Left = 7
        Top = 224
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 5
        Text = #1069#1083#1077#1084#1077#1085#1090' '#1080#1085#1092#1088#1072#1089#1090#1088#1091#1082#1090#1091#1088#1099
      end
      object CreationDateTitleEdit: TEdit
        Left = 7
        Top = 256
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 6
        Text = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1089#1086#1079#1076#1072#1085#1080#1103
      end
      object FixDateTitleEdit: TEdit
        Left = 7
        Top = 288
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 7
        Text = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1091#1089#1090#1088#1072#1085#1077#1085#1080#1103
      end
      object ClassTitleEdit: TEdit
        Left = 7
        Top = 320
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 8
        Text = #1048#1058'-'#1091#1089#1083#1091#1075#1072
      end
      object TypeEdit: TEdit
        Left = 7
        Top = 352
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 9
        Text = #1043#1088#1091#1087#1087#1072' '#1048#1058'-'#1091#1089#1083#1091#1075
      end
      object ScaleTitleEdit: TEdit
        Left = 7
        Top = 384
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 10
        Text = #1052#1072#1089#1096#1090#1072#1073
      end
      object PriorityTitleEdit: TEdit
        Left = 7
        Top = 416
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 11
        Text = #1055#1088#1080#1086#1088#1080#1090#1077#1090
      end
      object IncidentNumComboBox: TComboBox
        Left = 230
        Top = 32
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 12
        Text = '='
        OnExit = IncidentNumComboBoxExit
        Items.Strings = (
          '='
          '<'
          '>'
          '<='
          '>=')
      end
      object IncidentNumValueEdit: TEdit
        Left = 338
        Top = 32
        Width = 109
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 13
      end
      object StatusComboBox: TComboBox
        Left = 230
        Top = 64
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 14
        OnExit = StatusComboBoxExit
        Items.Strings = (
          '='
          '<>')
      end
      object StatusValueComboBox: TComboBox
        Left = 338
        Top = 64
        Width = 108
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 15
        OnExit = IncidentNumComboBoxExit
        Items.Strings = (
          ''
          #1057#1086#1079#1076#1072#1085
          #1053#1072#1079#1085#1072#1095#1077#1085
          #1042' '#1088#1072#1073#1086#1090#1077
          #1054#1090#1082#1083#1086#1085#1077#1085
          #1054#1073#1089#1083#1091#1078#1077#1085
          #1047#1072#1082#1088#1099#1090
          #1054#1090#1082#1088#1099#1090' '#1087#1086#1074#1090#1086#1088#1085#1086)
      end
      object InitiatorComboBox: TComboBox
        Left = 230
        Top = 128
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 16
        OnExit = InitiatorComboBoxExit
        Items.Strings = (
          '='
          #1074#1082#1083#1102#1095#1072#1077#1090)
      end
      object InitiatorValueEdit: TEdit
        Left = 338
        Top = 128
        Width = 309
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 17
      end
      object OwnerComboBox: TComboBox
        Left = 230
        Top = 160
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 18
        OnExit = OwnerComboBoxExit
        Items.Strings = (
          '='
          #1074#1082#1083#1102#1095#1072#1077#1090)
      end
      object OwnerValueEdit: TEdit
        Left = 338
        Top = 160
        Width = 309
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 19
      end
      object ResponsibleComboBox: TComboBox
        Left = 230
        Top = 192
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 20
        OnExit = ResponsibleComboBoxExit
        Items.Strings = (
          '='
          #1074#1082#1083#1102#1095#1072#1077#1090)
      end
      object ResponsibleValueEdit: TEdit
        Left = 338
        Top = 192
        Width = 309
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 21
      end
      object InfrastructureComboBox: TComboBox
        Left = 230
        Top = 224
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 22
        OnExit = InfrastructureComboBoxExit
        Items.Strings = (
          '='
          #1074#1082#1083#1102#1095#1072#1077#1090)
      end
      object InfrastructureValueEdit: TEdit
        Left = 338
        Top = 224
        Width = 309
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 23
      end
      object CreationDateComboBox: TComboBox
        Left = 230
        Top = 256
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 24
        Text = '='
        OnExit = CreationDateComboBoxExit
        Items.Strings = (
          '='
          '<'
          '>'
          '<='
          '>=')
      end
      object CreationDateValueEdit: TEdit
        Left = 338
        Top = 256
        Width = 154
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 25
        OnKeyDown = CreationDateValueEditKeyDown
      end
      object CreationDateButton: TButton
        Left = 490
        Top = 256
        Width = 28
        Height = 19
        Caption = '...'
        TabOrder = 26
        OnClick = CreationDateButtonClick
      end
      object FixDateComboBox: TComboBox
        Left = 230
        Top = 288
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 27
        Text = '='
        OnExit = FixDateComboBoxExit
        Items.Strings = (
          '='
          '<'
          '>'
          '<='
          '>=')
      end
      object FixDateValueEdit: TEdit
        Left = 338
        Top = 288
        Width = 154
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 28
        OnKeyDown = FixDateValueEditKeyDown
      end
      object FixDateButton: TButton
        Left = 491
        Top = 288
        Width = 28
        Height = 19
        Caption = '...'
        TabOrder = 29
        OnClick = FixDateButtonClick
      end
      object ClassComboBox: TComboBox
        Left = 230
        Top = 320
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 30
        OnExit = ClassComboBoxExit
        Items.Strings = (
          '='
          #1074#1082#1083#1102#1095#1072#1077#1090)
      end
      object ClassValueEdit: TEdit
        Left = 338
        Top = 320
        Width = 309
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 31
      end
      object TypeComboBox: TComboBox
        Left = 230
        Top = 352
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 32
        OnExit = TypeComboBoxExit
        Items.Strings = (
          '='
          #1074#1082#1083#1102#1095#1072#1077#1090)
      end
      object TypeValueEdit: TEdit
        Left = 338
        Top = 352
        Width = 309
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 33
      end
      object ScaleComboBox: TComboBox
        Left = 230
        Top = 384
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 34
        Text = '='
        OnExit = ScaleComboBoxExit
        Items.Strings = (
          '=')
      end
      object ScaleValueComboBox: TComboBox
        Left = 338
        Top = 384
        Width = 108
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 35
        OnExit = ScaleValueComboBoxExit
        Items.Strings = (
          ''
          #1054#1073#1099#1095#1085#1099#1081
          #1050#1088#1091#1087#1085#1099#1081)
      end
      object PriorityComboBox: TComboBox
        Left = 230
        Top = 416
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 36
        Text = '='
        OnExit = PriorityComboBoxExit
        Items.Strings = (
          '='
          '<'
          '>'
          '<='
          '>=')
      end
      object PriorityValueEdit: TEdit
        Left = 338
        Top = 415
        Width = 109
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        TabOrder = 37
      end
      object TypeTitleEdit: TEdit
        Left = 7
        Top = 96
        Width = 202
        Height = 21
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 38
        Text = #1058#1080#1087
      end
      object IncTypeComboBox: TComboBox
        Left = 230
        Top = 96
        Width = 86
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 39
        OnExit = StatusComboBoxExit
        Items.Strings = (
          '='
          '<>')
      end
      object IncTypeValueComboBox: TComboBox
        Left = 338
        Top = 96
        Width = 108
        Height = 21
        BevelKind = bkSoft
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 40
        OnExit = IncTypeValueComboBoxExit
        Items.Strings = (
          ''
          #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
          #1055#1088#1086#1073#1083#1077#1084#1072)
      end
    end
    object CustomTabSheet: TTabSheet
      Caption = #1047#1072#1082#1072#1079#1085#1086#1081
      ImageIndex = 1
      object AvailFieldsLabel: TLabel
        Left = 2
        Top = 6
        Width = 269
        Height = 13
        Caption = #1040#1090#1088#1080#1073#1091#1090#1099', '#1076#1086#1089#1090#1091#1087#1085#1099#1077' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1092#1080#1083#1100#1090#1088#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object WhereMemo: TMemo
        Left = 0
        Top = 72
        Width = 657
        Height = 369
        TabOrder = 0
        OnChange = WhereMemoChange
      end
      object AvailMemo: TMemo
        Left = 0
        Top = 24
        Width = 657
        Height = 49
        BevelInner = bvSpace
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
end
