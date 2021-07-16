object DM: TDM
  OldCreateOrder = False
  Height = 407
  Width = 374
  object conexao: TFDConnection
    Params.Strings = (
      'Database=DBUnimed'
      'User_Name=postgres'
      'Password=porcos128'
      'Server=192.168.14.2'
      'DriverID=pG')
    Left = 88
    Top = 56
  end
  object qryAux: TFDQuery
    Connection = conexao
    Left = 168
    Top = 65
  end
end
