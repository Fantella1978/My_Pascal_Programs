 {  �ணࠬ�� POISK �襭�� �ࠢ����� ����
   F(x)=0  ��⮤�� ࠢ����୮�� ��᫥����⥫쭮�� ���᪠ }
 USES crt;
 Type fun=Function(x:Real):Real;
  Const  eps=0.0001;
  Var x,y,u,z,h,x0,xk  :Real;

 Function F(x:Real):Real;
  { �㭪�� F(x) }
  Begin
    F:=sqr(cos(x))-sin(x)-0.25
  End;

          Procedure POISK( Var x:Real; F:fun);
     {x - ��㬥�� �㭪樨
      F - �㭪�� }
   Begin
          x:=x0;
          y:=F(x);
       Repeat
           if abs(h)<eps then
             Begin
                Writeln;
                Write ('��७� �ࠢ�����   ');
                Write (x:10:4);
                Repeat Until KeyPressed;
                Halt;
             End;
          x:=x+h;
          z:=F(x);
          if y*z<0 then
               Begin
                 h:=-h/2;
                 y:=z;
               End;
       Until x>xk;
          Writeln('�� ���ࢠ�� ��୥� ���');
          Repeat Until KeyPressed;
  End;
  Begin
     ClrScr;
     Writeln('     ������:');
     Write('���ࢠ�  ���� �ࠢ�����  x0 xk   ');
     Read (x0,xk);
     Write('��� ���᪠ (��ࢮ��砫��)  ');
     Read (h);
     POISK(x,F);
  End.