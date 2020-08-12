program Cliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Proxy in 'Proxy.pas',
  ClientModule2 in 'ClientModule2.pas' {ClientModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TClientModule, ClientModule);
  Application.Run;
end.
