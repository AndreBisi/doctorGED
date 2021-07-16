unit uCaixa;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, REST.JSON,
  System.Classes, uDM, Server.Utils, System.JSON, System.JSON.Types;

type
  TCaixa = class(TPersistent)
  private
    Fcodigo: integer;
    FcodigoBarra: string;
    FdataArquivo: tDateTime;
    FdataExpurgo: tDateTime;
    FdataValidade: tDateTime;
    FdataFinal: tDateTime;
    FdataInicial: tDateTime;
    procedure Setcodigo(const Value: integer);
    procedure SetcodigoBarra(const Value: string);
    procedure SetdataArquivo(const Value: tDateTime);
    procedure SetdataExpurgo(const Value: tDateTime);
    procedure SetdataFinal(const Value: tDateTime);
    procedure SetdataInicial(const Value: tDateTime);
    procedure SetdataValidade(const Value: tDateTime);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property codigo       : integer   read Fcodigo       write Setcodigo;
    property dataInicial  : tDateTime read FdataInicial  write SetdataInicial;
    property dataFinal    : tDateTime read FdataFinal    write SetdataFinal;
    property dataArquivo  : tDateTime read FdataArquivo  write SetdataArquivo;
    property dataValidade : tDateTime read FdataValidade write SetdataValidade;
    property dataExpurgo  : tDateTime read FdataExpurgo  write SetdataExpurgo;
    property codigoBarra  : string    read FcodigoBarra  write SetcodigoBarra;

    procedure getDados;
    procedure gravar( pFuncao : string );
    procedure deletar;

    constructor create;
    destructor destroy; override;
  published
    { published declarations }
  end;

implementation

var
  vQuery : TFDQuery;
{ TCaixa }

constructor TCaixa.create;
begin
  vQuery            := TFDQuery.Create( nil );
  vQuery.Connection := DM.conexao;
end;

procedure TCaixa.deletar;
begin
  try
    if not DM.conexao.Connected then
    dm.conexao.Connected := True;

    vQuery.SQL.Clear;

    vQuery.SQL.Add( ' delete from tbCaixa where caixaCod = : caixaCod ' );
    vQuery.ParamByName( 'caixaCod' ).AsInteger := self.codigo;
    vQuery.ExecSQL;
  except on e: exception do
    raise Exception.Create( 'Erro na exclus�o' + #23 + e.Message );
  end;
end;

destructor TCaixa.destroy;
begin
  FreeAndNil( vQuery );

  inherited;
end;

procedure TCaixa.getDados;
begin
  vQuery.SQL.Clear;
  vQuery.SQL.Add( ' select * from tbCaixa ' );
  vQuery.SQL.Add( ' where caixaCod = ' + inttostr( self.codigo ) );

  if not DM.conexao.Connected then
    dm.conexao.Connected := True;

  vQuery.Open();
  if not vQuery.IsEmpty then
  begin
    self.codigo       := vQuery.FindField( 'caixaCod' ).AsInteger;
    self.dataInicial  := vQuery.FindField( 'caixaDatIni' ).AsDateTime;
    self.dataFinal    := vQuery.FindField( 'caixaDatFin' ).AsDateTime;
    self.dataArquivo  := vQuery.FindField( 'caixaDatArquivo' ).AsDateTime;
    self.dataValidade := vQuery.FindField( 'caixaDatValidade' ).AsDateTime;
    self.dataExpurgo  := vQuery.FindField( 'caixaDatExpurgo' ).AsDateTime;
    self.codigoBarra  := vQuery.FindField( 'caixaCodBarra' ).AsString;
  end
  else
  begin
    raise Exception.Create('Caixa n�o localizada');
  end;

  vQuery.Close;
end;

procedure TCaixa.gravar( pFuncao : string );
begin
  try
    if not DM.conexao.Connected then
    dm.conexao.Connected := True;

    vQuery.SQL.Clear;

    if pFuncao = 'insert' then
    begin
      vQuery.SQL.Add( ' insert into tbCaixa ( caixaCod, caixaDatIni, caixaDatFin, caixaDatArquivo, caixaDatValidade, caixaDatExpurgo, caixaCodBarrs ) ' );
      vQuery.SQL.Add( ' values ( :caixaCod, :caixaDatIni, :caixaDatFin, :caixaDatArquivo, :caixaDatValidade, :caixaDatExpurgo, :caixaCodBarra )' );
    end
    else
    begin
      vQuery.SQL.Add( ' insert into tbCaixa ( caixaCod, caixaDatIni, caixaDatFin, caixaDatArquivo, caixaDatValidade, caixaDatExpurgo, caixaCodBarrs ) ' );
      vQuery.SQL.Add( ' values ( :caixaCod, :caixaDatIni, :caixaDatFin, :caixaDatArquivo, :caixaDatValidade, :caixaDatExpurgo, :caixaCodBarra )' );
    end;

    vQuery.ParamByName( 'caixaCod' ).AsInteger          := self.codigo;
    vQuery.ParamByName( 'caixaDatIni' ).AsDateTime      := self.dataInicial;
    vQuery.ParamByName( 'caixaDatFin' ).AsDateTime      := self.dataFinal;
    vQuery.ParamByName( 'caixaDatArquivo' ).AsDateTime  := self.dataArquivo;
    vQuery.ParamByName( 'caixaDatValidade' ).AsDateTime := self.dataValidade;
    vQuery.ParamByName( 'caixaDatExpurgo' ).AsDateTime  := self.dataExpurgo;
    vQuery.ParamByName( 'caixaCodBarra' ).AsString      := self.codigoBarra;

    vQuery.ExecSQL;
  except on e: exception do
    raise Exception.Create( 'Erro na grava��o' + #23  +
                            e.Message );
  end;
end;

procedure TCaixa.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TCaixa.SetcodigoBarra(const Value: string);
begin
  FcodigoBarra := Value;
end;

procedure TCaixa.SetdataArquivo(const Value: tDateTime);
begin
  FdataArquivo := Value;
end;

procedure TCaixa.SetdataExpurgo(const Value: tDateTime);
begin
  FdataExpurgo := Value;
end;

procedure TCaixa.SetdataFinal(const Value: tDateTime);
begin
  FdataFinal := Value;
end;

procedure TCaixa.SetdataInicial(const Value: tDateTime);
begin
  FdataInicial := Value;
end;

procedure TCaixa.SetdataValidade(const Value: tDateTime);
begin
  FdataValidade := Value;
end;

end.
