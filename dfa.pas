program DFA;
{Program implementasi DFA pada Marble Rolling Toy
 oleh : Adi Purnama (13514006)
}

//KAMUS
var
	info:Text;
	temp,temp2,input_string,current_state:	string;
	i,n,j,k,st,sy:integer;
	n_states: integer;
	stop,flag_error:boolean;
	states 	   : array[1..100] of string;	
	symbol 	   : array[1..100] of string;
	transition : array[1..100,1..100] of string;
	initial	   : string;
	final 	   : array[1..100] of string;
	
function delta(state:string;symbol:string):string;
{ Fungsi Transisi, menerima input state saat ini & simbol yang dimasukkan, output
state selanjutnya setelah diberi input simbol}
var
	i,index:integer;
	found:boolean;
begin
	i:=1;
	found:=false;
	while ((i<=n_states) and (not found)) do
		begin
		if (states[i] = state) then
			begin
				index:=i;
				found:=true;
			end
		else
			begin
				i:=i+1;
			end;
		end;
	if (symbol='A') then
		begin
		delta:=transition[index][2];
		end
	else 
		begin
		delta:=transition[index][3];
		end;
		
	
end;
	
procedure load_file();
// Membuka dan memasukkan informasi DFA dari file eksternal ke program
begin
	//Membuka file eksternal yang berisi informasi mengenai DFA
	assign(info, 'info.txt');
	reset(info);
	
	//Baca Daftar States
	readln(info,temp);
	n:=0;
	stop:=false;
	repeat
		readln(info,temp);
		if (temp <> '---') then
			begin
			n:=n+1;
			states[n]:=temp;
			end
		else
			stop:=true;
	until stop;
	n_states:=n;
	
	//Baca Symbol
	readln(info,temp);
	n:=0;
	stop:=false;
	repeat
		readln(info,temp);
		if (temp <> '---') then
			begin
			n:=n+1;
			symbol[n]:=temp;
			end
		else
			stop:=true;
	until stop;
		
	
	//Baca Initial State;
	readln(info,temp);
	readln(info,temp);
	initial:=temp;
	readln(info,temp);
	
	//Baca Final State
	readln(info,temp);
	n:=0;
	stop:=false;
	repeat
		readln(info,temp);
		if (temp <> '---') then
			begin
			n:=n+1;
			final[n]:=temp;
			end
		else
			stop:=true;
	until stop;
	
	
	//Baca Fungsi Transisi
	readln(info,temp);
	n:=0;
	stop:=false;
	st := 1;
	sy := 1;
	repeat
		readln(info,temp);
		if (temp <> '---') then
			begin
			temp2:='    ';
			k:=1;
			for j:=1 to length(temp) do
				begin
				if (temp[j] <> '	')  then
					begin
					temp2[k]:=temp[j];
					k:=k+1;
					end
				else
					begin
					k:=1;
					transition[st][sy] := temp2;
					sy:=sy+1;
					end;
				end;
			transition[st][sy] := temp2;
			sy:=1;
			st:=st+1;
			end
		else
			stop:=true;
	until stop;
	close(info);
end;

//Program Utama	
begin
	writeln(' Program Implementasi DFA Pada Marble Rolling Toy  ');
	writeln('---------------------------------------------------');
	writeln('         Oleh : Adi Purnama - 13514006             ');
	writeln;
	writeln;
	load_file;
	
	//Memasukkan input pengguna
	//Program akan memvalidasi apakah input yang diberikan pengguna sesuai dengan simbol pada DFA
	repeat
		flag_error:=false;
		write('Input String	: ');
		readln(input_string);
		input_string := upcase(input_string);
		for i:=1 to length(input_string) do
			begin
			if ((input_string[i] <> 'A') and (input_string[i] <> 'B') ) then
				begin
				flag_error := true;
				end;
			end;
		if flag_error then
			begin
			writeln('Error - Simbol yang diperbolehkan hanyalah A & B. Mohon ulangi input..');
			end;
	until not flag_error;
	writeln;
	
	
	//Menulis lintasan state
	current_state:=initial;
	writeln('Lintasan State	: ',current_state);
	for i:=1 to length(input_string) do
		begin
			current_state:=delta(current_state,input_string[i]);
			writeln('              	  ',current_state);
		end;
	writeln;
	
	//Menulis status DFA (Menerima/Menolak)
	if (current_state[4] = 'a') then
		begin
		writeln('Masukan Diterima');
		end
	else
		begin
		writeln('Masukan Ditolak');
		end;
	
end.
