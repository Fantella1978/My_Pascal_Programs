PROGRAM MOA;{===“‘€ €’€  €’…€’—…‘ ‘€ €’€’========}
USES
   WINDOS,CRT;
CONST
   COR = 12;
   VER = 18;
   POPR = VER/(VER-1);
   DT = 0.5;
   DW=0.1;
   A=22;
   B=2;
   C=11;
   D=1;
VAR
   ISCH:ARRAY[1..VER,1..COR] OF REAL;
  ISCH1:ARRAY[1..VER*COR+100] OF REAL;
   MATOG,DISP,OTCL,TIM,COREL2,SXW,SYW,W,COREL3,CORELE,RE:ARRAY[1..COR] OF REAL;
   COREL,COREL1:ARRAY[1..COR,1..COR] OF REAL;
   I,J,K,K1:INTEGER;
   MAT,DIS,OTC,W1,MATE,MATOGE:REAL;
   MAS1,MAS2: TEXT;
  PROCEDURE FORMFILE;
  begin
     createdir('MOA');
     randomize;
     assign(mas2,'MOA\dannie.DAN');
     rewrite(mas2);
     for i:=1 to ver do
       begin
          for j:=1 to cor do
            begin
               write(mas2,'isch[',i:1,',',j:1,']:=.; ');
            end;
          writeln(mas2,'')
       end;
     for i:=1 to cor do
       write(mas2,'tim[',i:1,']:=.; ');
     close(mas2);
     {=======================================================================}
       isch[1,1]:=2.3; isch[1,2]:=2.4; isch[1,3]:=6.2; isch[1,4]:=3.2; isch[1,5]:=3.5;
     isch[1,6]:=5.3; isch[1,7]:=3.7; isch[1,8]:=3.0; isch[1,9]:=4.0; isch[1,10]:=4.2;
     isch[1,11]:=4.3; isch[1,12]:=5.4;
     
     isch[2,1]:=2.1; isch[2,2]:=4.2; isch[2,3]:=2.3; isch[2,4]:=6.4; isch[2,5]:=2.5;
     isch[2,6]:=3.4; isch[2,7]:=6.3; isch[2,8]:=4.2; isch[2,9]:=5.8; isch[2,10]:=3.8;
     isch[2,11]:=2.7; isch[2,12]:=4.4;
     
     isch[3,1]:=5.4; isch[3,2]:=6.1; isch[3,3]:=5.5; isch[3,4]:=3.7; isch[3,5]:=3.0;
     isch[3,6]:=3.8; isch[3,7]:=4.4; isch[3,8]:=3.4; isch[3,9]:=6.0; isch[3,10]:=3.6;
     isch[3,11]:=4.4; isch[3,12]:=3.1;
     
     isch[4,1]:=4.4; isch[4,2]:=2.3; isch[4,3]:=3.7; isch[4,4]:=4.5; isch[4,5]:=3.0;
     isch[4,6]:=6.2; isch[4,7]:=3.6; isch[4,8]:=5.8; isch[4,9]:=6.7; isch[4,10]:=4.5;
     isch[4,11]:=6.3; isch[4,12]:=6.0;

     isch[5,1]:=2.9; isch[5,2]:=2.9; isch[5,3]:=4.6; isch[5,4]:=2.4; isch[5,5]:=5.0;
     isch[5,6]:=2.3; isch[5,7]:=5.8; isch[5,8]:=5.2; isch[5,9]:=5.8; isch[5,10]:=5.5;
     isch[5,11]:=5.9; isch[5,12]:=4.9;
     
     isch[6,1]:=5.4; isch[6,2]:=4.9; isch[6,3]:=5.7; isch[6,4]:=4.4; isch[6,5]:=6.5;
     isch[6,6]:=5.2; isch[6,7]:=6.8; isch[6,8]:=3.4; isch[6,9]:=5.3; isch[6,10]:=3.6;
     isch[6,11]:=4.8; isch[6,12]:=3.2;
     
     isch[7,1]:=2.7; isch[7,2]:=5.8; isch[7,3]:=4.5; isch[7,4]:=6.3; isch[7,5]:=4.6;
     isch[7,6]:=4.9; isch[7,7]:=6.6; isch[7,8]:=5.4; isch[7,9]:=3.8; isch[7,10]:=2.3;
     isch[7,11]:=2.7; isch[7,12]:=3.8;
     
     isch[8,1]:=3.5; isch[8,2]:=3.8; isch[8,3]:=2.2; isch[8,4]:=2.7; isch[8,5]:=3.2;
     isch[8,6]:=2.9; isch[8,7]:=6.4; isch[8,8]:=5.8; isch[8,9]:=5.0; isch[8,10]:=6.2;
     isch[8,11]:=3.5; isch[8,12]:=4.8;
     
     isch[9,1]:=5.4; isch[9,2]:=4.3; isch[9,3]:=2.7; isch[9,4]:=5.1; isch[9,5]:=3.6;
     isch[9,6]:=6.2; isch[9,7]:=3.0; isch[9,8]:=3.5; isch[9,9]:=4.9; isch[9,10]:=6.6;
     isch[9,11]:=3.4; isch[9,12]:=3.6;

     isch[10,1]:=2.4; isch[10,2]:=3.3; isch[10,3]:=3.6; isch[10,4]:=3.7; isch[10,5]:=5.9;
     isch[10,6]:=4.5; isch[10,7]:=4.4; isch[10,8]:=3.0; isch[10,9]:=4.0; isch[10,10]:=3.6;
     isch[10,11]:=4.1; isch[10,12]:=3.2;
     
     isch[11,1]:=5.7; isch[11,2]:=2.6; isch[11,3]:=2.6; isch[11,4]:=4.5; isch[11,5]:=2.8;
     isch[11,6]:=5.9; isch[11,7]:=5.9; isch[11,8]:=4.0; isch[11,9]:=5.1; isch[11,10]:=4.3;
     isch[11,11]:=4.7; isch[11,12]:=4.7;
     
     isch[12,1]:=5.6; isch[12,2]:=3.3; isch[12,3]:=5.8; isch[12,4]:=3.3; isch[12,5]:=3.0;
     isch[12,6]:=5.9; isch[12,7]:=5.7; isch[12,8]:=5.6; isch[12,9]:=5.6; isch[12,10]:=4.2;
     isch[12,11]:=4.6; isch[12,12]:=4.5;
     
     isch[13,1]:=5.3; isch[13,2]:=3.3; isch[13,3]:=4.9; isch[13,4]:=3.4; isch[13,5]:=3.9;
     isch[13,6]:=6.1; isch[13,7]:=3.7; isch[13,8]:=3.7; isch[13,9]:=5.3; isch[13,10]:=5.4;
     isch[13,11]:=4.3; isch[13,12]:=3.3;
     
     isch[14,1]:=6.4; isch[14,2]:=3.7; isch[14,3]:=4.5; isch[14,4]:=3.6; isch[14,5]:=5.8;
     isch[14,6]:=5.4; isch[14,7]:=4.8; isch[14,8]:=4.6; isch[14,9]:=5.2; isch[14,10]:=5.4;
     isch[14,11]:=4.4; isch[14,12]:=3.7;

     isch[15,1]:=5.0; isch[15,2]:=6.3; isch[15,3]:=4.3; isch[15,4]:=5.8; isch[15,5]:=4.4;
     isch[15,6]:=4.1; isch[15,7]:=3.8; isch[15,8]:=3.5; isch[15,9]:=5.8; isch[15,10]:=5.3;
     isch[15,11]:=3.0; isch[15,12]:=3.8;
     
     isch[16,1]:=2.7; isch[16,2]:=6.4; isch[16,3]:=6.1; isch[16,4]:=5.4; isch[16,5]:=6.5;
     isch[16,6]:=3.5; isch[16,7]:=2.5; isch[16,8]:=5.6; isch[16,9]:=4.5; isch[16,10]:=5.3;
     isch[16,11]:=5.7; isch[16,12]:=4.4;
     
     isch[17,1]:=3.0; isch[17,2]:=3.3; isch[17,3]:=5.6; isch[17,4]:=3.9; isch[17,5]:=2.9;
     isch[17,6]:=6.7; isch[17,7]:=3.7; isch[17,8]:=2.5; isch[17,9]:=3.8; isch[17,10]:=6.2;
     isch[17,11]:=3.0; isch[17,12]:=3.3;
     
     isch[18,1]:=4.8; isch[18,2]:=5.4; isch[18,3]:=2.8; isch[18,4]:=5.3; isch[18,5]:=2.4;
     isch[18,6]:=3.7; isch[18,7]:=4.4; isch[18,8]:=4.7; isch[18,9]:=3.8; isch[18,10]:=4.3;
     isch[18,11]:=3.3; isch[18,12]:=4.0;
     
     tim[1]:=0.0; tim[2]:=0.5; tim[3]:=1.0; tim[4]:=1.5; tim[5]:=2.0; tim[6]:=2.5;
     tim[7]:=3.0; tim[8]:=3.5; tim[9]:=4.0; tim[10]:=4.5; tim[11]:=5.0; tim[12]:=5.5;
     
     {=======================================================================}
       {       for i:=1 to cor do
       for j:=1 to ver do
       isch[j,i]:=random(100);
       for i:=1 to cor do
       tim[i]:=random(100);
       {=======================================================================}
       assign(mas1,'MOA\MOA.REZ');
     rewrite(mas1);
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ                    …€€– ‘“—€ ”“–                  บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ\     บ');
     for i:=1 to cor do
       write(mas1,'        บ');
     writeln(mas1,'');
     write(mas1,'บ  \ T บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'บ N  \ บ');
     for i:=1 to cor do
       write(mas1,'        บ');
     writeln(mas1,'');
     for j:=1 to ver do
       begin
          write(mas1,'ฬออออออ');
          for i:=1 to cor do
            begin
               write(mas1,'ฮออออออออ');
            end;
          write(mas1,'น');
          writeln(mas1,'');
          write(mas1,'บ',j:4,'  บ');
          for i:=1 to cor do
            write(mas1,isch[j,i]:8:3,'บ');
          writeln(mas1,'');
       end;
     write(mas1,'ศออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     writeln(mas1,'ผ');
     
     
     
  end;
  PROCEDURE MATOGIDANIE;
  var
     m:real;
  begin
     for i:=1 to cor do
       begin
          m:=0;
          for j:=1 to ver do
            m:=m+isch[j,i];
          matog[i]:=m/ver;
          
       end;
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ   …€ €‘‘’ €’…€’—…‘ € ’ ……   บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Mx(t) บ');
     for i:=1 to cor do
       write(mas1,matog[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');

  end;
  PROCEDURE DISPERCIA;
  var
     d:real;
  begin
     for i:=1 to cor do
       begin
          d:=0;
          for j:=1 to ver do
            begin
               d:=d+isch[j,i]*isch[j,i];
            end;
          disp[i]:=(d/ver-matog[i]*matog[i])*popr;
       end;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ           …€ €‘‘’ ‘…‘ ’ ……          บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Dx(t) บ');
     for i:=1 to cor do
       write(mas1,disp[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
  end;
  PROCEDURE OTCLONENIE;
  begin
     for i:=1 to cor do
       begin
          otcl[i]:=sqrt(disp[i]);;
       end;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ…€ €‘‘’ ‘……€€’— ’… ’ ……บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Gx(t) บ');
     for i:=1 to cor do
       write(mas1,otcl[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
  end;
  PROCEDURE CORELACIA;
  var
     c:real;
  begin
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ                   €’–€ …– ”“–                 บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     corel[1,1]:=disp[1];
     for i:=2 to cor do
       begin
          c:=0;
          for k:=1 to i-1 do
            begin
               for j:=1 to ver do
                 c:=isch[j,i]*isch[j,k]+c;
               c:=c/ver;
               c:=c-matog[i]*matog[k];
               corel[k,i]:=c*popr;
            end;
          corel[i,i]:=disp[i];
       end;
     writeln(mas1,'');
     write(mas1,'ษออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ\     บ');
     for i:=1 to cor do
       write(mas1,'        บ');
     writeln(mas1,'');
     write(mas1,'บ  \ T บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'บ T  \ บ');
     for i:=1 to cor do
       write(mas1,'        บ');
     writeln(mas1,'');
     for j:=1 to cor do
       begin
          write(mas1,'ฬออออออ');
          for i:=1 to cor do
            begin
               write(mas1,'ฮออออออออ');
            end;
          write(mas1,'น');
          writeln(mas1,'');
          write(mas1,'บ',tim[j]:6:2,'บ');
          for i:=1 to cor do
            begin
               if corel[j,i]=0 then write(mas1,'ÛÛÛÛÛÛÛÛบ')
               else
                 write(mas1,corel[j,i]:8:3,'บ');
            end;
          writeln(mas1,'');
       end;
     write(mas1,'ศออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     writeln(mas1,'ผ');
  end;
  PROCEDURE CORELACIA1;
  var
     c:real;
  begin
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ            €’–€ € …– ”“–          บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     corel1[1,1]:=1;
     for i:=2 to cor do
       begin
          corel1[i,i]:=1;
          for k:=1 to i-1 do
            corel1[k,i]:=corel[k,i]/(otcl[i]*otcl[k]);
       end;
     writeln(mas1,'');
     write(mas1,'ษออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ\     บ');
     for i:=1 to cor do
       write(mas1,'        บ');
     writeln(mas1,'');
     write(mas1,'บ  \ T บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'บ T  \ บ');
     for i:=1 to cor do
       write(mas1,'        บ');
     writeln(mas1,'');
     for j:=1 to cor do
       begin
          write(mas1,'ฬออออออ');
          for i:=1 to cor do
            begin
               write(mas1,'ฮออออออออ');
            end;
          write(mas1,'น');
          writeln(mas1,'');
          write(mas1,'บ',tim[j]:6:2,'บ');
          for i:=1 to cor do
            begin
               if corel1[j,i]=0 then write(mas1,'ÛÛÛÛÛÛÛÛบ')
               else
                 write(mas1,corel1[j,i]:8:3,'บ');
            end;
          writeln(mas1,'');
       end;
     write(mas1,'ศออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     writeln(mas1,'ผ');
  end;
  PROCEDURE ZNACHENIE;
  begin
     for i:=1 to cor do
       begin
          mat:=mat+matog[i];
          dis:=dis+disp[i];
       end;
     mat:=mat/cor;
     dis:=dis/cor;
     otc:=sqrt(dis);
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ  €’…€’—…‘… €… ‘’€–€ ‘“—€ ”“– ',mat:9:3,'บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ   ‘…‘ ‘’€–€ ‘“—€ ”“–         ',dis:12:3,'  บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ‘……€€’—… ’…… ‘’€–€ ‘“—€ ”“–',otc:6:3,'บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     for i:=1 to cor do
       begin
          k:=i;k1:=i;
          corel2[i]:=0;
          for j:=1 to cor-k+1 do
            begin
               corel2[i]:=corel2[i]+corel1[j,k1];
               k1:=k1+1;
            end;
          corel2[i]:=corel2[i]/(cor-k+1);
       end;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ               …€ €‘‘’ Rx(T) ’ ……          บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Rx(t) บ');
     for i:=1 to cor do
       write(mas1,corel2[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
  end;
  PROCEDURE PLOTNOCT;
  begin
     w[1]:=0;
     for i:=1 to cor-1 do
       begin
          w[i+1]:=dw*i;
       end;
     for i:=1 to cor do
       begin
          w1:=0;
          for j:=1 to cor do
            begin
               w1:=w1+corel2[j]*cos(w[i]*tim[j])*dt;
            end;
          sxw[i]:=w1;
       end;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ                   …€ €‘‘’ Sx(w)                 บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   W   บ');
     for i:=1 to cor do
       write(mas1,w[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Sx(w) บ');
     for i:=1 to cor do
       write(mas1,sxw[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
  end;
  PROCEDURE PLOTNOCT2;
  begin
     for i:=1 to cor do
       begin
          syw[i]:=sxw[i]*((a*a)/((d-b*w[i]*w[i])*(d-b*w[i]*w[i])+c*c*w[i]*w[i])) ;
       end;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ                   …€ €‘‘’ Sy(w)                 บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   W   บ');
     for i:=1 to cor do
       write(mas1,w[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Sy(w) บ');
     for i:=1 to cor do
       write(mas1,syw[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
  end;
  PROCEDURE CORBIX;
  begin
     for i:=1 to cor do
       begin
          w1:=0;
          for j:=1 to cor do
            begin
               w1:=w1+syw[j]*cos(w[j]*tim[i])*dw;
            end;
          corel3[i]:=(1/(2*3.14))* w1;
       end;
          matoge:=mat*a;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ  €’…€’—…‘… €… ”“– My(X) € •…   ',matOGE:14:3,'บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     writeln(mas1,'');

{     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ     …€ €‘‘’ Mx(T) € •… ’ ……          บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Mx(t) บ');
     for i:=1 to cor do
       write(mas1,matoge[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');}

     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ     …€ €‘‘’ Ky(T) € •… ’ ……          บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Kx(t) บ');
     for i:=1 to cor do
       write(mas1,corel3[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
     
  end;
  PROCEDURE ERGOD;
  begin
     w1:=0;
     for i:=1 to ver do
       begin
          for j:=1 to cor do
            begin
               w1:=w1+isch[i,j];
            end;
       end;
     mate:=w1/(cor*ver);
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ €’…€’—…‘… €…   —…‘ ”“–',mate:12:3,'    บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     writeln(mas1,'');
     
     k:=1;
     for i:=1 to ver do
       begin
          for j:=1 to cor do
            begin
               isch1[k]:=isch[i,j];
               k:=k+1;
            end;
       end;
     for i:=0 to cor-1 do
       begin
          w1:=0;
          for j:=1 to k-1 do
            begin
               w1:=w1+isch1[j]*isch1[j+i];
            end;
          corele[i+1]:=w1/(cor*ver-i); ;
       end;
     for i:=1 to cor do
       begin
          re[i]:=corele[i]/corele[1];
       end;
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ…€ €‘‘’ Kx(T) ’ ……  —…‘ ”“–บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Kx(t) บ');
     for i:=1 to cor do
       write(mas1,corele[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
     writeln(mas1,'');
     writeln(mas1,'ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln(mas1,'บ…€ €‘‘’ Rx(T) ’ ……  —…‘ ”“–บ');
     writeln(mas1,'ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     write(mas1,'ษอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'หออออออออ');
       end;
     writeln(mas1,'ป');
     write(mas1,'บ   T   บ');
     for i:=1 to cor do
       write(mas1,tim[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ฬอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'ฮออออออออ');
       end;
     writeln(mas1,'น');
     write(mas1,'บ Rx(t) บ');
     for i:=1 to cor do
       write(mas1,re[i]:8:3,'บ');
     writeln(mas1,'');
     write(mas1,'ศอออออออ');
     for i:=1 to cor do
       begin
          write(mas1,'สออออออออ');
       end;
     write(mas1,'ผ');
     
  end;
BEGIN
   FORMFILE;
   MATOGIDANIE;
   DISPERCIA;
   OTCLONENIE;
   CORELACIA;
   CORELACIA1;
   ZNACHENIE;
   PLOTNOCT;
   PLOTNOCT2;
   CORBIX;
   ERGOD;
   CLOSE(MAS1);
END.
