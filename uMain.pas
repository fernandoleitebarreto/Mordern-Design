unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  dxGDIPlusClasses, System.ImageList, Vcl.ImgList, Vcl.CategoryButtons,
  Vcl.ButtonGroup, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.StdCtrls, cxButtons, Vcl.Buttons,

  // UCL
  UCL.Classes, UCL.Graphics, UCL.Utils, UCL.ThemeManager, UCL.IntAnimation,
  UCL.DragReorder, UCL.FontIcons,
  UCL.Form, UCL.CaptionBar, UCL.Panel, UCL.ProgressBar, UCL.Button, UCL.Slider,
  UCL.Text,
  UCL.Hyperlink, UCL.ListButton, UCL.QuickButton, UCL.ScrollBox, UCL.Edit,
  UCL.PopupMenu,
  UCL.CheckBox, UCL.RadioButton, UCL.HoverPanel;

type
  TForm1 = class(TUForm)
    ImageList: TImageList;
    SplitView: TSplitView;
    pnlContent: TPanel;
    edSearch: TUEdit;
    UButton1: TUButton;
    UButton3: TUButton;
    UButton4: TUButton;
    captionbarMain: TUCaptionBar;
    qbuttonQuit: TUQuickButton;
    qbuttonFullScreen: TUQuickButton;
    qbuttonMin: TUQuickButton;
    qbuttonMax: TUQuickButton;
    qbuttonHighlight: TUQuickButton;
    UButton2: TUButton;
    img_Menu: TImage;
    UButton5: TUButton;
    CategoryPanelGroupTabela: TCategoryPanelGroup;
    CategoryPanelTabela: TCategoryPanel;
    btnItemA: TUButton;
    btnItemB: TUButton;
    procedure img_MenuClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CategoryButtons1Categories0Items2Click(Sender: TObject);
    procedure qbuttonFullScreenClick(Sender: TObject);
    procedure CategoryPanelTabelaExpand(Sender: TObject);
    procedure CategoryPanel2Expand(Sender: TObject);
    procedure UButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CategoryPanelTabelaClick(Sender: TObject);
    procedure CategoryPanelGroupTabelaClick(Sender: TObject);
  private
    { Private declarations }
    procedure RecolhePaineis(Painel: TCategoryPanel);
    procedure CollapseAll(CategoryPanelGroup: TCategoryPanelGroup);
    procedure ExpandAll(CategoryPanelGroup: TCategoryPanelGroup);
    procedure OpenClose(CategoryPanelGroup: TCategoryPanelGroup); overload;
    procedure OpenClose(CategoryPanel: TCategoryPanel); overload;

    function getComponentCount(Painel: TCategoryPanel): Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  Height_Button = 36;

implementation

{$R *.dfm}

procedure TForm1.CategoryButtons1Categories0Items2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if Form1.Width < 640 then
    SplitView.Close
  else
    SplitView.Open;

end;

procedure TForm1.img_MenuClick(Sender: TObject);
begin
  if SplitView.Opened then
    SplitView.Close
  else
    SplitView.Open;

end;

procedure TForm1.qbuttonFullScreenClick(Sender: TObject);
begin
  FullScreen := not FullScreen;
  if FullScreen then
    qbuttonFullScreen.Caption := UF_EXIT_FULL_SCREEN
  else
    qbuttonFullScreen.Caption := UF_FULL_SCREEN;
end;

procedure TForm1.CategoryPanelTabelaClick(Sender: TObject);
begin
  // OpenClose(TCategoryPanel(Sender));
end;

procedure TForm1.CategoryPanelGroupTabelaClick(Sender: TObject);
begin
  // OpenClose(TCategoryPanelGroup(Sender));
end;

procedure TForm1.CategoryPanelTabelaExpand(Sender: TObject);
begin
  // RecolhePaineis(TCategoryPanel(Sender));
end;

procedure TForm1.CategoryPanel2Expand(Sender: TObject);
begin
  // RecolhePaineis(TCategoryPanel(Sender));
