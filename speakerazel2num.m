function speaker_num = speakerazel2num(az, el)
%SPEAKER_NUM = SPEAKERNUM2AZEL(az, el)
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

[sflag, sdata] = speaker_azelcheck(az, el);

if ~sflag
	azelstr = sprintf('az: %d el: %d', az, el);
	disp(['speakerazel2num: No speaker @ ' azelstr]);
	error('speakerazel2num: [-100 <= az <= 100] [100 <= el <= 80]');
end

speaker_num = sdata.speakernum;
