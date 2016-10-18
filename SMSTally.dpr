program SMSTally;

uses
  Forms, Windows,
  Main in 'Main.pas' {MAIN_FORM},
  DM in 'DM.pas' {DataModule1: TDataModule};

{$R *.RES}

{var
  Mutex : THandle;}
begin
{  Mutex := CreateMutex(nil, True, 'SMS_Tally');
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then Exit;}

  Application.Initialize;
  Application.Title := 'EBC SMS Tally';
  Application.CreateForm(TDataModule1, DM1);
  Application.CreateForm(TMAIN_FORM, MAIN_FORM);
  Application.Run;
end.
