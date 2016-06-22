unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RzCmboBx, RzLabel, RzButton, ExtCtrls, Grids, Wwdbigrd,
  Wwdbgrid, RzPanel, RzRadGrp, DBCtrls, DB, ComCtrls, RzDBLbl, RzRadChk,
  GraphicEx, Placemnt;

type
  TMAIN_FORM = class(TForm)
    pnl_POLLS: TPanel;
    Panel5: TPanel;
    btnCLOSE: TRzBitBtn;
    pnl_DISTRICT: TPanel;
    RzLabel1: TRzLabel;
    cb_District: TRzComboBox;
    POLLS: TwwDBGrid;
    rg_STATUS: TRzRadioGroup;
    Timer1: TTimer;
    TABS: TPageControl;
    TabPoll: TTabSheet;
    Panel1: TPanel;
    NAME1: TDBText;
    VOTE1: TDBText;
    NAME2: TDBText;
    NAME3: TDBText;
    NAME4: TDBText;
    NAME5: TDBText;
    NAME6: TDBText;
    NAME7: TDBText;
    VOTE2: TDBText;
    VOTE3: TDBText;
    VOTE4: TDBText;
    VOTE5: TDBText;
    VOTE6: TDBText;
    VOTE7: TDBText;
    Label1: TLabel;
    TabLog: TTabSheet;
    wwDBGrid1: TwwDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    btn_NEW_PHONE: TRzButton;
    bnt_UNLOCK: TRzButton;
    cb_POLLS: TRzComboBox;
    cb_PHONE: TRzComboBox;
    RzDBLabel1: TRzDBLabel;
    RzDBLabel2: TRzDBLabel;
    Panel3: TPanel;
    RzDBLabel3: TRzDBLabel;
    TabCONFIG: TTabSheet;
    ck_PROCESSING: TRzCheckBox;
    ck_TALLY_OPEN: TRzCheckBox;
    RzDBLabel4: TRzDBLabel;
    Locked: TImage;
    process: TImage;
    Placement: TFormPlacement;
    RzDBLabel5: TRzDBLabel;
    DBMemo1: TDBMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnREFRESH: TRzBitBtn;
    btnSAVE: TRzBitBtn;
    Label7: TLabel;
    smsMSG: TMemo;
    nothing: TImage;
    SB: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCLOSEClick(Sender: TObject);
    procedure cb_DistrictChange(Sender: TObject);
    procedure rg_STATUSClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure POLLSRowChanged(Sender: TObject);
    procedure TABSChange(Sender: TObject);
    procedure cb_POLLSChange(Sender: TObject);
    procedure cb_PHONEChange(Sender: TObject);
    procedure btn_NEW_PHONEClick(Sender: TObject);
    procedure bnt_UNLOCKClick(Sender: TObject);
    procedure btnREFRESHClick(Sender: TObject);
    procedure btnSAVEClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MAIN_FORM: TMAIN_FORM;

implementation

uses DM;

{$R *.DFM}

procedure TMAIN_FORM.FormCreate(Sender: TObject);
var
  ct : integer;
