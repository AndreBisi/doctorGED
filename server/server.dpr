program server;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uMain_Server in 'uMain_Server.pas' {fMain_server},
  uSM in 'uSM.pas' {SM: TDSServerModule},
  uWM in 'uWM.pas' {WM: TWebModule},
  uDM in 'uDM.pas' {DM: TDataModule},
  uCaixa in '..\class\uCaixa.pas',
  Server.Utils in '..\..\Common\Utils\Server.Utils.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfMain_server, fMain_server);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
