unit k_tpu;

interface

uses
	crt, graph;
type
	pozition = object
		x, y : integer;
		procedure init(coordx, coordy : integer);
		function getx : integer;
		function gety : integer;
	end;
	ballptr = ^ball;
	ball = object(pozition)
		size, col1 : word;
		mix, miy, max, may, h, dx, rad, da : integer;
		alpha : real;
		p1 : pointer;
		constructor init(color : word; radius, minx, miny, maxx, maxy : integer);
		destructor done; virtual;
		procedure show; virtual;
		procedure blind; virtual;
		procedure jump; virtual;
	end;
	v3dptr = ^v3d;
	v3d = object(pozition)
		size, col1 : word;
		m, i, h, l, l2, n, k1, k2 : integer;
		dsr, ps, l1, k, alpha : real;
		p1 : pointer;
		constructor init(xp, yp, hi, le : integer; color : word);
		destructor done; virtual;
		procedure show; virtual;
		procedure blind; virtual;
		procedure jump; virtual;
	end;
	optionptr = ^option;
	option = object(pozition)
		visible : boolean;
		le : integer;
		size : word;
		str1 : string;
		p1 : pointer;
		constructor init(coordx, coordy : integer; strop : string);
		destructor done; virtual;
		procedure show; virtual;
		function mousein(mx, my : integer; lb : boolean) : boolean; virtual;
		procedure blind; virtual;
	end;
	windopptr = ^windop;
	windop = object
		x1, x2, y1, y2 : integer;
		size1 : word;
		p : pointer;
		constructor init(x_1, y_1, x_2, y_2 : integer);
		destructor done; virtual;
		procedure show; virtual;
		procedure blind; virtual;
	end;

Procedure monkey(x, y : word);
Procedure Inter;
Procedure ResetMouse;
Procedure ShowMouse;
Procedure HideMouse;
Procedure GetMouseStatus(var x, y:integer; var lb, rb : boolean);
Procedure SetMousePos(x, y : integer);
Procedure SetMinMaxX ( min, max : integer );
Procedure SetMinMaxY ( min, max : integer );
Procedure zastavka;
Procedure initfunct(a1 : string; x : real; var res : real; var code : integer);
Procedure ramka_1;
Procedure osi_coordinat(aa, ba, ca, da : word; a, b : real; var viewon : boolean; st : string);
Procedure winexit;
Procedure errors(code : integer);

implementation

uses
	dos;

var
	r : registers;

{******************* MOUSE ***********************}

procedure Inter;
begin
	intr($33, r);
end;

procedure ResetMouse;
begin
	r.ax := 0;
	Inter;
end;

procedure ShowMouse;
begin
	r.ax := 1;
	Inter;
end;

procedure HideMouse;
begin
	r.ax := 2;
	Inter;
end;

procedure GetMouseStatus(var x, y : integer; var lb, rb : boolean);
begin
	r.ax := 3;
	Inter;
	x := r.cx + 1;
	y := r.dx + 1;
	lb := False; rb := false;
	if r.bx = 1
	then lb := True
	else
		if r.bx = 2
		then rb := True
	else
		if r.bx = 3
		then
			begin
				lb := true;
				rb := true;
			end;
end;

procedure SetMousePos(x, y : integer);
begin
	r.ax := 4;
	r.cx := x;
	r.dx := y;
	Inter;
end;

procedure SetMinMaxX ( min, max : integer );
begin
	r.ax := 7;
	r.cx := min;
	r.dx := max;
	Inter;
end;

procedure SetMinMaxY ( min, max : integer );
begin
	r.ax := 8;
	r.cx := min;
	r.dx := max;
	Inter;
end;

{************** pozition ********************}

procedure pozition.init(coordx, coordy : integer);
begin
	x := coordx;
	y := coordy;
end;

function pozition.getx : integer;
begin
	getx := x;
end;

function pozition.gety : integer;
begin
	gety := y;
end;

{**************** v3d ******************}

