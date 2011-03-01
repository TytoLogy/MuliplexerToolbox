function [dachannel, mpxchannel, actual_az, actual_el] = getSpeakerFromArray(az, el, map)
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
%	11 March 2008 (SJS): file created from speaker_map().m
%--------------------------------------------------------------------------
errflag = 0;

testarr = [az.*ones(size(map.azimuths)) el.*ones(size(map.elevations))];

s = ([map.azimuths map.elevations] == testarr);

[row, col, val] = find(sum(s, 2) == 2);

if ~isempty(row)
	dachannel = map.dachannel(row);
	mpxchannel = map.mpxchannel(row);
	actual_az = map.azimuths(row);
	actual_el = map.elevations(row);
else
	warning('speaker_map: requested az/el combination not available')
	dachannel = -1;
	mpxchannel = -1;
	actual_az = -1;
	actual_el = -1;
end




