unit DM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, ExtCtrls;

type
  TDataModule1 = class(TDataModule)
    ADOConnection: TADOConnection;
    DISTRICT_DS: TDataSource;
    DISTRICTS: TADOQuery;
    POLLS: TADOQuery;
    POLLS_DS: TDataSource;
    CActive_DS: TDataSource;
    CActive: TADOQuery;
    ActiviteLog: TADOQuery;
    LOG_DS: TDataSource;
    ActiviteLogID: TAutoIncField;
    ActiviteLogLOGDT: TDateTimeField;
    ActiviteLogENTRY: TStringField;
    UTIL: TADOQuery;
    ADOCommand: TADOCommand;
    ActiviteLogCActiveID: TIntegerField;
    IsRunning: TADOQuery;
    AppCaption: TADOQuery;
    ADOIntegrity: TADOConnection;
    CMDIntegrity: TADOCommand;
    Timer1: TTimer;
    SMS_TALLY: TADODataSet;
    Function VersionNumber : String;
    procedure Timer1Timer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iAUTO_UPDATE : Boolean;
  end;

var
  DM1: TDataModule1;

implementation

{$R *.DFM}

Function TDataModule1.VersionNumber : String;

    procedure GetBuildInfo(var V1, V2, V3, V4: word);
    var
      VerInfoSize, VerValueSize, Dummy: DWORD;
      VerInfo: Pointer;
      VerValue: PVSFixedFileInfo;
    begin
      VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
      if VerInfoSize > 0 then
      begin
          GetMem(VerInfo, VerInfoSize);
          try
            if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
            begin
              VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
              with VerValue^ do
              begin
                V1 := dwFileVersionMS shr 16;
                V2 := dwFileVersionMS and $FFFF;
                V3 := dwFileVersionLS shr 16;
                V4 := dwFileVersionLS and $FFFF;
              end;
            end;
          finally
            FreeMem(VerInfo, VerInfoSize);
          end;
      end;
    end;

    function GetBuildInfoAsString: string;
    var
      V1, V2, V3, V4: word;
    begin
      GetBuildInfo(V1, V2, V3, V4);
      Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +
        IntToStr(V3) + '.' + IntToStr(V4);
    end;
begin
  VersionNumber :=  GetBuildInfoAsString;
end;

procedure TDataModule1.Timer1Timer(Sender: TObject);
var
  r,c: Integer;
  val,
  cmd: String;
  OK : Boolean;
begin
  if not iAUTO_UPDATE then exit;

  TRY
    SMS_TALLY.Close;
    SMS_TALLY.Open;
    OK := SMS_TALLY.Active;
  EXCEPT
    OK := False;
  END;

  if OK then
    begin
      CMDIntegrity.CommandText := 'TRUNCATE TABLE TALLY_RESULTS';
      TRY
        CMDIntegrity.Execute;
      EXCEPT
        OK := False;
      END;
    end;


  if OK then
    begin
      while not SMS_Tally.eof do
        begin
          if not OK then Break;
          TRY
          cmd :=' INSERT INTO TALLY_RESULTS ([EID],[PID],[CID],[CONTEST],[CANDIDATE],[CSORT],[BALLOTS_CAST],[FROM_PHONE],[DT_POSTED]) ' +
                ' VALUES (~EID,~PID,~CID,~CONTEST,~CANDIDATE,~CSORT,~BALLOTS_CAST,~FROM_PHONE,~DT_POSTED)';
          for c := 0 to SMS_TALLY.FieldCount - 1 do
            begin
              if SMS_TALLY.FieldByName(SMS_TALLY.Fields[c].FieldName).IsNull then val := 'NULL' else
                val := QuotedStr(SMS_TALLY.FieldByName(SMS_TALLY.Fields[c].FieldName).AsString);
              CMD := StringReplace(CMD,'~' + SMS_TALLY.Fields[c].FieldName , val ,[rfIgnoreCase]);
            end;
          EXCEPT
            OK := False;
          END;

          if OK then
            begin
              CMDIntegrity.CommandText := cmd;
              TRY
                CMDIntegrity.Execute;
              EXCEPT
                OK := False;
              END;
            end;
          SMS_TALLY.Next;
        end;

        if OK then
          begin
            cmd := 'EXEC dbo.pr_UpdateFromTallyResults';
            CMDIntegrity.CommandText := cmd;
              TRY
                CMDIntegrity.Execute;
              EXCEPT
                OK := False;
              END;
          end;
      end;

end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  iAUTO_UPDATE := False;
end;

end.
