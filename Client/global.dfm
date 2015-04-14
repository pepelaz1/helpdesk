object Module: TModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 254
  Top = 268
  Height = 628
  Width = 747
  object OraSession: TOracleSession
    AfterLogOn = OraSessionAfterLogOn
    DesignConnection = True
    LogonUsername = 'helpdesk'
    LogonPassword = 'hd'
    LogonDatabase = 'LIN'
    ThreadSafe = True
    Connected = True
    Left = 24
    Top = 8
  end
  object OraQuery: TOracleQuery
    Session = OraSession
    Left = 16
    Top = 72
  end
  object DataSource: TDataSource
    DataSet = OraDataSet
    Left = 632
    Top = 320
  end
  object OraDataSet: TOracleDataSet
    SQL.Strings = (
      'select  '
      
        '   lpad(to_char(t2.num_incident),7,'#39'0'#39') incident_str,  t1.name_s' +
        'tate, t2.*'
      'from incident_state t1, '
      '       common_view t2, '
      '       incident_move_card t3, '
      '       (select '
      '             t.num_incident, max(t.date_move) max_date'
      '        from '
      '             incident_move_card t '
      '         group by t.num_incident)  t4'
      'where '
      '   t2.num_incident = t3.num_incident and'
      '   t3.num_incident = t4.num_incident and'
      '   t3.date_move = t4.max_date and'
      '   t1.num_state = t3.num_state and'
      'order by t2.id_incident   desc '
      '      ')
    ReadBuffer = 2500
    QBEDefinition.QBEFieldDefs = {
      040000000F00000006000000574F524B45520100000000000B0000004E414D45
      5F4445564943450100000000000C0000004E554D5F494E434944454E54010000
      0000000A0000004E414D455F434C4153530100000000000A0000004E414D455F
      5343414C45010000000000080000005052494F524954590100000000000B0000
      00444154455F4352454154450100000000000F000000444154455F5245534F4C
      5554494F4E010000000000090000004F574E45525F494E430100000000000A00
      00004E414D455F53544154450100000000000F000000524553504F4E5349424C
      455F494E430100000000000C000000494E434944454E545F5354520100000000
      00090000004E414D455F545950450100000000000B00000049445F494E434944
      454E540100000000000D000000494E434944454E545F54595045010000000000}
    AutoCalcFields = False
    CountAllRecords = True
    Session = OraSession
    DesignActivation = True
    FilterOptions = [foCaseInsensitive]
    Left = 632
    Top = 384
    object OraDataSetNUM_INCIDENT: TFloatField
      DisplayLabel = #8470
      FieldName = 'NUM_INCIDENT'
      Required = True
    end
    object OraDataSetINCIDENT_STRING: TStringField
      FieldName = 'INCIDENT_STR'
      Size = 7
    end
    object OraDataSetNAME_STATE: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      FieldName = 'NAME_STATE'
    end
    object OraDataSetWORKER: TStringField
      DisplayLabel = #1048#1085#1080#1094#1080#1072#1090#1086#1088
      FieldName = 'WORKER'
      Size = 100
    end
    object OraDataSetOWNER_INC: TStringField
      DisplayLabel = #1042#1083#1072#1076#1077#1083#1077#1094
      FieldName = 'OWNER_INC'
      Size = 100
    end
    object OraDataSetRESPONSIBLE_INC: TStringField
      DisplayLabel = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      FieldName = 'RESPONSIBLE_INC'
      Size = 280
    end
    object OraDataSetNAME_DEVICE: TStringField
      DisplayLabel = #1069#1083#1077#1084#1077#1085#1090' '#1080#1085#1092#1088#1072#1089#1090#1088#1091#1082#1090#1091#1088#1099
      FieldName = 'NAME_DEVICE'
      Size = 100
    end
    object OraDataSetDATE_CREATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'DATE_CREATE'
      Required = True
    end
    object OraDataSetDATE_RESOLUTION: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1091#1089#1090#1088#1072#1085#1077#1085#1080#1103
      FieldName = 'DATE_RESOLUTION'
    end
    object OraDataSetNAME_CLASS: TStringField
      DisplayLabel = #1050#1083#1072#1089#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      FieldName = 'NAME_CLASS'
      Size = 80
    end
    object OraDataSetNAME_TYPE: TStringField
      FieldName = 'NAME_TYPE'
      Size = 200
    end
    object OraDataSetNAME_SCALE: TStringField
      DisplayLabel = #1052#1072#1089#1096#1090#1072#1073' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      FieldName = 'NAME_SCALE'
    end
    object OraDataSetPRIORITY: TIntegerField
      DisplayLabel = #1055#1088#1080#1086#1088#1080#1090#1077#1090
      FieldName = 'PRIORITY'
    end
    object OraDataSetINCIDENT_TYPE: TStringField
      FieldName = 'INCIDENT_TYPE'
      Required = True
      Size = 50
    end
  end
  object InitiatorDataSet: TOracleDataSet
    SQL.Strings = (
      'Select * from personnel_view t order by t.worker')
    QBEDefinition.QBEFieldDefs = {
      040000000900000006000000574F524B4552010000000000050000004C4F4749
      4E01000000000005000000454D41494C0100000000000500000050484F4E4501
      00000000000800000049445F47524F5550010000000000060000004143544956
      450100000000000700000049445F574F524B0100000000000700000041444452
      455353010000000000050000004445534352010000000000}
    RefreshOptions = [roBeforeEdit, roAfterInsert, roAfterUpdate, roAllFields]
    Session = OraSession
    DesignActivation = True
    FilterOptions = [foCaseInsensitive]
    Left = 640
    Top = 512
    object InitiatorDataSetID_WORK: TStringField
      FieldName = 'ID_WORK'
      Required = True
      Size = 50
    end
    object InitiatorDataSetWORKER: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      FieldName = 'WORKER'
      Size = 100
    end
    object InitiatorDataSetLOGIN: TStringField
      DisplayLabel = #1051#1086#1075#1080#1085
      FieldName = 'LOGIN'
    end
    object InitiatorDataSetEMAIL: TStringField
      DisplayLabel = #1069#1083#1077#1082#1090#1088#1086#1085#1085#1072#1103' '#1087#1086#1095#1090#1072
      FieldName = 'EMAIL'
      Size = 30
    end
    object InitiatorDataSetPHONE: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE'
    end
    object InitiatorDataSetID_GROUP: TStringField
      FieldName = 'ID_GROUP'
      Required = True
      Size = 50
    end
    object InitiatorDataSetACTIVE: TFloatField
      FieldName = 'ACTIVE'
      Required = True
    end
    object InitiatorDataSetADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 50
    end
    object InitiatorDataSetDESCR: TStringField
      FieldName = 'DESCR'
      Size = 50
    end
  end
  object InitiatorDataSource: TDataSource
    DataSet = InitiatorDataSet
    Left = 640
    Top = 448
  end
  object ElementDataSource: TDataSource
    DataSet = ElementDataSet
    Left = 544
    Top = 448
  end
  object ElementDataSet: TOracleDataSet
    SQL.Strings = (
      'select  * from infrastructure_view')
    QBEDefinition.QBEFieldDefs = {
      040000000400000004000000524F4F4D0100000000000500000050484F4E4501
      00000000000A0000004E554D5F444556494345010000000000080000004E414D
      455F444556010000000000}
    CountAllRecords = True
    RefreshOptions = [roBeforeEdit, roAfterInsert, roAfterUpdate, roAllFields]
    Session = OraSession
    DesignActivation = True
    FilterOptions = [foCaseInsensitive]
    Left = 544
    Top = 512
    object ElementDataSetNAME_DEV: TStringField
      FieldName = 'NAME_DEV'
      Size = 100
    end
    object ElementDataSetROOM: TStringField
      FieldName = 'ROOM'
    end
    object ElementDataSetPHONE: TStringField
      FieldName = 'PHONE'
    end
    object ElementDataSetNUM_DEVICE: TStringField
      FieldName = 'NUM_DEVICE'
      Required = True
      Size = 50
    end
  end
  object ScaleDataSource: TDataSource
    DataSet = ScaleDataSet
    Left = 448
    Top = 448
  end
  object ScaleDataSet: TOracleDataSet
    SQL.Strings = (
      'select '
      '  t.rowid, t.num_scale,t.name_scale '
      'from'
      '  incident_scale t'
      'order by t.num_scale'
      '')
    QBEDefinition.QBEFieldDefs = {
      0400000003000000090000004E554D5F5343414C450100000000000A0000004E
      414D455F5343414C450100000000000B0000004445534352495054494F4E0100
      00000000}
    Session = OraSession
    Left = 448
    Top = 512
    object ScaleDataSetNUM_SCALE: TFloatField
      FieldName = 'NUM_SCALE'
      Required = True
    end
    object ScaleDataSetNAME_SCALE: TStringField
      FieldName = 'NAME_SCALE'
    end
  end
  object OraLogon: TOracleLogon
    Session = OraSession
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093
    Left = 96
    Top = 8
  end
  object OpenFileDialog: TOpenDialog
    Filter = 'All (*.jpg;*.jpeg;*.bmp;*.png)|*.jpg;*.jpeg;*.bmp;*.png'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 632
    Top = 152
  end
  object ResponsibleDataSource: TDataSource
    DataSet = ResponsibleDataSet
    Left = 256
    Top = 448
  end
  object ResponsibleDataSet: TOracleDataSet
    SQL.Strings = (
      
        'select t1.name_class, t2.worker, t3.num_class, t3.id_work from p' +
        'ersonnel_view t2, classifier_view_total_used t1, responsible t3 '
      
        '   where t3.id_work = t2.id_work and t3.num_class = t1.num_class' +
        ' order by t1.name_class'
      '')
    QBEDefinition.QBEFieldDefs = {
      040000000400000006000000574F524B45520100000000000A0000004E414D45
      5F434C415353010000000000090000004E554D5F434C41535301000000000007
      00000049445F574F524B010000000000}
    Session = OraSession
    FilterOptions = [foCaseInsensitive]
    Left = 256
    Top = 512
    object ResponsibleDataSetNAME_CLASS: TStringField
      DisplayLabel = #1050#1083#1072#1089#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      FieldName = 'NAME_CLASS'
      Size = 80
    end
    object ResponsibleDataSetWORKER: TStringField
      DisplayLabel = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      FieldName = 'WORKER'
      Size = 100
    end
    object ResponsibleDataSetNUM_CLASS: TFloatField
      FieldName = 'NUM_CLASS'
      Required = True
    end
    object ResponsibleDataSetID_WORK: TStringField
      FieldName = 'ID_WORK'
      Required = True
      Size = 50
    end
  end
  object OraQuery2: TOracleQuery
    Session = OraSession
    Variables.Data = {0300000001000000040000003A524553040000000000000000000000}
    Left = 16
    Top = 128
  end
  object OraQuery3: TOracleQuery
    Session = OraSession
    Variables.Data = {0300000001000000040000003A504943710000000000000000000000}
    Left = 16
    Top = 192
  end
  object IncGetIDOraQuery: TOracleQuery
    Session = OraSession
    Variables.Data = {
      03000000010000000C0000003A494E434944454E545F49440500000000000000
      00000000}
    Left = 96
    Top = 72
  end
  object AssignDataSet: TOracleDataSet
    SQL.Strings = (
      '   select '
      '     t1.worker, t1.id_work '
      '  from'
      
        '     personnel t1, responsible t2, classifier_view_total_used t3' +
        ' '
      '  where '
      '     t3.name_class = :INCIDENT_CLASS and'
      '     t2.id_work = t1.id_work and'
      #9' t3.num_class = t2.num_class'
      '  order by t1.worker')
    Variables.Data = {
      03000000010000000F0000003A494E434944454E545F434C4153530500000000
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000200000006000000574F524B45520100000000000700000049445F57
      4F524B010000000000}
    Session = OraSession
    Left = 144
    Top = 512
    object AssignDataSetWORKER: TStringField
      DisplayLabel = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081
      FieldName = 'WORKER'
      Size = 100
    end
    object AssignDataSetID_WORK: TStringField
      FieldName = 'ID_WORK'
      Required = True
      Size = 50
    end
  end
  object AssignDataSource: TDataSource
    DataSet = AssignDataSet
    Left = 144
    Top = 448
  end
  object MovementsOraQuery: TOracleQuery
    Session = OraSession
    Left = 96
    Top = 128
  end
  object Timer: TTimer
    Enabled = False
    Interval = 180000
    OnTimer = TimerTimer
    Left = 640
    Top = 72
  end
  object ProgressTimer: TTimer
    Enabled = False
    Interval = 30
    OnTimer = ProgressTimerTimer
    Left = 584
    Top = 72
  end
  object MoveDataSource: TDataSource
    DataSet = MoveDataSet
    Left = 544
    Top = 320
  end
  object MoveDataSet: TOracleDataSet
    SQL.Strings = (
      'select '
      '   t1.rowid,'
      '    t1.num_move,'
      '    t1.description, '
      '    t1.date_move move_date,'
      '    --to_char(t1.date_move,'#39'DD.MM.YY HH24:MI:SS'#39') move_date,'
      '    t2.name_state,'
      '    t3.worker'
      'from'
      '    incident_move_card t1,'
      '    incident_state t2,'
      '    personnel t3'
      'where'
      '   t1.num_incident = :INCIDENT_NUM and'
      '   t2.num_state = t1.num_state and'
      '   t3.id_work = t1.creator_move'
      ' order by  t1.date_move')
    Variables.Data = {
      03000000010000000D0000003A494E434944454E545F4E554D03000000000000
      0000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000005000000090000004D4F56455F444154450100000000000A0000004E
      414D455F535441544501000000000006000000574F524B455201000000000008
      0000004E554D5F4D4F56450100000000000B0000004445534352495054494F4E
      010000000000}
    Session = OraSession
    AfterScroll = MoveDataSetAfterScroll
    Left = 544
    Top = 384
    object MoveDataSetMOVE_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1076#1074#1080#1078#1077#1085#1080#1103
      FieldName = 'MOVE_DATE'
      Required = True
    end
    object MoveDataSetNAME_STATE: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      FieldName = 'NAME_STATE'
    end
    object MoveDataSetWORKER: TStringField
      DisplayLabel = #1050#1090#1086' '#1089#1086#1079#1076#1072#1083
      FieldName = 'WORKER'
      Size = 100
    end
    object MoveDataSetNUM_MOVE: TFloatField
      FieldName = 'NUM_MOVE'
      Required = True
    end
    object MoveDataSetDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 2000
    end
  end
  object Smtp: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Host = 'mail.sxk.ru'
    Port = 25
    AuthenticationType = atNone
    Left = 696
    Top = 8
  end
  object ClassDataSource2: TDataSource
    DataSet = ClassDataSet2
    Left = 32
    Top = 296
  end
  object ClassDataSet2: TOracleDataSet
    SQL.Strings = (
      'select * from classifier_view_total_used where 1=1')
    QBEDefinition.QBEFieldDefs = {
      0400000006000000090000004E554D5F434C4153530100000000000A0000004E
      414D455F434C4153530100000000000B0000004445534352495054494F4E0100
      000000000800000043415445474F52590100000000000700000049445F545950
      45010000000000090000004E414D455F54595045010000000000}
    Session = OraSession
    FilterOptions = [foCaseInsensitive]
    Left = 32
    Top = 352
    object ClassDataSet2NUM_CLASS: TFloatField
      FieldName = 'NUM_CLASS'
      Required = True
    end
    object ClassDataSet2NAME_CLASS: TStringField
      FieldName = 'NAME_CLASS'
      Size = 200
    end
    object ClassDataSet2DESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 200
    end
    object ClassDataSet2CATEGORY: TStringField
      FieldName = 'CATEGORY'
    end
    object ClassDataSet2ID_TYPE: TFloatField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object ClassDataSet2NAME_TYPE: TStringField
      FieldName = 'NAME_TYPE'
      Size = 200
    end
  end
  object ReasonDataSet: TOracleDataSet
    SQL.Strings = (
      'select t.num_source, t.name_source from incident_source t')
    QBEDefinition.QBEFieldDefs = {
      04000000020000000A0000004E554D5F534F555243450100000000000B000000
      4E414D455F534F55524345010000000000}
    Session = OraSession
    Left = 128
    Top = 352
    object ReasonDataSetNUM_SOURCE: TFloatField
      FieldName = 'NUM_SOURCE'
      Required = True
    end
    object ReasonDataSetNAME_SOURCE: TStringField
      FieldName = 'NAME_SOURCE'
      Size = 40
    end
  end
  object ReasonDataSource: TDataSource
    DataSet = ReasonDataSet
    Left = 128
    Top = 296
  end
  object DateTimeOraQuery: TOracleQuery
    Session = OraSession
    Variables.Data = {
      0300000001000000090000003A4441544554494D450A00000000000000000000
      00}
    Left = 96
    Top = 192
  end
  object frxReport: TfrxReport
    Version = '3.20'
    DotMatrixReport = False
    EngineOptions.PrintIfEmpty = False
    EngineOptions.SilentMode = True
    EngineOptions.NewSilentMode = simSilent
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    ReportOptions.CreateDate = 39113.721881030090000000
    ReportOptions.LastChange = 39114.549528287040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 352
    Top = 16
    Datasets = <>
    Variables = <>
    Style = <>
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
  object frxDesigner: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    Restrictions = []
    RTLLanguage = False
    OnSaveReport = frxDesignerSaveReport
    Left = 296
    Top = 16
  end
  object ReportsDataSource: TDataSource
    DataSet = ReportsDataSet
    Left = 432
    Top = 16
  end
  object ReportsDataSet: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWID, ID, NAME, REPORTGROUPS, TRANCREATOR, '
      
        '-- '#1044#1083#1103' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1074#1077#1088#1089#1080#1080' FastReport'#39#1072' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1090#1086#1090' '#1078#1077' '#1084#1077#1090#1086#1076 +
        ', '#1095#1090#1086' '#1080' '
      
        '-- '#1074' '#1092#1072#1081#1083#1077' frx2xto30.pas ('#1080#1079' '#1082#1086#1084#1087#1083#1077#1082#1090#1072' FastReport3): '#1076#1083#1103' FR2.x '#1087 +
        #1077#1088#1074#1099#1081' '
      
        '-- '#1073#1072#1081#1090' '#1087#1086#1090#1086#1082#1072', '#1074' '#1082#1086#1090#1086#1088#1086#1084' '#1089#1086#1093#1088#1072#1085#1077#1085#1072' '#1092#1086#1088#1084#1072' '#1086#1090#1095#1077#1090#1072', '#1076#1086#1083#1078#1077#1085' '#1073#1099#1090#1100' '#1084#1077 +
        #1085#1100#1096#1077
      '-- 30 (1E hex).'
      'TO_NUMBER(CASE'
      '            WHEN SOURCE IS NULL THEN 4'
      
        '            WHEN DBMS_LOB.SUBSTR(SOURCE, 1, 1) < HEXTORAW('#39'1E'#39') ' +
        'THEN 2'
      '            ELSE 3'
      '          END) FASTREPORT_VERSION'
      'FROM REPORTFORMS RFRMS'
      'ORDER BY NVL(REPORTGROUPS,-1), NAME')
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'SEQ_REPORTS'
    QBEDefinition.QBEFieldDefs = {
      0400000005000000020000004944010000000000040000004E414D4501000000
      00000C0000005245504F525447524F5550530100000000000B0000005452414E
      43524541544F5201000000000012000000464153545245504F52545F56455253
      494F4E010000000000}
    Session = OraSession
    Left = 432
    Top = 72
  end
  object QryCreateReportAsCopy: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  :V_NEW_ID := REPORTS_PACKAGE.InsertReportAsCopy(:V_ID, :V_NAME' +
        ', :V_REPORTGROUPS);'
      'end;')
    Session = OraSession
    Variables.Data = {
      0300000004000000050000003A565F4944030000000000000000000000070000
      003A565F4E414D450500000000000000000000000F0000003A565F5245504F52
      5447524F555053030000000000000000000000090000003A565F4E45575F4944
      030000000000000000000000}
    Left = 320
    Top = 72
  end
  object BlobDataSet: TOracleDataSet
    SQL.Strings = (
      
        'SELECT ROWID, SOURCE, TRANCREATOR FROM reportforms where id = :i' +
        'd')
    Variables.Data = {0300000001000000030000003A4944030000000000000000000000}
    Session = OraSession
    Left = 320
    Top = 128
  end
  object frxDialogControls: TfrxDialogControls
    Left = 216
    Top = 16
  end
  object UserInfoDataSource: TDataSource
    DataSet = UserInfoDataSet
    Left = 304
    Top = 264
  end
  object UserInfoDataSet: TOracleDataSet
    SQL.Strings = (
      
        'SELECT p.worker, p.phone,p.email,p.address, p.descr, g.descripti' +
        'on || '#39' ('#39' || g.name_group ||'#39') '#39' "DEPT"'
      ''
      ' FROM personnel p, group_users g WHERE id_work=:ID AND'
      'g.id_group = p.id_group')
    Variables.Data = {0300000001000000030000003A4944050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000600000006000000574F524B45520100000000000500000050484F4E
      4501000000000005000000454D41494C01000000000007000000414444524553
      5301000000000004000000444550540100000000000500000044455343520100
      00000000}
    Session = OraSession
    FilterOptions = [foCaseInsensitive]
    Left = 408
    Top = 264
    object UserInfoDataSetWORKER: TStringField
      FieldName = 'WORKER'
      Size = 100
    end
    object UserInfoDataSetPHONE: TStringField
      FieldName = 'PHONE'
      Size = 30
    end
    object UserInfoDataSetEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 30
    end
    object UserInfoDataSetADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 50
    end
    object UserInfoDataSetDEPT: TStringField
      FieldName = 'DEPT'
      Size = 304
    end
    object UserInfoDataSetDESCR: TStringField
      FieldName = 'DESCR'
      Size = 50
    end
  end
  object frxChartObject: TfrxChartObject
    Left = 216
    Top = 72
  end
end
