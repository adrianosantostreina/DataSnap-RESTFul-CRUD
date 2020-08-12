object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 368
  Width = 489
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Public\Documents\Embarcadero\Studio\15.0\Sampl' +
        'es\Data\EMPLOYEE.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'DriverID=IB')
    LoginPrompt = False
    Left = 72
    Top = 24
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 72
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 72
    Top = 136
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 72
    Top = 192
  end
  object FDQueryDepartmentNames: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select dept_no, department  from department')
    Left = 256
    Top = 24
  end
  object FDQueryDepartment: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from department where DEPT_NO = :DEPT')
    Left = 256
    Top = 80
    ParamData = <
      item
        Name = 'DEPT'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQueryDepartmentEmployees: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from employee where dept_no = :DEPT')
    Left = 256
    Top = 144
    ParamData = <
      item
        Name = 'DEPT'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 72
    Top = 248
  end
end