end;

procedure TForm1.OpenClose(CategoryPanelGroup: TCategoryPanelGroup);
var
  I: Integer;
begin
  for I := 0 to CategoryPanelGroup.Panels.Count - 1 do
  begin
    if TCategoryPanel(CategoryPanelGroup.Panels[I]).Collapsed then
    begin
      // CategoryPanel.Expand;
      TCategoryPanelGroup(CategoryPanelGroup).Height := Height_Button;
    end
    else
    begin
      // CategoryPanel.Collapse;
      TCategoryPanelGroup(CategoryPanelGroup).Height := CategoryPanelGroup.Tag;

    end;
  end;

end;

procedure TForm1.OpenClose(CategoryPanel: TCategoryPanel);
begin
  if CategoryPanel.Collapsed then
  begin
    // CategoryPanel.Expand;
    CategoryPanel.Height := CategoryPanel.Tag;
  end
  else
  begin
    // CategoryPanel.Collapse;
    CategoryPanel.Height := Height_Button;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TCategoryPanelGroup) then
      TCategoryPanelGroup(Components[I]).Tag :=
        TCategoryPanelGroup(Components[I]).Height;

    if (Components[I] is TCategoryPanel) then
      TCategoryPanel(Components[I]).Tag := TCategoryPanel(Components[I]).Height;
  end;
end;

procedure TForm1.ExpandAll(CategoryPanelGroup: TCategoryPanelGroup);
var
  I: Integer;
begin
  // Button - Height: 36 Width: 160
  // Item - Height: 25 - Collapsed
  // One Item - Height: 62 ((36  * 1) + 25)
  // Two Items - Height: 98 ((36  * 2) + 25)

  // (TCategoryPanel(CategoryPanelGroup.Panels[i]).Components[0].Name
  for I := 0 to CategoryPanelGroup.Panels.Count - 1 do
  begin
    TCategoryPanel(CategoryPanelGroup.Panels[I]).Height :=
      ((getComponentCount(TCategoryPanel(CategoryPanelGroup.Panels[I])) *
      Height_Button) + 25);
    TCategoryPanel(CategoryPanelGroup.Panels[I]).Expand;
  end;

end;

procedure TForm1.CollapseAll(CategoryPanelGroup: TCategoryPanelGroup);
var
  I: Integer;
begin
  for I := 0 to CategoryPanelGroup.Panels.Count - 1 do
  begin
    TCategoryPanel(CategoryPanelGroup.Panels[I]).Collapse;
  end;

end;

function TForm1.getComponentCount(Painel: TCategoryPanel): Integer;
var
  I, J: Integer;
  CategoryPanel: TCategoryPanel;
begin
  Result := 0;

  for I := 0 to ComponentCount - 1 do
    if (Components[I] is TUButton) then
    begin
      if (TControl(Components[I]).Parent = Painel) then
        Inc(Result);
    end;

  // Result := TControl(FindComponent(Painel.Name)).ComponentCount;

end;

procedure TForm1.RecolhePaineis(Painel: TCategoryPanel);
var
  I: Integer;
begin
  for I := 0 to CategoryPanelGroupTabela.Panels.Count - 1 do
  begin
    if TCategoryPanel(CategoryPanelGroupTabela.Panels[I]) <> Painel then
      TCategoryPanel(CategoryPanelGroupTabela.Panels[I]).Collapse;
  end;

end;

procedure TForm1.UButton5Click(Sender: TObject);
begin
  if TUButton(Sender).Tag = 0 then
  begin
    TUButton(Sender).Tag := 1;
    CategoryPanelGroupTabela.Height := 79;
    // ExpandAll(CategoryPanelGroupTabela);
  end
  else
  begin
    TUButton(Sender).Tag := 0;
    CategoryPanelGroupTabela.Height := 0;
    // CollapseAll(CategoryPanelGroupTabela);
  end;

end;

end.