begin
  SB.Caption := ' VERSION: ' + DM1.VersionNumber;
  DM1.ADOConnection.Connected := True;

  for ct := 1 to 7 do
    begin
      DM1.UTIL.Close;
      DM1.UTIL.SQL.Text := 'SELECT column_id FROM sys.columns WHERE Name = ' + QuotedStr('name' + IntToStr(ct)) +'  AND Object_ID = Object_ID(' + QuotedStr('CActive') +')';
      DM1.UTIL.Open;
      if DM1.UTIL.FieldByname('Column_id').AsInteger > 0 then
         begin
           case ct of
             1 : begin
                   NAME1.Enabled := True; NAME1.DataSource := DM1.CActive_DS; NAME1.Visible := True;
                   VOTE1.Enabled := True; VOTE1.DataSource := DM1.CActive_DS; VOTE1.Visible := True;
                 end;
             2 : begin
                   NAME2.Enabled := True; NAME2.DataSource := DM1.CActive_DS; NAME2.Visible := True;
                   VOTE2.Enabled := True; VOTE2.DataSource := DM1.CActive_DS; VOTE2.Visible := True;
                 end;
             3 : begin
                   NAME3.Enabled := True; NAME3.DataSource := DM1.CActive_DS; NAME3.Visible := True;
                   VOTE3.Enabled := True; VOTE3.DataSource := DM1.CActive_DS; VOTE3.Visible := True;
                 end;
             4 : begin
                   NAME4.Enabled := True; NAME4.DataSource := DM1.CActive_DS; NAME4.Visible := True;
                   VOTE4.Enabled := True; VOTE4.DataSource := DM1.CActive_DS; VOTE4.Visible := True;
                 end;
             5 : begin
                   NAME5.Enabled := True; NAME5.DataSource := DM1.CActive_DS; NAME5.Visible := True;
                   VOTE5.Enabled := True; VOTE5.DataSource := DM1.CActive_DS; VOTE5.Visible := True;
                 end;
             6 : begin
                   NAME6.Enabled := True; NAME6.DataSource := DM1.CActive_DS; NAME6.Visible := True;
                   VOTE6.Enabled := True; VOTE6.DataSource := DM1.CActive_DS; VOTE6.Visible := True;
                 end;
             7 : begin
                   NAME7.Enabled := True; NAME7.DataSource := DM1.CActive_DS; NAME7.Visible := True;
                   VOTE7.Enabled := True; VOTE7.DataSource := DM1.CActive_DS; VOTE7.Visible := True;
                 end;
           end; {case}
         end;
    end;

  cb_District.Items.Clear;
  with DM1.DISTRICTS do
    begin
      Open;
      while not DM1.DISTRICTS.eof do
        begin
          cb_District.Items.Add(DM1.DISTRICTS.FieldByName('DISTRICT').AsString);
          DM1.DISTRICTS.Next;
        end;
      Close;
    end;

  cb_POLLS.Items.Clear;
  DM1.UTIL.Close;
  DM1.UTIL.SQL.Text := 'SELECT POLL FROM Users ORDER BY POLL';
  with DM1.UTIL do
    begin
      Open;
      while not DM1.UTIL.eof do
        begin
          cb_POLLS.Items.Add(DM1.UTIL.FieldByName('POLL').AsString);
          DM1.UTIL.Next;
        end;
      Close;
    end;

  cb_PHONE.Items.Clear;
  DM1.UTIL.Close;
  DM1.UTIL.SQL.Text := 'SELECT DISTINCT PHONE FROM vw_ALL_PHONES WHERE PHONE IS NOT NULL ORDER BY PHONE';
  with DM1.UTIL do
    begin
      Open;
      while not DM1.UTIL.eof do
        begin
          cb_PHONE.Items.Add(DM1.UTIL.FieldByName('PHONE').AsString);
          DM1.UTIL.Next;
        end;
      Close;
    end;
   cb_District.ItemIndex := 0;
   cb_DistrictChange(Sender);
   btnREFRESHClick(Sender);
end;

procedure TMAIN_FORM.btnCLOSEClick(Sender: TObject);
begin
  Close;
end;

procedure TMAIN_FORM.cb_DistrictChange(Sender: TObject);
begin
  rg_STATUS.Enabled := cb_dISTRICT.ItemIndex > -1;

  cb_PHONE.ItemIndex := -1;
  cb_POLLS.ItemIndex := -1;

  DM1.POLLS.Close;
  DM1.POLLS.Parameters[0].Value := cb_District.Text;
  DM1.POLLS.Parameters[1].Value := '';
  DM1.POLLS.Parameters[2].Value := '';
  DM1.POLLS.Open;
end;

procedure TMAIN_FORM.rg_STATUSClick(Sender: TObject);
begin
  DM1.POLLS.Filtered := False;
  DM1.POLLS.Filter := '';
  
  if cb_District.ItemIndex < 0 then exit;

  if rg_STATUS.ItemIndex = 0 then Exit;

  if rg_STATUS.ItemIndex = 1 then
   DM1.POLLS.Filter := 'POLLOC = NULL';
  if rg_STATUS.ItemIndex = 2 then
   DM1.POLLS.Filter := '((ID > 0) AND (SAV < 2))';
  if rg_STATUS.ItemIndex = 3 then
   DM1.POLLS.Filter := '((SAV = 2) AND (DONE = 1))';

  DM1.POLLS.Filtered := True;
  DM1.POLLS.Requery;
  Timer1Timer(NIL);
end;

procedure TMAIN_FORM.Timer1Timer(Sender: TObject);
var
  savePoll : TBookmark;
  Running  : Integer;
