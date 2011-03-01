function a = gs3_multipacket(serobj, bclist)
%--------------------------------------------------------------------------
%a = gs3_multipacket(SEROBJ, bclist);
%--------------------------------------------------------------------------
%
%	sets output in bclist, where each element in bclist indicates an output
% GS3 channel (1-6) or off (0)
%
%--------------------------------------------------------------------------
% Input:
%	serobj		matlab serial port interface object for GS3 multiplexer
%	bclist		length = 24 (# of DA channels) array of values from 1-6
% 					corresponding to GS3 channel to link to each DA channel, or 
% 					0 to turn that output off
% 				
% Output:
% 	
%--------------------------------------------------------------------------
% Examples:
%
% 
%--------------------------------------------------------------------------
% SEE ALSO: gs3_open, gs3_close, gs3_packet, serial
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Created: 19 June 2007 (SJS)
%
% Revision History
%	5 October, 2009 (SJS): updated documentation	
%	6 Feb 2010 (SJS): some touchups on documentation
%--------------------------------------------------------------------------

global debug;
errflag = 0;

if (nargin ~= 2) || (length(bclist) ~= 24)
	warning([mfilename ': incorrect input'])
	a = 1;
	return
end
if ~strcmp(serobj.Status, 'open')
	warning([mfilename ': serobj not open or invalid']);
	a = 1;
	return
end
if find( (bclist < 0) | (bclist > 6) )
	warning([mfilename ': bank out of range [1-24]']);
	a = 1;
	return
end

try
	% writes the send packet command ('97')
	fwrite(serobj, '97');
	
	% write the packet
	for i = 1:24
		fwrite(serobj, sprintf('0%d', bclist(i)));
	end
catch
	errflag = 1;
	if debug, warning([mfilename ': write error']); end
	while serobj.BytesAvailable ~= 0
		gs3_flush(serobj);
		pause(1)
	end
	gs3_multipacket(serobj, bclist)
end

if errflag
	a = 1;
else
	a = 0;
end

if debug
	disp([mfilename ': '])
	char(gs3_flush(serobj))
else
	gs3_flush(serobj);
end
