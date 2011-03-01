function a = set_speaker(serobj, az, el)
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

if length(az) ~= length(el)
	error('set_speaker: az and el arrays must be same size');
end

if ~between(az, -100, 100)
	error('set_speaker: az out of range [-100 <= az <= 100]');
end

if ~between(el, -80, 80)
	error('set_speaker: el out of range [-80 <= el <= 80]');
end

% lookup the bank and channel for the az and el combination
[dachannel, mpxchannel, aaz, ael] = speaker_map(az, el);

a = gs3_packet(serobj, dachannel, mpxchannel);
