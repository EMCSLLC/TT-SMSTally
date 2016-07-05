object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 296
  Top = 107
  Height = 467
  Width = 615
  object ADOConnection: TADOConnection
    ConnectionString = 'FILE NAME=TALLY.UDL'
    LoginPrompt = False
    Provider = 'TALLY.UDL'
    Left = 56
    Top = 32
  end
  object DISTRICT_DS: TDataSource
    Left = 88
    Top = 104
  end
  object DISTRICTS: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = DISTRICT_DS
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT CONTEST AS DISTRICT'
      '  FROM CONTESTS'
      ' ORDER BY CONTEST')
    Left = 24
    Top = 112
  end
  object POLLS: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Filtered = True
    Parameters = <
      item
        Name = 'DISTRICT'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 60
        Value = '0'
      end
      item
        Name = 'POLL'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = '0005-01'
      end
      item
        Name = 'PHONE'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = 'X'
      end
      item
        Name = 'PHONE2'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = 'X'
      end>
    SQL.Strings = (
      
        ' SELECT DISTINCT P.POLL, U.PHONE1 AS TELEPHONE, U.PHONE2 AS ALT_' +
        'PHONE, U.PWD AS [PASSWORD], P.ELECTORATE, CA.ID, CA.DONE, CA.SAV' +
        ',CA.POLLOC,P.PID'
      '   FROM CONTESTS C'
      '   LEFT JOIN POLLS P ON P.PID = C.PID'
      '   LEFT JOIN CACTIVE CA ON CA.POLLOC = P.PID'
      '   LEFT JOIN USERS U ON U.PID = P.PID'
      '  WHERE C.CONTEST = :DISTRICT'
      'OR U.POLL =:POLL'
      'OR U.PHONE1 =:PHONE'
      'OR U.PHONE2 =:PHONE2')
    Left = 240
    Top = 112
  end
  object POLLS_DS: TDataSource
    DataSet = POLLS
    Left = 176
    Top = 104
  end
  object CActive_DS: TDataSource
    AutoEdit = False
    DataSet = CActive
    Left = 32
    Top = 200
  end
  object CActive: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Filtered = True
    Parameters = <
      item
        Name = 'POLL'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * '
      '  FROM CActive CA'
      ' WHERE POLLOC = :POLL')
    Left = 128
    Top = 200
  end
  object ActiviteLog: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Filter = 'ENTRY LIKE '#39'SERVER%'#39
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      
        'SELECT DISTINCT ID, LOGDT, CAST(ENTRY AS VARCHAR(1000) ) AS ENTR' +
        'Y, CActiveID FROM CActiveLog ORDER BY ID DESC')
    Left = 352
    Top = 112
    object ActiviteLogLOGDT: TDateTimeField
      DisplayLabel = 'LOGGED'
      DisplayWidth = 11
      FieldName = 'LOGDT'
      DisplayFormat = 'h:mm:nn AM/PM'
    end
    object ActiviteLogENTRY: TStringField
      DisplayLabel = 'MESSAGE'
      DisplayWidth = 1000
      FieldName = 'ENTRY'
      ReadOnly = True
      Size = 1000
    end
    object ActiviteLogID: TAutoIncField
      DisplayLabel = 'id'
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object ActiviteLogCActiveID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CActiveID'
      Visible = False
    end
  end
  object LOG_DS: TDataSource
    AutoEdit = False
    DataSet = ActiviteLog
    Left = 336
    Top = 192
  end
  object UTIL: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 200
    Top = 200
  end
  object ADOCommand: TADOCommand
    Connection = ADOConnection
    Parameters = <>
    Left = 48
    Top = 280
  end
  object IsRunning: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT  TOP 1 '
      '        job.name,'
      '        1 AS Running,'
      '        job.job_id,'
      '        job.originating_server,'
      '        activity.run_requested_date,'
      
        '        DATEDIFF(MINUTE, activity.run_requested_date, GETDATE())' +
        ' as Elapsed,'
      '        case when activity.last_executed_step_id is null'
      '             then '#39'Step 1 executing'#39
      
        '             else '#39'Step '#39' + convert(varchar(20), last_executed_s' +
        'tep_id + 1)'
      '                  + '#39' executing'#39
      '        end'
      'FROM    msdb.dbo.sysjobs_view job'
      
        '        JOIN msdb.dbo.sysjobactivity activity ON job.job_id = ac' +
        'tivity.job_id'
      
        '        JOIN msdb.dbo.syssessions sess ON sess.session_id = acti' +
        'vity.session_id'
      
        '        JOIN ( SELECT   MAX(agent_start_date) AS max_agent_start' +
        '_date'
      '               FROM     msdb.dbo.syssessions'
      
        '             ) sess_max ON sess.agent_start_date = sess_max.max_' +
        'agent_start_date'
      'WHERE   run_requested_date IS NOT NULL'
      '        AND stop_execution_date IS NULL'
      '        AND job.name like N'#39'Run SMSTally%'#39'  ')
    Left = 272
    Top = 264
  end
  object AppCaption: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT '#39' EBC Tally Management - '#39' + '
      
        '+ '#39'    POLLS:  '#39' + CAST((SELECT COUNT(DISTINCT PID) FROM dbo.Use' +
        'rs) AS VARCHAR) +'
      
        '+ '#39'      NO ACTIVITY:  '#39' + CAST((SELECT COUNT(DISTINCT PID) FROM' +
        ' dbo.Users WHERE PID NOT IN (SELECT polloc FROM CActive))AS VARC' +
        'HAR) '
      
        '+ '#39'     TALLY MODE:  '#39' + CAST((SELECT COUNT(*) FROM dbo.CActive ' +
        'WHERE SAV <> 2) AS VARCHAR) +'
      
        '+ '#39'     LOCKED:  '#39' + CAST((SELECT COUNT(*) FROM dbo.CActive WHER' +
        'E SAV =  2) AS VARCHAR) AS Caption')
    Left = 160
    Top = 264
  end
  object ADOIntegrity: TADOConnection
    ConnectionString = 'FILE NAME=INTEGRITY.UDL'
    LoginPrompt = False
    Provider = 'INTEGRITY.UDL'
    Left = 168
    Top = 32
  end
  object CMDIntegrity: TADOCommand
    Connection = ADOIntegrity
    Parameters = <>
    Left = 304
    Top = 48
  end
  object Timer1: TTimer
    Interval = 520000
    OnTimer = Timer1Timer
    Left = 264
    Top = 32
  end
  object SMS_TALLY: TADODataSet
    Connection = ADOConnection
    CommandText = 
      'SELECT * FROM vw_TALLY_RESULTS WITH (NOLOCK) ORDER BY PID,CID,CS' +
      'ORT'
    Parameters = <>
    Left = 264
    Top = 184
  end
end
