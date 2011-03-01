%fwrite(s, '12', 'char');	% writes the channel


fwrite(s, gs3bank(1), 'char');
pause(0.1);					% short pause, needed per Mike Walsh's suggestion
%fwrite(s, '1', 'char');		% write the speaker number
fwrite(s, sprintf('%d', 2), 'char');

fwrite(s, char(13));		% write the carriage return (ASCII 13)
pause(0.5);					
gsr