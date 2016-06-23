unit TelegAPi.Utils;

interface

Type
  TuaUtils = class
    Class Function IfThen<T>(Const Value: Boolean; IfTrue, IfFalse: T): T;
  end;

  TCommandHelper = Record
  private
    FText: TArray<String>;
  public
    Class Function Create(Const Text: String): TCommandHelper; static;
    Function IsCommand: Boolean;
    Function Command: String;
    Function ParamCount: Integer;
    Function Param(Const Index: Integer): String;
    Function ParamsToString: String;
  End;

implementation

uses
  System.SysUtils;
{ TuaUtils }

class function TuaUtils.IfThen<T>(const Value: Boolean; IfTrue, IfFalse: T): T;
begin
  if Value then
    Result := IfTrue
  else
    Result := IfFalse;
end;

{ TCommandHelper }

function TCommandHelper.Command: String;
begin
  Result := FText[0].Substring(0, FText[0].IndexOf('@'));
end;

class function TCommandHelper.Create(const Text: String): TCommandHelper;
begin
  Result.FText := Text.Split([' ', ','], TStringSplitOptions.ExcludeEmpty);
end;

function TCommandHelper.IsCommand: Boolean;
begin
  Result := FText[0].StartsWith('/');
end;

function TCommandHelper.Param(const Index: Integer): String;
begin
  Result := FText[Index];
end;

function TCommandHelper.ParamCount: Integer;
begin
  Result := Length(FText);
end;

function TCommandHelper.ParamsToString: String;
begin
  Result := string.Join(' ', Copy(FText, 1, Length(FText)));
end;

end.