begin

   if not CK_PROCESSING.Checked then
     begin
        SB.Color := clRed;
        SB.Font.Color := clYellow;
        SB.Caption := ' VERSION: ' + DM1.VersionNumber + '  -  SMS OFF-LINE';
     end
   else
     begin
       if CK_TALLY_OPEN.Checked then
         begin
           SB.Color := clGreen;
           SB.Font.Color := clWhite;
           SB.Caption := ' VERSION: ' + DM1.VersionNumber + '  -  ACCEPTING SMS TALLY RESULTS';
         end
       else
         begin
           SB.Color := clYellow;
           SB.Font.Color := clRed;
           SB.Caption := ' VERSION: ' + DM1.VersionNumber + '  -  SMS NOT PROCESSING TALLIES';
         end;
     end;

  TRY
  DM1.AppCaption.Close;
  DM1.AppCaption.Open;
  MAIN_FORM.Caption := DM1.AppCaption.FieldByName('Caption').AsString;
  DM1.AppCaption.Close;
  EXCEPT
    MAIN_FORM.Caption :=  'EBC SMS Tally Management';
  END;

  DM1.IsRunning.Close;
  DM1.IsRunning.Open;
  Running := DM1.IsRunning.FieldByName('Running').AsInteger;
  DM1.IsRunning.Close;

  if Running <> 1 then
    begin
      SB.Color := clRed;
      SB.Font.Color := clYellow;
      SB.Caption := ' VERSION: ' + DM1.VersionNumber + '  -  * * * SMS NOT PROCESSING MESSAGES * * *!';
    end;

  if DM1.POLLS.Active then
    begin
      savePoll := DM1.POLLS.GetBookmark;
      LockWindowUpdate(Application.MainForm.Handle);
      DM1.POLLS.Requery;
      if DM1.POLLS.RecordCount > 0 then
        DM1.POLLS.GotoBookmark(SavePoll);
      if DM1.CActive.Active then DM1.CActive.Requery;

      Process.visible := (DM1.CActive.FieldByname('polloc').AsString > '');
      Locked.Visible := DM1.CActive.Active and (DM1.CActive.FieldByname('SAV').AsInteger = 2);
      Nothing.Visible := ((not Locked.Visible) and (not Process.visible));

      bnt_UNLOCK.Enabled := Locked.Visible;
      btn_NEW_PHONE.Enabled := not Locked.Visible;
      TABSChange(Nil);

      LockWindowUpdate(0);
    end;
end;

procedure TMAIN_FORM.POLLSRowChanged(Sender: TObject);
begin
  Process.visible := False;
  Locked.visible := False;
  Nothing.visible := False;
  Application.ProcessMessages;
  DM1.CActive.Close;
  DM1.CActive.Parameters[0].Value := DM1.POLLS.FieldByName('PID').AsString;
  DM1.CActive.Open;

  //Locked.Visible := DM1.CActive.Active and (DM1.CActive.FieldByname('SAV').AsInteger = 2);

  Process.visible := (DM1.CActive.FieldByname('polloc').AsString > '');
  Locked.Visible := DM1.CActive.Active and (DM1.CActive.FieldByname('SAV').AsInteger = 2);
  Nothing.Visible := ((not Locked.Visible) and (not Process.visible));


  bnt_UNLOCK.Enabled := Locked.Visible;
  btn_NEW_PHONE.Enabled := not bnt_UNLOCK.Enabled;

  Nothing.Visible := ((not Locked.Visible) and (not Process.visible));

  TABSChange(Nil);

end;



procedure TMAIN_FORM.TABSChange(Sender: TObject);
begin
  if (TABS.ActivePage = TabLog) then
    begin
        DM1.ActiviteLog.Close;
        if (DM1.POLLS.Active AND (DM1.POLLS.FieldByName('ID').AsString > '')
          AND ((DM1.POLLS.FieldByName('TELEPHONE').AsString > '') OR (DM1.POLLS.FieldByName('ALT_PHONE').AsString > ''))) then
          begin
            DM1.ActiviteLog.Filter := 'CActiveID = ' + DM1.POLLS.FieldByName('ID').AsString;
           // DM1.ActiviteLog.Filter := '((CActiveID = ''' + DM1.POLLS.FieldByName('ID').AsString + ''') AND ((ENTRY LIKE ''' + DM1.POLLS.FieldByName('TELEPHONE').AsString + '%'' ) OR ' +
           //                           '(ENTRY LIKE ''' + DM1.POLLS.FieldByName('ALT_PHONE').AsString + '%'' )))';
           //ShowMessage(DM1.ActiviteLog.Filter);
          end
        else DM1.ActiviteLog.Filter := 'CActiveID = -999';
        DM1.ActiviteLog.Open;
    end
  else DM1.ActiviteLog.Close;
