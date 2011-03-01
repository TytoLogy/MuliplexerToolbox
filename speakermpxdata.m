function sdat = speakermpxdata(bank, chan)
%sdat = speaker_data(dtype, d)
% 
% dtype:
% 	location
% 
% 
% speakernum = xlmap(:, 1);
% azimuths = xlmap(:, 2);
% elevations = xlmap(:, 3);
% termbank = xlmap(:, 4);
% termnum = xlmap(:, 5);
% dachannel = xlmap(:, 6);
% mpxchannel = xlmap(:, 7);
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	12 Sept 2007 (SJS): file created
%--------------------------------------------------------------------------
load xlsmap

if ~between(bank, 1, 6)
	error('speakermpxdata: bank out of range [1 <= s <= 6]');
end
if ~between(chan, 1, 6)
	error('speakermpxdata: chan out of range [1 <= s <= 6]');
end

load xlsmap

testarr = [bank.*ones(size(xlsmap(:, 1))) chan.*ones(size(xlsmap(:, 1)))];

s = (xlsmap(:,  4:5) == testarr);

[row, col, val] = find(sum(s, 2) == 2);

if isempty(row)
	disp('isempty')
else
	sdat = speaker_data('speakernum', xlsmap(1, row));
end
