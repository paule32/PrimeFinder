program SegmentiertesSiebDelphi;

{$APPTYPE CONSOLE}

uses
  SysUtils, Math;

const
  SegmentGroesse = 1000000000;
var
  BasisPrimzahlen: array of Integer;

procedure SiebDesEratosthenes(bis: Integer);
var
  i, j: Integer;
  Prim: array of Boolean;
begin
  SetLength(Prim, bis + 1);
  FillChar(Prim[0], Length(Prim), True);
  Prim[0] := False;
  Prim[1] := False;

  for i := 2 to Trunc(Sqrt(bis)) do
  begin
    if Prim[i] then
    begin
      j := i * i;
      while j <= bis do
      begin
        Prim[j] := False;
        j := j + i;
      end;
    end;
  end;

  SetLength(BasisPrimzahlen, 0);
  for i := 2 to bis do
    if Prim[i] then
    begin
      SetLength(BasisPrimzahlen, Length(BasisPrimzahlen) + 1);
      BasisPrimzahlen[High(BasisPrimzahlen)] := i;
    end;
end;

procedure SegmentiertesSieb(bis: Integer);
var
  Segment: array of Boolean;
  Start, i, j, k, SegEnde, Primzahl: Integer;
begin
  SiebDesEratosthenes(Trunc(Sqrt(bis)));
  SetLength(Segment, SegmentGroesse);

  for Start := 0 to (bis div SegmentGroesse) do
  begin
    FillChar(Segment[0], Length(Segment), True);

    for i := Low(BasisPrimzahlen) to High(BasisPrimzahlen) do
    begin
      Primzahl := BasisPrimzahlen[i];
      j := (Max(Start * SegmentGroesse div Primzahl * Primzahl, 1) * Primzahl) - Start * SegmentGroesse;
      while j < SegmentGroesse do
      begin
        if (Start * SegmentGroesse + j <= bis) then
          Segment[j] := False;
        j := j + Primzahl;
      end;
    end;

    SegEnde := Min((Start + 1) * SegmentGroesse - 1, bis);
    for i := 2 to SegEnde - Start * SegmentGroesse do
    begin
      if Segment[i] then
        Write(Start * SegmentGroesse + i, ', ');
    end;
  end;
end;

begin
  try
    WriteLn('primefind.exe 1.0 (c) 2024 Jens Kallup - paule32');
    WriteLn('all rights reserved.');
    WriteLn;
    WriteLn('only for education purpose, and non-profit.');
    WriteLn('commerical use is not allowed !');
    WriteLn;
    WriteLn('initialize 1000000000 array elements...');
    SegmentiertesSieb(SegmentGroesse);
    ReadLn;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName, ': ', E.Message);
      ReadLn;
    end;
  end;
end.

