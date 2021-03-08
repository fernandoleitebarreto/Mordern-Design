program ModernDesign;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  Form.Main in 'Form.Main.pas' {formDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
