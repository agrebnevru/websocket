unit client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    ButtonStart: TButton;
    ButtonStop: TButton;
    MemoLog: TMemo;
    ButtonSubscribe: TButton;
    procedure ButtonStartClick(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonSubscribeClick(Sender: TObject);
    procedure ClientSocket1Lookup(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Write(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  MemoLog.Lines.Add(#10#13);
  MemoLog.Lines.Add('======================');
  MemoLog.Lines.Add(#10#13);
  MemoLog.Lines.Add('click -> Button -> Start');
  ClientSocket1.Address := '104.20.12.48';
  ClientSocket1.Host := 'api.poloniex.com';

  // ClientSocket1.Address := '174.129.224.73';
  // ClientSocket1.Host := 'echo.websocket.org';

  // ClientSocket1.Address := '';
  // ClientSocket1.Host := 'demos.kaazing.com/echo';

  // ClientSocket1.Address := '';
  // ClientSocket1.Host := 'localhost';

  // ClientSocket1.Port := 27015;
  ClientSocket1.Port := 443;
  // ClientSocket1.Port := 8080;
  // ClientSocket1.Port := 1025;

  ClientSocket1.ClientType := ctBlocking;
  // ClientSocket1.SetSubComponent(true);
  try
    ClientSocket1.Active := True;
  except
    ClientSocket1.Close;
    MemoLog.Lines.Add('Cant connect');
  end;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  MemoLog.Lines.Add('click -> Button -> Stop');
  ClientSocket1.Active := False;
end;

procedure TForm1.ButtonSubscribeClick(Sender: TObject);
var
  x :Integer;
begin
  MemoLog.Lines.Add('click -> Button -> .SendText(Ticker)');
  ClientSocket1.Socket.SendText('[32, "ticker"]');
  // MemoLog.Lines.Add('x = ' + IntToStr(x));
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MemoLog.Lines.Add('event -> Connect');
end;

procedure TForm1.ClientSocket1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MemoLog.Lines.Add('event -> Connecting...');
  // Socket.SendText('BTC_USDT');
  // Socket.SendText('Test message');
  // Socket.SendText('trollbox');
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MemoLog.Lines.Add('event -> Disconnect -> Server: ' + Socket.ReceiveText + #13#10);
  // Socket.SendText('Disconnected');
end;

procedure TForm1.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ClientSocket1.Active := False;
  MemoLog.Lines.Add('event -> Error -> Error Code: ' + IntToStr(ErrorCode) + #13#10);
  ErrorCode := 0;
end;

procedure TForm1.ClientSocket1Lookup(Sender: TObject; Socket: TCustomWinSocket);
begin
  MemoLog.Lines.Add('event -> Lookup -> Server: ' + Socket.ReceiveText + #13#10);
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  MemoLog.Lines.Add('event -> Read -> Server: ' + Socket.ReceiveText + #13#10);
end;

procedure TForm1.ClientSocket1Write(Sender: TObject; Socket: TCustomWinSocket);
begin
  MemoLog.Lines.Add('event -> Write');
  // ClientSocket1.Socket.SendText('Test message');
end;

end.
