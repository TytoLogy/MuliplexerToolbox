function a = gs3_alloff(serobj)
%GS3_ALLOFF(SEROBJ);
%
%	Turns em all off!
%
% Input:
% 				
% Output:
% 	
% Examples:
%
% 
% SEE ALSO: gs3_open, gs3_close, serial
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	15 Jan, 2008 (SJS): file created
%--------------------------------------------------------------------------

global debug;
errflag = 0;

if ~strcmp(serobj.Status, 'open')
	warning('gs3_alloff: serobj not open or invalid');
	a = 1;
	return
end

a = gs3_multipacket(serobj, zeros(24, 1));

gs3_flush(serobj);