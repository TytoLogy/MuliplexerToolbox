function a = gs3_channel(serobj, bank, channel)
%A = GS3_CHANNEL(SEROBJ, BANK, CHANNEL);
%
%	sets output from BANK to CHANNEL.  Only
%	
%	SEROBJ		handle to serial port object
%	BANK		D/A bank, [1-24], can be array of bank numbers
%	CHANNEL		speaker output channel 0=off, or [1-6]
%				if array, must be equal to length of BANK
%
%
%Examples:
%
%	set bank 2 to channel 5:
%
%		gs3_channel(S, 2, 5)
%
%	set bank 2 to channel 5, bank 3 to channel 2, bank 20 to channel 3:
%
%		gs3_channel(S, [2 3 30], [5 2 3])
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

if length(bank) ~= length(channel)
	error('gs3_channel: BANK and CHANNEL arrays must be same size');
end

if ~between(bank, 1, 24)
	error('gs3_channel: bank out of range [1-24]');
end

if ~between(channel, 0, 6)
	error('gs3_channel: channel out of range [0 (off) - 6]');
end

% create an array of zeros
pak = zeros(1, 24);

% set the bank to the desired channel
pak(bank) = channel;

try
	fwrite(serobj, '97')
	for i = 1:24
		fwrite(serobj, sprintf('0%d', pak(i)));
	end
	a = char(gs3_read(serobj));
catch
	errflag = 1;
	if debug, warning('gs3_channel: error'); end
	while serobj.BytesAvailable ~= 0
		gs3_flush(serobj);
		pause(1)
	end
	a = char(gs3_read(serobj));
end

if errflag
	a = -1;
end