constructor v3d.init(xp, yp, hi, le : integer; color : word);
begin
	pozition.init(xp, yp);
	n := 25;
	col1 := color;
	h := hi;
	x := xp;
	y := yp;
	i := 1;
	l := le;
	dsr := l / n;
	ps := l / 2 * (sqrt(2) - 1);
	l1 := l / 2;
	m := y + h;
	l2 := l div 2 + round(ps);
	size := imagesize(x - l2 - 1, y - 1, x + l2 + 1, y + h * 2 + 1);
	getmem(p1, size);
end;

destructor v3d.done;
begin
	blind;
	freemem(p1, size);
end;

procedure v3d.show;
begin
	getimage(x - l2 - 1, y - 1, x + l2 + 1, y + h * 2 + 1, p1^);
	setcolor(col1);
	k := ps * sin(i * pi / n);
	k1 := round(x - l1 - k);
	k2 := round(x + l1 + k);
	line(x, y, k1, m);
	line(x, y, k2, m);
	line(k1, m, k2, m);
	line(x, y, round(x + l1 - i * dsr), m);
	line(x, y + 2 * h, k1, m);
	line(x, y + 2 * h, k2, m);
	line(x, y + 2 * h, round(x + l1 - i * dsr), m);
	setlinestyle(3, 1, 1);
	line(x, y, round(x - l1 + i * dsr), m);
	line(x, y + 2 * h, round(x - l1 + i * dsr), m);
	setlinestyle(0, 0, 0);
end;

procedure v3d.blind;
begin
	putimage(x - l2 - 1, y - 1, p1^, 0);
end;

procedure v3d.jump;
begin
	blind;
	inc(i);
	if i > n then i := 1;
	show;
end;

{**************** ball ******************}

constructor ball.init(color : word; radius, minx, miny, maxx, maxy : integer);
begin
	pozition.init(minx + radius, maxy - radius);
	randomize;
	dx := 6;
	da := 90;
	rad := radius;
	mix := minx + radius + 1;
	miy := miny + radius + 1;
	max := maxx - radius - 1;
	may := maxy - radius - 1;
	alpha := 0;
	h := may - miy;
	col1 := color;
	size := imagesize(x - rad - 1, y - rad - 1, x + rad + 1, y + rad + 1);
	getmem(p1, size);
end;

destructor ball.done;
begin
	blind;
	freemem(p1, size);
end;

procedure ball.show;
begin
	getimage(x - rad - 1, y - rad - 1, x + rad + 1, y + rad + 1, p1^);
	setcolor(col1);
	CIRCLE(x, y, rad);
end;

procedure ball.blind;
begin
	putimage(x - rad - 1, y - rad - 1, p1^, 0);
end;

procedure ball.jump;
begin
	blind;
	x := x + dx;
	alpha := alpha + pi / da;
	if alpha >= pi
	then
		begin
			alpha := 0;
			da := 60 + random(90);
			h := round((may - miy) / 4 + (may - miy) * random * 0.75);
		end;
	y := may - round(h * sin(alpha));
	if y >= may then y := may;
	if y <= miy then y := miy;
	if (x >= max)
	then
		begin
			dx := -round(2 * random);
			x := max;
		end;
	if (x <= mix)
	then
		begin
			dx := round(2 * random);
			x := mix;
		end;
	show;
end;

{******************* option *******************************}
constructor option.init(coordx, coordy : integer; strop : string);
begin
	pozition.init(coordx, coordy);
	visible := false;
	str1 := strop;
	le := length(str1);
	if x - le * 4 - 7 < 0 then x := le * 4 + 7;
	if y - 10 < 0 then y := 10;
	size := imagesize(x - le * 4 - 8, y - 11, x + le * 4 + 8, y + 11);
	getmem(p1, size);
end;

destructor option.done;
begin
	blind;
	freemem(p1, size);
end;

function option.mousein(mx, my : integer; lb : boolean) : boolean;
begin
	if (mx >= x - le * 4 - 4) and (mx <= x + le * 4 + 4 ) and (my >= y - 5) and (my <= y + 5) and lb and visible
	then mousein := true
	else mousein := false;
