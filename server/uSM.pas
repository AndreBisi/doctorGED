unit uSM;

interface

uses System.SysUtils, System.Classes, System.Json, DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, REST.JSON,
    uCaixa, Server.Utils;


type
  TSM = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function caixa( const pCodigo : integer ) : TJSONObject;
    function caixaList( const pDados : string = '' ) : TJSONArray;
    function AcceptCaixa( const pObjeto : TJSONObject ) : TJSONObject;      //Put    = Update
    function UpdateCaixa( const pObjeto : TJSONObject ) : TJSONObject;      //Post   = Insert
    function CancelCaixa( const pObjeto : integer = 0 ) : TJSONObject;      //Delete = Delete
  end;

implementation


{$R *.dfm}


uses System.StrUtils, uMain_Server;

function TSM.AcceptCaixa(const pObjeto: TJSONObject): TJSONObject;
var
  oCaixa : TCaixa;

begin
  try
    try
      oCaixa := TJson.JsonToObject<TCaixa>( pObjeto );
      oCaixa.gravar( 'update' );
      result := TJson.ObjectToJsonObject( oCaixa );
      TServerUtils.FormatJSON( 201, Result.ToString );
      FreeAndNil( Result );
    except on e: exception do
      begin
        FreeAndNil( oCaixa );
        raise Exception.Create( e.Message );
      end;
    end;
  finally
    FreeAndNil( oCaixa );
  end;
end;

function TSM.caixa(const pCodigo: integer): TJSONObject;
var
  oCaixa : TCaixa;

begin
  try
    try
      oCaixa        := TCaixa.create;
      oCaixa.codigo := pCodigo;
      oCaixa.getDados;
      result        := TJson.ObjectToJsonObject( oCaixa );
      TServerUtils.FormatJSON( 201, Result.ToString );
      FreeAndNil( Result );
    except on e: exception do
      begin
        FreeAndNil( oCaixa );
        raise Exception.Create( e.Message );
      end;
    end;
  finally
    FreeAndNil( oCaixa );
  end;
end;

function TSM.caixaList(const pDados: string): TJSONArray;
begin
  //
end;

function TSM.CancelCaixa(const pObjeto: integer): TJSONObject;
var
  oCaixa : TCaixa;

begin
  try
    try
      oCaixa := TJson.JsonToObject<TCaixa>( pObjeto );
      oCaixa.deletar;
      result := TJson.ObjectToJsonObject( oCaixa );
      TServerUtils.FormatJSON( 201, Result.ToString );
      FreeAndNil( Result );
    except on e: exception do
      begin
        FreeAndNil( oCaixa );
        raise Exception.Create( e.Message );
      end;
    end;
  finally
    FreeAndNil( oCaixa );
  end;
end;

function TSM.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TSM.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TSM.UpdateCaixa(const pObjeto: TJSONObject): TJSONObject;
var
  oCaixa : TCaixa;

begin
  try
    try
      oCaixa := TJson.JsonToObject<TCaixa>( pObjeto );
      oCaixa.gravar( 'insert' );
      result := TJson.ObjectToJsonObject( oCaixa );
      TServerUtils.FormatJSON( 201, Result.ToString );
      FreeAndNil( Result );
    except on e: exception do
      begin
        FreeAndNil( oCaixa );
        raise Exception.Create( e.Message );
      end;
    end;
  finally
    FreeAndNil( oCaixa );
  end;
end;

end.


