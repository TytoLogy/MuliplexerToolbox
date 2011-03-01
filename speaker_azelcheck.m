function [sflag, sdat] = speaker_azelcheck(az, el, in_table)
%sdat = speaker_azelcheck(az, el)
% 
% Checks for speaker data for the az, el combination
%
% If the speaker at az and el exists, sflag == 1 and sdat (if requested)
% contains the speaker information from the speaker lookup table.
%
% If the speaker is not found, sflag == 0 and sdat elements are set to -1
%
% The speaker lookup table is defined in the array/m-file xlsmap.
% 	
% Example:
% 
% 	Find data for the (0, 0) (az = 0, el = 0) speaker:
% 
% 		>> speaker_data('azel', [0 0])
% 		ans = 
% 			speakernum: 73
% 			  azimuths: 0
% 			elevations: 0
% 			  termbank: 6
% 			   termnum: 23
% 			 dachannel: 22
% 			mpxchannel: 6
% 				xlsmap: [73 0 0 6 23 22 6]
% 				   row: 132
% 
% 	Find data for the (-200, 99) speaker (doesn't exist):

%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	15 Jan 2007 (SJS):	file created from speaker_data.m
%--------------------------------------------------------------------------

if nargin < 3
	load xlsmap
else
	xlsmap = in_table;
end

[row, col, val] = find( (xlsmap(:, 2) == az) & (xlsmap(:, 3) == el) );

if isempty(row)
	sflag = 0;
	if nargout > 1
		sdat.speakernum = -1;
		sdat.azimuths = -1;
		sdat.elevations = -1;
		sdat.termbank = -1;
		sdat.termnum = -1;
		sdat.dachannel = -1;
		sdat.mpxchannel = -1;
		sdat.xlsmap = -1;
		sdat.row = -1;
	end
else
	sflag = 1;
	if nargout > 1
		sdat.speakernum = xlsmap(row, 1);
		sdat.azimuths = xlsmap(row, 2);
		sdat.elevations = xlsmap(row, 3);
		sdat.termbank = xlsmap(row, 4);
		sdat.termnum = xlsmap(row, 5);
		sdat.dachannel = xlsmap(row, 6);
		sdat.mpxchannel = xlsmap(row, 7);
		sdat.xlsmap = xlsmap(row, :);
		sdat.row = row;
	end
end


