function sdat = speaker_data(dtype, d, in_table)
%sdat = speaker_data(dtype, d)
% 
% Returns speaker data for the array
%
% dtype is a string that describes the type of data given by value d, and
% may take one of the following values:
% 
% 
% 	speaker # (1-144)		{'speakernum', 'speaker', 'spe', 'sp', 'spk', 'sn'}
% 	azimuth (-100 - 100)	{'azimuths', 'azimuth', 'azs', 'az'}
% 	elevation (-80 - 80)	{'elevations', 'elevation', 'els', 'el'}
% 	terminal bank (1-6)		{'termbank', 'termb', 'bank', 'tb'}
% 	terminal number (1-49)	{'termnum', 'termn', 'tnum', 'tn'}
% 	D/A channel (1-24)		{'dachan', 'dac', 'da', 'chan', 'channel', 'dachannel'}
% 	GS3 Channel (1-6)		{'mpxchan', 'mpx', 'mp', 'mpxchannel'}
% 	[az el]					{'azel'}
% 
% The speaker lookup table is defined in the array/m-file xlsmap.
% The speaker_data function provides a search front-end for finding specific
% values within the lookup table.
% 	
% Example:
% 
% 	Find the data for speaker number 73 (zero speaker):
% 	
% 		>> speaker_data('speakernum', 73)
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
% 	Find data for all speakers at azimuth -70:
% 		>> speaker_data('az', -70)
% 		ans = 
% 			speakernum: [7x1 double]
% 			  azimuths: [7x1 double]
% 			elevations: [7x1 double]
% 			  termbank: [7x1 double]
% 			   termnum: [7x1 double]
% 			 dachannel: [7x1 double]
% 			mpxchannel: [7x1 double]
% 				xlsmap: [7x7 double]
% 				   row: [7x1 double]
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
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	12 Sept 2007 (SJS): file created
%	10 Jan 2007 (SJS):	upgraded help, at long last
%	15 Jan 2007 (SJS):	changed code for the [az el] search to be faster
%--------------------------------------------------------------------------

if nargin < 3
	load xlsmap
else
	xlsmap = in_table;
end


switch dtype
	case {'speakernum', 'speaker', 'spe', 'sp', 'spk', 'sn'}
		search_col = 1;
	case {'azimuths', 'azimuth', 'azs', 'az'}
		search_col = 2;
	case {'elevations', 'elevation', 'els', 'el'}
		search_col = 3;
	case {'termbank', 'termb', 'bank', 'tb'}
		search_col = 4;
	case {'termnum', 'termn', 'tnum', 'tn'}
		search_col = 5;
	case {'dachan', 'dac', 'da', 'chan', 'channel', 'dachannel'}
		search_col = 6;	
	case {'mpxchan', 'mpx', 'mp', 'mpxchannel'}
		search_col = 7;
		if d == 0
			d = 1;
		end
	case {'azel'}
		search_col = [2 3];	
	otherwise
		disp('unknown type, using default speakernum')
		search_col = 1;
end

if length(search_col) ~= 2
	[row, col, val] = find(xlsmap(:, search_col) == d);
else
% 	onesarr = ones(size(xlsmap(:, 1)));
% 	testarr = [d(1).*onesarr d(2).*onesarr];
% 
% 	s = (xlsmap(:, search_col) == testarr);
%	[row, col, val] = find(sum(s, 2) == 2);

	[row, col, val] = find( (xlsmap(:, search_col(1)) == d(1)) & ...
							(xlsmap(:, search_col(2)) == d(2)) );
end

if isempty(row)
	warning(sprintf('speaker_data: %d not found', d))
	sdat.speakernum = -1;
	sdat.azimuths = -1;
	sdat.elevations = -1;
	sdat.termbank = -1;
	sdat.termnum = -1;
	sdat.dachannel = -1;
	sdat.mpxchannel = -1;
	sdat.xlsmap = -1;
	sdat.row = -1;
else
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


