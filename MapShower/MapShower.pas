program MapMaker;
{$M 9999,0,0}
uses dos,crt,mouse;
  var
    map:array[1..100,1..100]of longint;
    mama:array[1..900,1..3]of longint;
    i,j,k:longint;
    sum:longint;
    colour:longint;
  procedure zhongwen;
    var
      f:text;
    begin
      assign(f,'aaa.bat');
      rewrite(f);
      writeln(f,'@echo off');
      writeln(f,'@chcp 936');
      writeln(f,'@title Snake MapShower');
      writeln(f,'@mode con: cols=80 lines=25');
      writeln(f,'@del aaa.bat');
      close(f);
      exec('aaa.bat','');
      clrscr;
    end;
  procedure backcolor(a:longint);
    begin
      textbackground(a);
    end;
  procedure zzzzcolor(a:longint);
    begin
      textcolor(a);
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

procedure colorapple;
  begin
    textbackground(12);
    textcolor(17);
  end;
procedure colorsurround;
  begin
    textcolor(0);
    textbackground(colour);
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
procedure readxx;
  var
    i:longint;
  begin
    readln(sum);
    for i:=1 to sum do
      readln(mama[i,1],mama[i,2],mama[i,3]);
  end;
procedure printmap;
  var
    i,j,k:longint;
  begin
    for i:=1 to sum do
      case mama[i,3] of
        1:begin  colorsurround; print('©|',mama[i,1],mama[i,2]); end;
        2:begin colorapple; print('¡î',mama[i,1],mama[i,2]); end;
      end;
  end;
begin
  zhongwen;
  readxx;
  colour:=1;
  while true do
    begin
      colour:=(colour mod 7)+1;
      makescr;
      colorsnake;
      gotoxy(2*2-1,2);write('¡ð¡ð¡ð¡ò');
      printmap;
      readkey;
    end;
end.
