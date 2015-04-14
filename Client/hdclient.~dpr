program hdclient;

uses
  Forms,
  Windows,
  Oracle,
  Dialogs,
  SysUtils,
  System,
  main in 'main.pas' {MainForm},
  register in 'register.pas' {RegisterForm},
  global in 'global.pas' {Module: TDataModule},
  initiator_selection in 'initiator_selection.pas' {InitiatorSelectionForm},
  element_selection in 'element_selection.pas' {ElementSelectionForm},
  date_selection in 'date_selection.pas' {CalendarForm},
  incident_move in 'incident_move.pas' {IncidentMoveForm},
  ADSLib_TLB in 'ADSLib_TLB.pas',
  user in 'user.pas',
  showimage in 'showimage.pas' {ImageForm},
  responsible in 'responsible.pas' {ResponsibleForm},
  add_responsible in 'add_responsible.pas' {ResponsibleAddForm},
  progress in 'progress.pas' {ProgressForm},
  assign in 'assign.pas' {AssignForm},
  main_filter in 'main_filter.pas' {MainFormFilter},
  settings in 'settings.pas',
  initiator_filter in 'initiator_filter.pas' {InitiatorFormFilter},
  element_filter in 'element_filter.pas' {ElementFormFilter},
  responsible_filter in 'responsible_filter.pas' {ResponsibleFormFilter},
  Word_TLB in 'Word_TLB.pas',
  class_selection in 'class_selection.pas' {ClassSelectionForm},
  class_filter in 'class_filter.pas' {ClassFormFilter},
  options in 'options.pas' {OptionsForm},
  fast_filter in 'fast_filter.pas' {FastFilterForm},
  logon in 'logon.pas' {LoginForm},
  reason in 'reason.pas' {ReasonForm},
  scale_selection in 'scale_selection.pas' {ScaleSelectionForm},
  save_main_filter in 'save_main_filter.pas' {SaveFilterForm},
  request in 'request.pas' {RequestForm},
  reports in 'reports.pas' {ReportForm},
  report_add in 'report_add.pas' {ReportAddForm},
  user_info in 'user_info.pas' {UserInfoForm};

{$R *.res}

var
  GMutex : THandle;


function CheckExists : boolean;
begin

  GMutex := OpenMutex(MUTEX_ALL_ACCESS,false, 'Helpdesk_mutex');
  if (GMutex = 0) then
  begin
    GMutex := CreateMutex(nil,false,'Helpdesk_mutex');
    if (GMutex = 0) then
    begin
      if (GetLastError() = ERROR_ALREADY_EXISTS) then
      begin
        Result := true;
        exit;
      end;
    end;
  end
  else
  begin
    Result := true;
    exit;
  end;
  Result := false;
end;



begin
  Application.Initialize;

  if CheckExists then
  begin
    Application.MessageBox('Программа Helpdesk уже запущена','Ошибка', MB_ICONERROR);
    Application.Terminate;
  end;

  Application.CreateForm(TModule, Module);
  GCommonSettings := TCommonSettings.Create('general.ini');
  GCommonSettings.Load;


  LoginForm := TLoginForm.Create( Application );
  LoginForm.UserName := GCommonSettings.LastLogin;
  LoginForm.DB := GCommonSettings.LastDB;
  LoginForm.ShowModal;

  if not LoginForm.Cancel then
  begin

    Module.OraSession.LogonUsername := LoginForm.UserNameEdit.Text;
    Module.OraSession.LogonPassword := LoginForm.PasswordEdit.Text;
    Module.OraSession.LogonDatabase := LoginForm.DBEdit.Text;

    try
       Module.OraSession.LogOn;
    except
       if ( Module.OraSession.ReturnCode = 1017 ) then
         Application.MessageBox('Неправильный логин/пароль','Ошибка подключения к базе данных', MB_ICONERROR)
       else
         Application.MessageBox(PChar( Module.OraSession.ErrorMessage(
         Module.OraSession.ReturnCode)),'Ошибка подключения к базе данных', MB_ICONERROR);
       Application.Terminate;
       exit;
    end;

    if not Module.OraSession.Connected then
    begin
       Application.Terminate;
       exit;
     end
     else
     begin

      GSettings := TGeneralSettings.Create(Module.OraSession.LogonUsername +'.ini');
      GSettings.Load;


      // Проверка версии
      if Module.CheckActualVersion then
      begin
          GUser := TUser.Create;
          if GUser.IsCompetent then
          begin
            if GUser.IsAtomsibUser then
            begin

              // TDataSet
              // Save login
              GCommonSettings.LastLogin := Module.OraSession.LogonUsername;

              Application.CreateForm(TMainForm, MainForm);

              if (GUser.UserRole >= HD_NOMINATOR) then
              begin
                  Application.CreateForm(TAssignForm, AssignForm);
                  if (GUser.UserRole >= HD_REGISTRATOR)  then
                  begin
                      Application.CreateForm(TScaleSelectionForm, ScaleSelectionForm);
                      Application.CreateForm(TReasonForm, ReasonForm);
                      Application.CreateForm(TRegisterForm, RegisterForm);
                      Application.CreateForm(TRequestForm, RequestForm);
                      Application.CreateForm(TInitiatorFormFilter, InitiatorFormFilter);
                      Application.CreateForm(TInitiatorSelectionForm, InitiatorSelectionForm);
                      Application.CreateForm(TElementFormFilter, ElementFormFilter);
                      Application.CreateForm(TElementSelectionForm, ElementSelectionForm);
                      Application.CreateForm(TClassFormFilter, ClassFormFilter);
                      Application.CreateForm(TClassSelectionForm, ClassSelectionForm);

                        if (GUser.UserRole >= HD_MANAGER) then
                        begin
                          Application.CreateForm(TResponsibleFormFilter, ResponsibleFormFilter);
                          Application.CreateForm(TResponsibleForm, ResponsibleForm);
                          Application.CreateForm(TResponsibleAddForm, ResponsibleAddForm);
                          if (GUser.UserRole >= HD_ADMIN) then
                             Application.CreateForm(TReportAddForm, ReportAddForm);
                       end;
                   end;
               end;
              Application.CreateForm(TSaveFilterForm, SaveFilterForm);
              Application.CreateForm(TCalendarForm, CalendarForm);
              Application.CreateForm(TFastFilterForm, FastFilterForm);
              Application.CreateForm(TMainFormFilter, MainFormFilter);
              Application.CreateForm(TProgressForm, ProgressForm);
              Application.CreateForm(TIncidentMoveForm, IncidentMoveForm);
              Application.CreateForm(TImageForm, ImageForm);
              Application.CreateForm(TOptionsForm, OptionsForm);
              Application.CreateForm(TUserInfoForm, UserInfoForm);

              if (HD_REPORTVIEW in GUser.ExtraRoles) or (GUser.UserRole = HD_ADMIN) then
                   Application.CreateForm(TReportForm, ReportForm);


            // Запускаем таймер обновлений
              Module.Timer.Enabled := true;

              Application.Run;

              GCommonSettings.Save;
              GSettings.Save;
            end
            else
              Application.MessageBox('Данный пользователь не является членом домена ATOMSIB','Ошибка');
          end
          else
            Application.MessageBox('У вас недостаточно прав для работы с приложением', 'Ошибка');
      end;
    end;
  end;
end.
