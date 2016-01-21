unit DM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB;

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
    Function VersionNumber : String;
  private
    { Private declarations }
  public
    { Public declarations }
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

end.
