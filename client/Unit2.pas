unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  Data.FireDACJSONReflect, FMX.ListView.Types, FMX.StdCtrls, FMX.ListView,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.Rtti, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts,
  FMX.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, Fmx.Bind.Grid,
  Data.Bind.Grid;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    Departamentos: TButton;
    fdmemDepartamentos: TFDMemTable;
    fdmemDepartamento: TFDMemTable;
    fdmemFuncionario: TFDMemTable;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    BindDepartamentos: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    Button1: TButton;
    Button2: TButton;
    procedure DepartamentosClick(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetDepartmentEmployees(const ADEPTNO: string);
    procedure GetDepartmentNames;
    procedure UpdateDepartmentNames(const ADataSetList: TFDJSONDataSets);
    procedure UpdateDepartmentEmployees(ADataSetList: TFDJSONDataSets);
    procedure ApplyUpdates;
    function GetDeltas: TFDJSONDeltas;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}


uses ClientModule2;

const
  sEmployees  = 'Employees';
  sDepartment = 'Department';

{ TForm2 }

procedure TForm2.ApplyUpdates;
var
  LDeltaList: TFDJSONDeltas;
begin
  LDeltaList := GetDeltas;
  ClientModule.ServerMethods1Client.ApplyChangesDepartmentEmployees(LDeltaList);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ApplyUpdates;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  LDEPTNO: string;
begin
  if fdmemDepartamento.Active then
  begin
    LDEPTNO := fdmemDepartamento.FieldByName('DEPT_NO').AsString;
    GetDepartmentEmployees(LDEPTNO);
  end;
end;

procedure TForm2.DepartamentosClick(Sender: TObject);
begin
  GetDepartmentNames;
end;

function TForm2.GetDeltas: TFDJSONDeltas;
begin
  if fdmemDepartamento.State in dsEditModes then
    fdmemDepartamento.Post;

  if fdmemFuncionario.State in dsEditModes then
    fdmemFuncionario.Post;

  Result := TFDJSONDeltas.Create;

  TFDJSONDeltasWriter.ListAdd(Result, sEmployees, fdmemFuncionario);
  TFDJSONDeltasWriter.ListAdd(Result, sDepartment, fdmemDepartamento);
end;

procedure TForm2.GetDepartmentEmployees(const ADEPTNO: string);
var
  LDataSetList: TFDJSONDataSets;
begin
  LDataSetList := ClientModule.ServerMethods1Client.GetDepartmentEmployees(ADEPTNO);
  UpdateDepartmentEmployees(LDataSetList);
end;

procedure TForm2.GetDepartmentNames;
var
  LDataSetList: TFDJSONDataSets;
begin
  LDataSetList := ClientModule.ServerMethods1Client.GetDepartmentNames();
  UpdateDepartmentNames(LDataSetList);
end;

procedure TForm2.ListView1Change(Sender: TObject);
var
  LDEPTNO: string;
begin
  LDEPTNO := ListView1.Selected.Detail;
  GetDepartmentEmployees(LDEPTNO);
end;

procedure TForm2.UpdateDepartmentEmployees(ADataSetList: TFDJSONDataSets);
var
  LDataSet: TFDDataSet;
begin
  LDataSet := TFDJSONDataSetsReader.GetListValueByName(ADataSetList, sDepartment);
  fdmemDepartamento.Active := False;
  fdmemDepartamento.AppendData(LDataSet);

  LDataSet := TFDJSONDataSetsReader.GetListValueByName(ADataSetList, sEmployees);
  fdmemFuncionario.Active  := False;
  fdmemFuncionario.AppendData(LDataSet);
end;

procedure TForm2.UpdateDepartmentNames(const ADataSetList: TFDJSONDataSets);
begin
  fdmemDepartamentos.Active := False;
  Assert(TFDJSONDataSetsReader.GetListCount(ADataSetList) = 1);
  fdmemDepartamentos.AppendData(TFDJSONDataSetsReader.GetListValue(ADataSetList, 0));
end;

end.