end;

procedure TMAIN_FORM.cb_POLLSChange(Sender: TObject);
begin
  Process.visible := False;
  Locked.visible := False;

  cb_DISTRICT.ItemIndex := -1;
  cb_PHONE.ItemIndex := -1;

  rg_STATUS.ItemIndex := 0;
  rg_STATUS.Enabled :=  False;

  DM1.POLLS.Close;
  DM1.POLLS.Parameters[0].Value := '';
  DM1.POLLS.Parameters[1].Value := cb_POLLS.Text;
  DM1.POLLS.Parameters[2].Value := 'X';
  DM1.POLLS.Parameters[3].Value := 'X';
  DM1.POLLS.Open;
  TABSChange(Nil);
end;



procedure TMAIN_FORM.cb_PHONEChange(Sender: TObject);
begin
  Process.visible := False;
  Locked.visible := False;

  cb_DISTRICT.ItemIndex := -1;
  cb_POLLS.ItemIndex := -1;

  rg_STATUS.ItemIndex := 0;
  rg_STATUS.Enabled :=  False;

  DM1.POLLS.Close;
  DM1.POLLS.Parameters[0].Value := '';
  DM1.POLLS.Parameters[1].Value := '';
  DM1.POLLS.Parameters[2].Value := cb_PHONE.Text;
  DM1.POLLS.Parameters[3].Value := cb_PHONE.Text;
  DM1.POLLS.Open;
  TABSChange(Nil);
end;

procedure TMAIN_FORM.btn_NEW_PHONEClick(Sender: TObject);
var
  InputString: string;

  function IsValidEntry(s:String):Boolean;
  var
    n:Integer;
  begin
    result := true;
    for n := 1 to Length(s) do begin
      if (s[n] < '0') or (s[n] > '9') then
      begin
         result := false;
         exit;
      end;
    end;
  end;