end;

procedure option.show;
begin
	visible:=true;
	getimage(x - le * 4 - 8, y - 11, x + le * 4 + 8, y + 11, p1^);
	setviewport(x - le * 4 - 7, y - 10, x + le * 4 + 7, y + 10, false);
	clearviewport;
	setviewport(0, 0, getmaxx, getmaxy, false);
	setcolor(8);
	rectangle(x - le * 4 - 7, y - 10, x + le * 4 + 7, y + 10);
	setfillstyle(1, lightgray);
	floodfill(x, y, 8);
	setcolor(8);
	line(x - le * 4 - 7, y - 10, x - le * 4 - 1, y - 5);
	line(x - le * 4 - 7, y + 10, x - le * 4 - 1, y + 5);
	line(x + le * 4 + 7, y - 10, x + le * 4 + 1, y - 5);
	line(x + le * 4 + 7, y + 10, x + le * 4 + 1, y + 5);
	rectangle(x - le * 4 - 1, y - 5, x + le * 4 + 1, y + 5);
	setfillstyle(1, darkgray);
	floodfill(x + le * 4 + 5, y, 8);
	floodfill(x, y + 6, 8);
	setcolor(white);
	outtextxy(x - le * 4 + 1, y - 3, str1);
end;

procedure option.blind;
begin
	visible := false;
	putimage(x - le * 4 - 8, y - 11, p1^, normalput);
end;

{****************** windop ************************}

constructor windop.init(x_1, y_1, x_2, y_2 : integer);
begin
	x1 := x_1;
	x2 := x_2;
	y1 := y_1;
	y2 := y_2;
	size1 := imagesize(x1 - 1, y1 - 1, x2 + 1, y2 + 1);
	getmem(p, size1);
end;

destructor windop.done;
begin
	blind;
	freemem(p, size1);
end;

procedure windop.show;
begin
	getimage(x1 - 1, y1 - 1, x2 + 1, y2 + 1, p^);
	setviewport(x1, y1, x2, y2, false);
	clearviewport;
	setviewport(0, 0, 639, 479, false);
	setcolor(darkgray);
	rectangle(x1, y1, x2, y2);
	setfillstyle(1, lightgray);
	floodfill(x1 + 2, y1 + 2, darkgray);
	rectangle(x1 + 5, y1 + 5, x2 - 5, y2 - 5);
	line(x1, y1, x1 + 5, y1 + 5);
	line(x1, y2, x1 + 5, y2 - 5);
	line(x2, y1, x2 - 5, y1 + 5);
	setfillstyle(1, darkgray);
	floodfill(x2 - 2, y2 - 2, darkgray);
end;

procedure windop.blind;
begin
	putimage(x1 - 1, y1 - 1, p^, normalput);
end;

{************************************************}
Procedure winexit;
var
	rk : char;
	exi : option;
	m_x, m_y : integer;
	lb, rb : boolean;
