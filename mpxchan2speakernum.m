function sdat = mpxchan2speakernum(dachan, mpxchan)
% sdat = mpxchan2speakernum(dachan, mpxchan)
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

if ~between(dachan, 1, 24)
	error('speakermpxdata: dachan out of range [1 <= s <= 24]');
end
if ~between(mpxchan, 1, 6)
	error('speakermpxdata: mpxchan out of range [1 <= s <= 6]');
end

load xlsmap

testarr = [dachan.*ones(size(xlsmap(:, 1))) mpxchan.*ones(size(xlsmap(:, 1)))];

s = (xlsmap(:,  6:7) == testarr);

[row, col, val] = find(sum(s, 2) == 2);

if isempty(row)
	disp('isempty')
else
	sdat = speaker_data('speakernum', xlsmap(row, 1));
end
