unit CollatzConjecture;

{$mode ObjFPC}{$H+}

interface

function steps(const number : integer) : integer;

implementation

uses SysUtils;

function steps(const number : integer) : integer;
var
  n: Integer;
  counter: Integer;
begin
  n := number;
  counter := 0;
  if n <= 0 then
   begin
     raise EArgumentOutOfRangeException.Create('Only positive integers are allowed');
   end;
  while n > 1 do
  begin
    if n mod 2 = 0 then
      n := n div 2
    else
      n := n * 3 + 1;

    Inc(counter);
  end;

  Result := counter;
end;

end.