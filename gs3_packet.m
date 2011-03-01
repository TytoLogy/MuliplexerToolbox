function a = gs3_packet(serobj, bank, channel)
%GS3_PACKET(SEROBJ, BANK, CHANNEL);
%
%	sets output from BANK to CHANNEL
%		1 <= bank <= 24
%		0 <= channel <= 6
%
% Input:
% 				
% Output:
% 	
% Examples:
%
% 
% SEE ALSO: gs3_open, gs3_close, serial
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	19 June 2007 (SJS): file created
%--------------------------------------------------------------------------

global debug;
errflag = 0;


if ~between(bank, 1, 24)
	error('gs3_channel: bank out of range [1-24]');
end

if ~between(channel, 0, 6)
	error('gs3_channel: channel out of range [0 (off) - 6]');
end

pak = zeros(24, 1);
pak(bank) = channel;

try
	% writes the send packet command ('97')
	fwrite(serobj, '97');
	
	% write the packet
	for i = 1:24
		fwrite(serobj, sprintf('0%d', pak(i)));
	end
catch
	errflag = 1;
	warning('   gs3_packet: write error, retrying write to GS3...');
	while serobj.BytesAvailable ~= 0
		gs3_flush(serobj);
		pause(0.2)
	end
	gs3_packet(serobj, bank, channel);
end

if errflag
	a = 1;
else
	a = 0;
end

if debug
	disp('gs3_packet:')
	char(gs3_flush(serobj))
else
	gs3_flush(serobj);
end
