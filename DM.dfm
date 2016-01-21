object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 296
  Top = 107
  Height = 467
  Width = 615
  object ADOConnection: TADOConnection
    ConnectionString = 'FILE NAME=SMSTally.UDL'
    LoginPrompt = False
    Provider = 'SMSTally.UDL'
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
        Value = Null
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
        Value = Null
      end>
    SQL.Strings = (
      
        ' SELECT DISTINCT P.POLL, U.PHONE1 AS TELEPHONE, U.PWD AS [PASSWO' +
        'RD], P.ELECTORATE, CA.DONE, CA.SAV,CA.POLLOC'
      '   FROM CONTESTS C'
      '   LEFT JOIN POLLS P ON P.PID = C.PID'
      '   LEFT JOIN CACTIVE CA ON CA.POLLOC = P.POLL'
      '   LEFT JOIN USERS U ON U.PID = P.PID'
      '  WHERE C.CONTEST = :DISTRICT'
      'OR U.POLL =:POLL'
      'OR U.PHONE1 =:PHONE')
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
      
        'SELECT ID, LOGDT, CAST(ENTRY AS VARCHAR(1000) ) AS ENTRY FROM CA' +
        'ctiveLog ORDER BY ID DESC')
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
end
