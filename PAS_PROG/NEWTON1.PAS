 {  �ணࠬ�� NEWTON1 �襭�� �ࠢ����� ����
          F(x)=0  ��⮤�� ���⮭� }
 USES crt;
 Type fun=Function(x:Real):Real;
 Var u,z  :Real;

Function F(x:Real):Real;
  { �㭪�� F(x) }
  Begin
    F:=((x-6)*x+11)*x-2
  End;

Function F1(x:Real):Real;
  { �ந������� �㭪樨 F(x) }
  Begin
    F1:=(3*x-12)*x+11;
  End;

Procedure NEWTON( Var y:Real;x:Real; F:fun);
     {x - ��㬥�� �㭪樨
      F - �㭪��
      y - ��७� �ࠢ�����}
  Const  eps=0.0001;
  Var     i:Integer;
          u:Real;
  Begin
          i:=1;
        Repeat
          y:=x-F(x)/F1(x);
          u:=x;
          x:=y;
          i:=i+1;
          If i-200>0 then
            Begin
              Writeln('����� �� �室����');
              Repeat Until KeyPressed;
              Halt;
            End;
        Until abs(y-u)<=eps;
    Writeln
  End;


BEGIN
  ClrScr;
  Writeln('������:');
  write('��室��� �ਡ������� ���� �ࠢ�����  ');
  Read (u);
  NEWTON(z,u,F);
  Write ('��७� �ࠢ�����   ');
  write (z:10:4);
  Repeat Until KeyPressed;
END.