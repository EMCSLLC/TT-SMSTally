program SMSTally;

uses
  Forms,
  Main in 'Main.pas' {MAIN_FORM},
  DM in 'DM.pas' {DataModule1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'EBC SMS Tally';
  Application.CreateForm(TDataModule1, DM1);
  Application.CreateForm(TMAIN_FORM, MAIN_FORM);
  Application.Run;
end.
