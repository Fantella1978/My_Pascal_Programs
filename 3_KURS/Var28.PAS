{���ᨢ 10�10, ���� �।��� ��� ���ᨢ�,
�㬬� � ��७� �����. �����.���祭��,
��室����� �� ���������� }
Program var14;
uses crt;
var x:array[1..10,1..10] of integer;
    i,j:integer;
    sum,SumKvOtr,SumOtr:integer;
    KorSumKvOtr,sred:real;
begin
  clrscr;
  randomize;
  for i:=1 to 10 do
    begin
      for j:=1 to 10 do
        begin
          x[i,j]:=trunc(-16+random*48);
          write(x[i,j]:4,'  ');
        end;
      writeln;
    end;
  for i:=1 to 10 do
    begin
      for j:=1 to 10 do
        begin
          sum:=sum+x[i,j];
          {�஥�塞,
           ��室���� �� ������� �� ������� ��� (OR) �����.���������
           � (AND) ���� �� �� ����⥫��}
          if ((i=j) or (i+j=11)) and (x[i,j]<0)
              then
                begin
                  SumKvOtr:=SumKvOtr+sqr(x[i,j]); {�㬬� �����.���.��-⮢}
                  SumOtr:=SumOtr+x[i,j];         {�㬬� ���.��-⮢}
                end;
        end;
    end;
  sred:=sum/100; {�।��� }
  KorSumKvOtr:=sqrt(SumKvOtr); {��७� �����. �� �㬬� �����. ���. ��-⮢}

  writeln('��������:');
  writeln('�।��� ���祭�� ������⮢ ���ᨢ�  ',sred:7:3);
  writeln('��� �ᥫ, ��室����� �� ������� � ����筮� ���������� ������,');
  writeln('ᮮ⢥�����饩 ���ᨢ� �㬬� ���祭�� ���. ��-⮢   ',SumOtr);
  writeln('��७� �����. �㬬� ����⥫��� ���祭��  ',KorSumKvOtr:7:3);
  readln;
end.