begin

  if (not DM1.POLLS.Active) or (DM1.POLLS.RecordCount < 1) then
    begin
      MessageDlg('First select a Poll Location record.', mtInformation	, [mbOk], 0);
      Exit;
    end;

  InputString:= InputBox('POLL LOCATION:' + DM1.POLLS.FieldByname('POLL').AsString, 'Enter the new phone number to use for this location', DM1.POLLS.FieldByname('TELEPHONE').AsString);

  if (InputString <> DM1.POLLS.FieldByname('TELEPHONE').AsString) then
    begin
        if (length(InputString) = 11) then
          begin
            if not IsValidEntry(InputString) then
               begin
                 Beep;
                 MessageDlg('(' + InputString + ') is not a valid telephone number', mtError, [mbCancel], 0);
                 Exit;
               end;

             with DM1.UTIL do
               begin
                 Close;
                 SQL.Text := 'SELECT PHONE1, POLL FROM Users WHERE PHONE1 = ' + QuotedStr(InputString);
                 Open;
                 if FieldByName('PHONE1').AsString > ''  then
                   begin
                     Beep;
                     MessageDlg('This telephone number (' + InputString + ')' + #10#13#10#13 +
                                'is already being used by' + #10#13#10#13 +
                                'another poll location [' + TRIM(FieldByName('POLL').AsString) + ']!', mtError, [mbCancel], 0);
                     Close;
                     Exit;
                   end;
                 Close;
                end;

             if MessageDlg('* * * ARE YOU SURE YOU WANT TO * * *' + #10#13#10#13 +
                           'Replace ' + DM1.POLLS.FieldByname('TELEPHONE').AsString +
                           ' with ' + InputString + #10#13#10#13 +
                           'POLL LOCATION:' + DM1.POLLS.FieldByname('POLL').AsString + '?', mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
               begin

                 if MessageDlg('* * * THIS PROCESS "CAN NOT" BE UNDONE * * *'  + #10#13#10#13 +
                               'Replace ' + DM1.POLLS.FieldByname('TELEPHONE').AsString +
                               ' with ' + InputString + #10#13#10#13 +
                               'POLL LOCATION:' + DM1.POLLS.FieldByname('POLL').AsString + '?', mtWarning, [mbYes, mbCancel], 0) = mrYes then
                     begin
                       DM1.ADOCommand.CommandText := 'DELETE CActive WHERE polloc = ' + QuotedStr(DM1.POLLS.FieldByname('POLL').AsString);
                       DM1.ADOCommand.Execute;

                       DM1.ADOCommand.CommandText := 'UPDATE Users SET PHONE1 = ' + QuotedStr(InputString) + ', ' +
                                                     ' PHONE2 = ' + QuotedStr(DM1.POLLS.FieldByname('TELEPHONE').AsString) +
                                                     ' WHERE POLL = ' + QuotedStr(DM1.POLLS.FieldByname('POLL').AsString);
                       DM1.ADOCommand.Execute;

                       DM1.ADOCommand.CommandText :=  'INSERT INTO dbo.CActiveLog (entry) VALUES (' + QuotedStr(InputString + ' *System changed telephone number from ' + DM1.POLLS.FieldByname('TELEPHONE').AsString) +  ')';
                       DM1.ADOCommand.Execute;

                       cb_PHONE.Items.Clear;
                       DM1.UTIL.Close;
                       DM1.UTIL.SQL.Text := 'SELECT PHONE1 FROM Users WHERE RTRIM(PHONE1) > '''' ORDER BY PHONE1';
                       with DM1.UTIL do
                         begin
                           Open;
                           while not DM1.UTIL.eof do
                             begin
                               cb_PHONE.Items.Add(DM1.UTIL.FieldByName('PHONE1').AsString);
                               DM1.UTIL.Next;
                             end;
                           Close;
                         end;
                         cb_POLLS.Text := '';
                         cb_PHONE.Text := InputString;
                     end
                   else MessageDlg('Process canceled!', mtConfirmation, [mbOk], 0);
               end
             else MessageDlg('Process canceled!', mtConfirmation, [mbOk], 0);
          end
        else MessageDlg('(' + InputString + ') is not a valid telephone number', mtConfirmation, [mbOk], 0);
    end
  else MessageDlg('No change detected.. Process canceled!', mtConfirmation, [mbOk], 0);
end;

procedure TMAIN_FORM.bnt_UNLOCKClick(Sender: TObject);
var PID, POLL : String;
begin
  if (not DM1.POLLS.Active) or (DM1.POLLS.RecordCount < 1) then
    begin
      MessageDlg('First select a Poll Location record.', mtInformation	, [mbOk], 0);
      Exit;
    end;

  Beep;
  PID := DM1.POLLS.FieldByname('PID').AsString;
  POLL:= DM1.POLLS.FieldByname('POLL').AsString;
  if MessageDlg('* * * ARE YOU SURE YOU WANT TO * * *' + #10#13#10#13 + 'RE-START TALLY for Poll Location ' + POLL + '?', mtConfirmation , [mbYes, mbCancel], 0) = mrYes then
    begin
      Beep;
      if MessageDlg('* * * THIS PROCESS "CAN NOT" BE UNDONE * * *' + #10#13#10#13 + 'RE-START TALLY for Poll Location ' + POLL + '?', mtWarning, [mbYes, mbCancel], 0) = mrYes then
        begin
          DM1.ADOCommand.CommandText := 'DELETE CActive WHERE polloc = ' + QuotedStr(PID);
          DM1.ADOCommand.Execute;

          DM1.ADOCommand.CommandText :=  'INSERT INTO dbo.CActiveLog (entry) VALUES (''' + '*System "RE-STARTED" Tally for (' + POLL + ')'')';
          DM1.ADOCommand.Execute;
        end
      else
        begin
          MessageDlg('Process canceled!', mtConfirmation, [mbOk], 0);
          Exit;
        end;
    end
  else MessageDlg('Process canceled', mtConfirmation, [mbOk], 0);

end;

procedure TMAIN_FORM.btnREFRESHClick(Sender: TObject);
begin
   DM1.UTIL.Close;
   DM1.UTIL.SQL.Text := 'SELECT TOP 1 TALLY_CLOSED_MSG, CAST(TALLY_OPEN AS INT) AS TALLY_OPEN, CAST(PROCESSING AS INT) AS PROCESSING FROM Config';
   DM1.UTIL.Open;
        CK_PROCESSING.Checked := (DM1.UTIL.FieldByName('PROCESSING').AsInteger = 1);
        CK_TALLY_OPEN.Checked := (DM1.UTIL.FieldByName('TALLY_OPEN').AsInteger = 1);
        smsMSG.Lines.Text     :=  DM1.UTIL.FieldByName('TALLY_CLOSED_MSG').AsString;
   DM1.UTIL.Close;
end;

procedure TMAIN_FORM.btnSAVEClick(Sender: TObject);
begin
  BEEP();
end;

end.


