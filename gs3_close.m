function gs3_close(serobj)
% GS3_CLOSE	close communication with GS3 multiplexer
%--------------------------------------------------------------------------
% Multiplexer toolbox
%--------------------------------------------------------------------------
% Input:
% 	serobj	serial object that is assigned GS3_OPEN
% 				
%--------------------------------------------------------------------------
% Examples:
%
% 	gs3_close(serobj)
% 
%--------------------------------------------------------------------------
% SEE ALSO: gs3_open, serial, fclose
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sharad.shanbhag@einstein.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	19 June 2007 (SJS): file created
%	18 December 2007 (SJS): help documentation added
%	23 Feb 2010 (SJS):
%		- updated documentation
%		- added try... catch... statements to trap errors
%--------------------------------------------------------------------------



if ~nargin
	error('gs3_close: no serobj provided');
end

try
	fclose(serobj);
catch
	error('%s could not close GS3 object', mfilename);
	gs3_forceclose
end

try
	delete(serobj);
catch
	error('%s: could not delete GS3 object', mfilename);
	gs3_forceclose
end

try
	clear serobj
catch
	error('%s: could not clear GS3 object', mfilename);
	gs3_forceclose
end
	


