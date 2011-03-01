function azel = speakernum2azel(num)
%AZEL = SPEAKERNUM2AZEL(NUM)
%
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	19 June 2007 (SJS): file created
%--------------------------------------------------------------------------
if ~between(num, 1, 144)
	error('speakernum2azel: num out of range [1 <= num <= 144]');
end

sdata = speaker_data('speakernum', num);

azel = [sdata.azimuths sdata.elevations];
