function [dachannel, mpxchannel, actual_az, actual_el] = speaker_map(az, el)
%[DACHANNEL, MPXCHANNEL, varargout] = SPEAKER_MAP(AZ, EL)
%
%	sets output from BANK to CHANNEL.  will return closest speaker to 
%	az and el requested
%	
%	AZ			speaker azimuth (-110 - 110 deg)
%	EL			speaker elevation (-90 90 deg)
%
%Examples:
%
%	set bank 2 to channel 5:
%
%		speaker_map(S, 2, 5)
%
%	set bank 2 to channel 5, bank 3 to channel 2, bank 20 to channel 3:
%
%		speaker_map(S, [2 3 30], [5 2 3])
%
%	implements lookup table for speaker array.
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
	error('speaker_map: az and el arrays must be same size');
end

if ~between(az, -100, 100)
	error('speaker_map: az out of range [-100 <= az <= 100]');
end

if ~between(el, -80, 80)
	error('speaker_map: el out of range [-80 <= el <= 80]');
end

load arraymap

testarr = [az.*ones(size(azimuths)) el.*ones(size(elevations))];

s = ([azimuths elevations] == testarr);

[row, col, val] = find(sum(s, 2) == 2);

if isempty(row)
	warning('speaker_map: requested az/el combination not available')
	dachannel = -1;
	mpxchannel = -1;
	actual_az = -1;
	actual_el = -1;
else
	dachannel = dachannel(row);
	mpxchannel = mpxchannel(row);
	actual_az = azimuths(row);
	actual_el = elevations(row);
end




