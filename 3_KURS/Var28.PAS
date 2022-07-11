{массив 10х10, найти среднее для массива,
сумму и корень квадр. отрицат.значений,
находящихся на диагоналях }
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
          {проеряем,
           находится ли элемент на главной ИЛИ (OR) побочн.диагонали
           И (AND) является ли он отрицательным}
          if ((i=j) or (i+j=11)) and (x[i,j]<0)
              then
                begin
                  SumKvOtr:=SumKvOtr+sqr(x[i,j]); {сумма квадр.отр.эл-тов}
                  SumOtr:=SumOtr+x[i,j];         {сумма отр.эл-тов}
                end;
        end;
    end;
  sred:=sum/100; {среднее }
  KorSumKvOtr:=sqrt(SumKvOtr); {корень квадр. из суммы квадр. отр. эл-тов}

  writeln('Результаты:');
  writeln('Среднее значение элементов массива  ',sred:7:3);
  writeln('Для чисел, находящихся на главной и побочной диагоналях матрицы,');
  writeln('соответствующей массиву сумма значений отр. эл-тов   ',SumOtr);
  writeln('Корень квадр. суммы отрицательных значений  ',KorSumKvOtr:7:3);
  readln;
end.