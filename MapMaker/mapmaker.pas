program MapMaker;
{$M 9999,0,0}
uses dos,crt,mouse;
  var
    map:array[1..100,1..100]of longint;
    i,j,k:longint;
    mo:TMouseEvent;
    XXX,YYY,TTT:longint;
    sum:longint;

  procedure backcolor(a:longint);
    begin
      textbackground(a);
    end;
  procedure zzzzcolor(a:longint);
    begin
      textcolor(a);
    end;
  procedure zhongwen;
    var
      f:text;
    begin
      assign(f,'aaa.bat');
      rewrite(f);
      writeln(f,'@echo off');
      writeln(f,'@chcp 936');
      writeln(f,'@title Snake MapMaker');
      writeln(f,'@mode con: cols=80 lines=25');
      writeln(f,'@del aaa.bat');
      close(f);
      exec('aaa.bat','');
      clrscr;
    end;
procedure print(s:string; x,y:longint);
  begin
    gotoxy(2*x-1,y);
    write(s);
    inc(x);
  end;

procedure colorsnake;
  begin
    textbackground(green);
    textcolor(14);
  end;

procedure colorsnake2;
  begin
    textbackground(3);
    textcolor(20);
  end;
procedure colorapple;
  begin
    textbackground(12);
    textcolor(17);
  end;
procedure colorsurround;
  begin
    textcolor(red);
    textbackground(blue);
  end;
procedure makescr;
  var
    col,line:longint;
  begin
    textbackground(black);
    clrscr;
    col:=40; line:=24;
    colorsurround;
    for i:=1 to line do
      begin
        print('©¦',1,i);
        print('©¦',col,i);
      end;
    gotoxy(1,1);
    for i:=1 to col do print('©¤',i,1);
    print('©°',1,1);
    print('©´',col,1);
    gotoxy(1,line);
    for i:=1 to col do print('©¤',i,line);
    gotoxy(1,line); write('©¸');
    print('©¼',col,line);
    print('00000000',2,1);

    print('Keadin | Z.Q.  ÖÆ×÷',col-12,line);
    textbackground(black);
    textcolor(white);
    print('ÔÝÍ£ : P',1,line+1);
    print('C : ¼ÌÐø',40-3,line+1);
  end;
procedure findd(mo:TMouseEvent);
  var
    mo1:TMouseEvent;
  begin
    mo1:=mo;
    XXX:=(mo1.x+2)div 2;
    YYY:=mo1.y+1;
    TTT:=mo1.buttons;
  end;
procedure save;
  var
    f:text;
    i,j,k:longint;
  begin
    sum:=0;
    for i:=2 to 39 do
      for j:=2 to 23 do
        if map[i,j]<>0 then inc(sum);
    assign(f,'MapDATE.Keadin'); rewrite(f);
      writeln(f,sum);
      for i:=2 to 39 do
        for j:=2 to 23 do
          if map[i,j]<>0 then writeln(f,i,' ',j,' ',map[i,j]);
    close(f);
  end;
procedure readmap;
  var
    f:text;
    i,j,k,x,y,z:longint;
  begin
    assign(f,'MapDATE.Keadin');reset(f);
    readln(f,j);
    for i:=1 to j do
      begin
        readln(f,x,y,z);
        case z of
          1:begin map[x,y]:=z; colorsurround; print('©|',x,y); end;
          2:begin map[x,y]:=z; colorapple; print('¡î',x,y); end;
        end;
      end;
    close(f);
    //colorsnake;
    //gotoxy(39*2-1,23);
    //write('¡î');
  end;
begin
  zhongwen;
  makescr;
  readmap;
  colorsnake;
  gotoxy(2*2-1,2);write('¡ð¡ð¡ð¡ò');
  initmouse;
  getMouseEvent(mo);
  fillchar(map,sizeof(map),0);
  while true do
        begin
          getMouseEvent(mo);
          //if mo.action=2
          //  then begin
                   findd(mo);
                   if ((XXX=1)or(XXX>39)or(YYY=1)or(YYY>23))and(mo.action=1) then break;
                   if ((XXX=1)or(XXX>39)or(YYY=1)or(YYY>23)) then continue;
                   case TTT of
                     1:begin colorsurround; print('©|',XXX,YYY); map[XXX,YYY]:=TTT;XXX:=0;YYY:=0;end;
                     2:begin colorapple; print('¡î',XXX,YYY);map[XXX,YYY]:=TTT;XXX:=0;YYY:=0; end;
                     4:begin backcolor(0);print('  ',XXX,YYY);map[XXX,YYY]:=0;XXX:=0;YYY:=0; end;
                   end;
                // end;
        end;
  save;
end.
