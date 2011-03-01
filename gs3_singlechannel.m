function a = gs3_singlechannel(serobj, bank, channel)
%A = GS3_SINGLECHANNEL(SEROBJ, BANK, CHANNEL);
%
%	sets output from BANK to CHANNEL
%
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	19 June 2007 (SJS): file created
%--------------------------------------------------------------------------
debug = 0;
errflag = 0;

if ~between(bank, 1, 24)
	error('gs3_singlechannel: bank out of range [1-24]');
end

if ~between(channel, 0, 6)
	error('gs3_singlechannel: channel out of range [0 (off) - 6]');
end

try
	% writes the D/A bank
	fwrite(serobj, gs3bank(bank), 'char');

	% short pause, may be needed per Mike Walsh's suggestion
	%pause(0.1);

	% write the speaker number
	fwrite(serobj, sprintf('%d', channel), 'char');

	% write the carriage return (ASCII 13)
	fwrite(serobj, char(13));
catch
	errflag = 1;
	if debug, warning('gs3_singlechannel: write error'); end
	while serobj.BytesAvailable ~= 0
		gs3_flush(serobj);
		pause(1)
	end
	gs3_singlechannel(serobj, bank, channel)
end

if errflag
	a = -1;
else
	a = 1;
end

if debug
	disp('gs3_singlechannel:')
	char(gs3_flush(serobj))
else
	gs3_flush(serobj);
end

pause(0.05)