begin
	hidemouse;
	exi.init(395, 280, ' Ok ');
	exi.show;
	showmouse;
	repeat
		if keypressed
			then rk := upcase(readkey)
			else rk := #1;
		getmousestatus(m_x, m_y, lb, rb);
		delay(20);
	until exi.mousein(m_x, m_y, lb) or (rk = #13);
	hidemouse;
	exi.done;
	showmouse;
end;

Procedure errors(code : integer);
var
	w1 : windop;
begin
	w1.init(265, 200, 510, 300);
	w1.show;
	setcolor(red);
	outtextxy(370, 221, 'ERROR:');
	setcolor(black);
	case code of
		1..6 : outtextxy(334, 243, 'Syntaxis error.');
		7 : outtextxy(323, 243, 'Division by zero.');
		8 : outtextxy(312, 243, 'Error in LN function.');
	end;
	showmouse;
	winexit;
	hidemouse;
	w1.done;
	setminmaxy(1, 305);
	setminmaxx(5, 140);
	showmouse;
end;

Procedure osi_coordinat(aa, ba, ca, da : word; a, b : real; var viewon : boolean; st : string);
var
   k : integer;
   a1, a2 : string[8];
begin
	setviewport(151, 16, 624, 454, true);
	clearviewport;
	setviewport(0, 0, 639, 479, true);
	setcolor(ca);
	line(163, 20, 163, 220);
	line(163, 240, 163, 440);
	outtextxy(160, 227, 'Y');
	line(163, 20, 166, 30);
	line(163, 20, 160, 30);
	line(163, 440, 166, 430);
	line(163, 440, 160, 430);
	line(170, 440, 385, 440);
	line(405, 440, 620, 440);
	outtextxy(392, 438, 'X');
	line(170, 440, 180, 443);
	line(170, 440, 180, 437);
	line(620, 440, 610, 443);
	line(620, 440, 610, 437);
	setlinestyle(1, 1, 1);
	setcolor(darkgray);
	for k := 0 to 10 do
		begin
			line(300 + k * 30, 350, 300 + k * 30, 50);
			line(300, 50 + 30 * k, 600, 50 + 30 * k);
		end;
	setlinestyle(0, 0, 0);
	setcolor(black);
	outtextxy(40, 230, 'Minimum X: ');
	outtextxy(40, 260, 'Maximum X: ');
	str(a : 8 : 8, a1);
	str(b : 8 : 8, a2);
	setcolor(lightgray);
	for k := 0 to 100 do
		begin
			line(40 + k, 240, 40 + k, 255);
			line(40 + k, 270, 40 + k, 285);
		end;
	setcolor(blue);
	outtextxy(40, 245, a1);
	outtextxy(40, 275, a2);
	setcolor(black);
	outtextxy(45, 290, 'Minimums Y');
	outtextxy(45, 305, 'Maximums Y');
	setcolor(aa);
	circle(25, 293, 3);
	setcolor(ba);
	circle(25, 308, 3);
	viewon := false;
	setcolor(lightgray);
	for k := 6 to 634 do line(k, 460, k, 474);
	setcolor(red);
	outtextxy(20, 464, 'FUNCTION : F(x)=' + st);
end;

procedure reshenie(a1 : string; x : real; var res : real; var code : integer);
var
	a2 : string[255];
	str1 : string[8];
	str3 : string[10];
	a, b, y : real;
	simb : char;
	skobka, pos1, pos2, l_a2 : byte;
	i, cod : integer;
begin
 if code = 0
  then
   begin
    a2:=a1;
    i:=1;
    l_a2:=length(a2);
    while i<=l_a2 do
     begin
      simb:=a2[i];
      if simb='('
       then
        begin
         pos1:=i;
         skobka:=1;
         while skobka>=1 do
          begin
           inc(i);
           simb:=a2[i];
           case simb of
            '(':skobka:=skobka+1;
            ')':skobka:=skobka-1;
           end;
          end;
         pos2:=i;
         if pos2-pos1>10
          then
           begin
            reshenie(copy(a2,pos1+1,pos2-pos1-1),x,y,code);
            delete(a2,pos1+1,pos2-pos1-1);
            str(y:8:8,str1);
            insert(str1,a2,pos1+1);
            i:=i-(pos2-pos1-1)+10;
            l_a2:=length(a2);
           end;
       end
      else inc(i);
     end;
    i:=1;
    while (i<=l_a2)and(l_a2>10) do
     begin
      if a2[i]='#'
       then
        begin
         case a2[i+1] of
          '1','3'..'8':
           begin
            val(copy(a2,i+3,8),a,cod);
            case a2[i+1] of
             '1':a:=cos(a);
             '3':a:=exp(a);
             '4':a:=abs(a);
             '5':a:=sin(a);
             '6':a:=arctan(a);
             '7':a:=sqr(a);
             '8':a:=sqrt(a);
             end;
            str(a:8:8,str3);
            str3:='('+copy(str3,1,8)+')';
            delete(a2,i,12);
            insert(str3,a2,i);
            l_a2:=length(a2);
            i:=i+8;
           end;
          '2':
           begin
            val(copy(a2,i+3,8),a,cod);
            if a>0
             then
              begin
               a:=ln(a);
               str(a:8:8,str3);
               str3:='('+copy(str3,1,8)+')';
               delete(a2,i,12);
               insert(str3,a2,i);
               l_a2:=length(a2);
               i:=i+8;
              end
             else code:=8;
           end;
          end;

        end;
      i:=i+1;
     end;
    i:=1;
    while (i<=l_a2)and(l_a2>10) do
    begin
     case a2[i] of
      '*':begin
           val(copy(a2,i-9,8),a,cod);
           val(copy(a2,i+2,8),b,cod);
           a:=a*b;
           str(a:8:8,str3);
           str3:='('+copy(str3,1,8)+')';
           delete(a2,i-10,21);
           insert(str3,a2,i-10);
           l_a2:=length(a2);
           i:=i-11;
          end;
      '/':begin
           val(copy(a2,i-9,8),a,cod);
           val(copy(a2,i+2,8),b,cod);
           if b<>0 then
            begin
             a:=a/b;
             str(a:8:8,str3);
             str3:='('+copy(str3,1,8)+')';
             delete(a2,i-10,21);
             insert(str3,a2,i-10);
             l_a2:=length(a2);
             i:=i-11;
            end
            else
             begin
              code:=7;
              exit;
             end;
          end;
      end;
     i:=i+1;
    end;
    i:=1;
    while (i<=length(a2))and (length(a2)>10) do
    begin
     case a2[i] of
      '+':begin
           val(copy(a2,i-9,8),a,cod);
           val(copy(a2,i+2,8),b,cod);
           a:=a+b;
           str(a:8:8,str3);
           str3:='('+copy(str3,1,8)+')';
           delete(a2,i-10,21);
           insert(str3,a2,i-10);
           l_a2:=length(a2);
           i:=i-11;
          end;

      '-':begin
           if a2[i-1]<>'('
            then
             begin
              val(copy(a2,i-9,8),a,cod);
              val(copy(a2,i+2,8),b,cod);
              a:=a-b;
              str(a:8:8,str3);
              str3:='('+copy(str3,1,8)+')';
              delete(a2,i-10,21);
              insert(str3,a2,i-10);
              l_a2:=length(a2);
              i:=i-11;
             end;
          end;
      end;
     i:=i+1;
    end;
   val(copy(a2,2,8),res,cod);
 end;
end;


procedure initfunct(a1:string;x:real;var res:real;var code:integer);
var a2:string[255];
    str1:string[8];
    str2,str3:string[10];
    numer,a,b:real;
    simb:char;
    col_sk,skobka,pos1,l_a2:byte;
    i,cod:integer;
begin
  a2:='(('+a1+'))';
  l_a2:=length(a2);
  str(x:8:8,str1);
  str2:='('+str1+')';
  i:=1;col_sk:=0;
  while (i<=l_a2)and(code=0) do
   begin
    simb:=a2[i];
    case simb of
     'X':begin
          if a2[i+1]in['+','-','/','*','(',')']
           then
            begin
             delete(a2,i,1);
             insert(str2,a2,i);
             l_a2:=length(a2);
             i:=i+10;
            end
           else code:=6;
         end;
     'E':begin
          if (a2[i+1]='X')and
             (a2[i+3]='(')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+2]='P')
           then
            begin
             delete(a2,i,3);
             insert('#3',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else code:=6;
         end;
     'L':begin
          if (a2[i+1]='N')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+2]='(')
           then
            begin
             delete(a2,i,2);
             insert('#2',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else code:=6;
         end;
     'A':begin
          if (a2[i+1]='B')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+3]='(')and
             (a2[i+2]='S')
           then
            begin
             delete(a2,i,3);
             insert('#4',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
          else
          if (a2[i+1]='R')and
             (a2[i+2]='C')and
             (a2[i+3]='T')and
             (a2[i+4]='A')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+6]='(')and
             (a2[i+5]='N')
           then
            begin
             delete(a2,i,6);
             insert('#6',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else code:=6;
         end;
     'S':begin
          if (a2[i+1]='I')and
             (a2[i+3]='(')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+2]='N')
           then
            begin
             delete(a2,i,3);
             insert('#5',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else
          if (a2[i+1]='Q')and
             (a2[i+2]='R')and
             (a2[i+4]='(')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+3]='T')
           then
            begin
             delete(a2,i,4);
             insert('#8',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else
          if (a2[i+1]='Q')and
             (a2[i+3]='(')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+2]='R')
           then
            begin
             delete(a2,i,3);
             insert('#7',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else code:=6;
         end;
     'C':begin
          if (a2[i+1]='O')and
             (a2[i+3]='(')and
             (a2[i-1]in['-','+','/','*','('])and
             (a2[i+2]='S')
           then
            begin
             delete(a2,i,3);
             insert('#1',a2,i);
             l_a2:=length(a2);
             i:=i+2;
            end
           else code:=6;
         end;
     'P':begin
          if (a2[i+1]='I')and
             (a2[i-1]in['-','+','/','*','('])
           then
            begin
             str(pi:8:8,str1);
             str3:='('+str1+')';
             delete(a2,i,2);
             insert(str3,a2,i);
             l_a2:=length(a2);
             i:=i+10;
            end;
         end;
     ')':begin
          inc(i);
          dec(col_sk);
          if a2[i]='(' then code:=4;
         end;
     '(':begin
          inc(i);
          inc(col_sk);
          if a2[i]=')' then code:=6;
          if a2[i]='-'
           then
            begin
             str(0.0:8:8,str1);
             str3:='('+str1+')';
             insert(str3,a2,i);
             l_a2:=length(a2);
             i:=i+10;
            end;
         end;
     '0'..'9','.':
         begin
          pos1:=i;
          str3:='';
          while (a2[i] in ['0'..'9','.'])and(i<=l_a2) do
           begin
            str3:=str3+a2[i];
            inc(i);
           end;
          val(str3,numer,cod);
          str(numer:8:8,str1);
          str3:='('+str1+')';
          delete(a2,pos1,i-pos1);
          insert(str3,a2,pos1);
          l_a2:=length(a2);
          i:=i+10-(i-pos1);
        end;
      '+','-','/','*':
        begin
         inc(i);
         if a2[i] in ['+','-','/','*'] then code:=6;
        end;
      else
       begin
        inc(i);
        code:=6;
       end;
     end;
   end;
   if col_sk<>0 then code:=1;
   if code=0 then reshenie(a2,x,res,code);
end;

Procedure ramka_1;
 begin
  setcolor(darkgray);
  rectangle(1,1,639,479);
  rectangle(150,15,624,454);
  setfillstyle(1,lightgray);
  floodfill(10,10,darkgray);
  rectangle(5,5,634,474);
  rectangle(145,10,629,459);
  line(1,1,5,5);
  line(1,479,5,474);
  line(639,1,634,5);
  setfillstyle(1,darkgray);
  floodfill(638,10,darkgray);
  line(629,10,624,15);
  line(145,459,150,454);
  floodfill(146,11,darkgray);
  line(629,459,624,454);
  rectangle(10,459,139,319);
  rectangle(15,454,134,324);
  line(10,459,15,454);
  line(139,319,134,324);
  line(139,459,134,454);
  floodfill(11,454,darkgray);
  setfillstyle(1,black);
  floodfill(16,453,darkgray);
 end;

procedure monkey(x,y:word);
 var
  xc,yc,xm,ym,x1,y1,y2,x2:word;
  radius,xradius,yradius,rc:word;
  karc:arccoordstype;
 begin
  y1:=y-10;
  x1:=x-10;
  x2:=x+20;
  radius:=10;
  setcolor(brown);
  setfillstyle(solidfill,brown);
  pieslice(x1,y1,0,360,radius);
  pieslice(x2,y1,0,360,radius);
  radius:=radius-3;
  setcolor(lightred);
  setfillstyle(solidfill,lightred);
  pieslice(x1,y1,0,360,radius);
  pieslice(x2,y1,0,360,radius);
  radius:=(x2-x1)div 2-3;
  x1:=x1+radius+2;
  y1:=y1+2;
  xc:=x1;
  yc:=y1;
  setcolor(brown);
  setfillstyle(solidfill,brown);
  pieslice(x1,y1,0,360,radius);
  setcolor(brown);
  setfillstyle(solidfill,yellow);
  y2:=y1+radius-3;
  x1:=x1-radius div 2+2;
  ym:=y2;
  line(x1,y2,x1-7,y2+18);
  x2:=x1+radius-4;
  xm:=x2;
  line(x2,y2,x2+7,y2+18);
  line(x1-7,y2+18,x2+7,y2+18);
  putpixel(x2-2,y2+5,blue);
  floodfill(x2-2,y2+5,brown);
  x1:=x1-7;
  x2:=x2+7;
  y1:=y2+16;
  setcolor(green);
  setfillstyle(solidfill,green);
  bar(x1,y1,x2,y1+2);
  setcolor(blue);
  setfillstyle(solidfill,blue);
  y1:=y1+3;
  line(x1,y1,x2,y1);
  line(x1,y1,x1+13,y1+8);
  line(x2,y1,x2+2,y1+8);
  line(x1+13,y1+8,x2+2,y1+8);
  floodfill(x1+9,y1+1,blue);
  line(x1,y1,x1+2,y1+8);
  line(x1+2,y1+8,x1+9,y1+8);
  line(x1+9,y1+8,x1+14,y1+5);
  floodfill(x1+4,y1+7,blue);
  setcolor(black);
  line(x1,y1,x1+13,y1+8);
  x2:=x2+4;
  y1:=y1+8;
  setcolor(brown);
  line(x2-4,y1,x2-2,y1+4);
  line(x2-2,y1+4,x2-6,y1+9);
  line(x2-6,y1+9,x2-10,y1+9);
  line(x2-10,y1+9,x2-6,y1+4);
  line(x2-6,y1+4,x2-8,y1);
  line(x2-8,y1,x2-2,y1);
  setfillstyle(solidfill,brown);
  floodfill(x2-5,y1+1,brown);
  setcolor(blue);
  setfillstyle(solidfill,blue);
  x2:=x2-5;
  y2:=y1+11;
  xradius:=7;
  yradius:=2;
  fillellipse(x2,y2,xradius,yradius);
  setcolor(yellow);
  setfillstyle(solidfill,yellow);
  xradius:=xradius-3;
  fillellipse(x2+3,y2-1,xradius,yradius);
  x1:=x1+7;
  setcolor(brown);
  line(x1,y1,x1+2,y1+4);
  line(x1+2,y1+4,x1-2,y1+9);
  line(x1-2,y1+9,x1-6,y1+9);
  line(x1-6,y1+9,x1-2,y1+4);
  line(x1-2,y1+4,x1-4,y1);
  line(x1-4,y1,x1,y1);
  setfillstyle(solidfill,brown);
  floodfill(x1,y1+1,brown);
  setcolor(blue);
  setfillstyle(solidfill,blue);
  x2:=x1;
  y2:=y1+11;
  xradius:=7;
  yradius:=2;
  fillellipse(x2,y2,xradius,yradius);
  setcolor(yellow);
  setfillstyle(solidfill,yellow);
  xradius:=xradius-3;
  fillellipse(x2+3,y2-1,xradius,yradius);
  setcolor(brown);
  y1:=ym+5;
  x1:=xm+2;
  line(x1,y1,x1+28,y1+6);
  line(x1-1,y1+3,x1+29,y1+9);
  x2:=x1+28;
  y2:=y1+7;
  setfillstyle(solidfill,brown);
  pieslice(x2,y2,0,360,4);
  floodfill(x1+2,y1+1,brown);
  setcolor(lightmagenta);
  setfillstyle(solidfill,magenta);
  x1:=x2+3;
  y1:=y2+5;
  xradius:=22;
  yradius:=3;
  fillellipse(x1,y1,xradius,yradius);
  x1:=x1-xradius;
  x2:=x2+radius*2;
  line(x1,y1,x1+7,y1+15);
  line(x1+7,y1+15,x2-7,y1+15);
  line(x2-7,y1+15,x2,y1);
  setfillstyle(solidfill,lightmagenta);
  floodfill(x1+10,y1+14,lightmagenta);
  x1:=xm-8;
  y1:=ym+5;
  setcolor(brown);
  line(x1,y1,x1+10,y1+5);
  line(x1+10,y1+5,x1+26,y1+11);
  line(x1,y1,x1,y1+3);
  line(x1,y1+3,x1+10,y1+8);
  line(x1+10,y1+8,x1+26,y1+14);
  x2:=x1+25;
  y2:=y1+12;
  setfillstyle(solidfill,brown);
  pieslice(x2,y2,0,360,4);
  floodfill(x1+10,y1+6,brown);
  floodfill(x1+14,y1+8,brown);
  setcolor(white);
  setfillstyle(solidfill,white);
  x1:=xc-6;
  x2:=xc+4;
  y1:=yc-2;
  xradius:=2;
  yradius:=3;
  fillellipse(x1,y1,xradius,yradius);
  fillellipse(x2,y1,xradius,yradius);
  xradius:=1;
  yradius:=2;
  setcolor(blue);
  setfillstyle(solidfill,blue);
  x1:=x1+1;
  y1:=y1-1;
  x2:=x2+1;
  fillellipse(x1,y1,xradius,yradius);
  fillellipse(x2,y1,xradius,yradius);
  x1:=xc+rc div 2-4;
  y1:=yc+rc div 2;
  xradius:=10;
  yradius:=4;
  setcolor(lightred);
  setfillstyle(solidfill,lightred);
  fillellipse(x1,y1,xradius,yradius);
  setcolor(red);
  setfillstyle(solidfill,red);
  pieslice(x+6,y,0,360,3);
  setcolor(blue);
  setfillstyle(solidfill,blue);
  x1:=x+6;
  y1:=y+4;
  line(x1,y1,x1-6,y1-4);
  line(x1,y1,x1-6,y1+4);
  line(x1-6,y1-4,x1-6,y1+4);
  floodfill(x1-5,y1,blue);
  line(x1,y1,x1+6,y1-4);
  line(x1,y1,x1+6,y1+4);
  line(x1+6,y1-4,x1+6,y1+4);
  floodfill(x1+5,y1,blue);
  end;

Procedure zastavka;
var rk:char;
    w1:windop;
    a,b,c,d,e,f,g,h:v3d;
begin
 w1.init(120,140,520,380);
 w1.show;
 setcolor(lightred);
 settextstyle(1,0,0);
 outtextxy(255,165,'ARTTRIC');
 settextstyle(0,0,0);
 setcolor(black);
 outtextxy(303,315,'B Y');
 outtextxy(235,330,'V A D I M   P O P O V');
 outtextxy(170,345,'A L L   R I G H T S   R E S E R V E D');
 outtextxy(200,360,'M A R I U P O L   M C M X C V I');
 monkey(305,246);
 a.init(155,200,60,30,blue);
 a.show;
 b.init(485,200,60,30,blue);
 b.show;
 c.init(205,220,40,20,green);
 c.show;
 d.init(435,220,40,20,green);
 d.show;
 repeat
  a.jump;
  b.jump;
  c.jump;
  d.jump;
  if keypressed
   then rk:=upcase(readkey)
   else rk:=#1;
   delay(5);
 until rk=#13;
 a.done;
 b.done;
 c.done;
 d.done;
 w1.done;
end;




end.