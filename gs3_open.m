function serobj = gs3_open(port)
%--------------------------------------------------------------------------
% GS3_OPEN(port) establishes communication with GS3 multiplexer
%--------------------------------------------------------------------------
% Multiplexer toolbox
%--------------------------------------------------------------------------
% Input:
% 	port	com port that is assigned by operating system to the GS3
% 			USB interface.  Default, if port is not specified, is COM6
% 				
% Output:
% 	serobj	serial object 
% 	
%--------------------------------------------------------------------------
% Examples:
%
%	Open port at default location:
%
%		s = gs3_open;
%
% 	Open port COM9:
% 	
% 		s = gs3_open('COM9')
%-------------------------------------------------------------------------- 
% SEE ALSO: gs3_close, serial, fopen, set, get
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	19 June 2007 (SJS): file created
%	18 December 2007 (SJS): help documentation added
%	23 Feb 2010 (SJS): update documentation
%--------------------------------------------------------------------------

if ~nargin
	port = 'COM6';
	disp('gs3_open: using default port (COM6)');
end

serobj = serial(port);
set(serobj, 'InputBufferSize', 2048);

try
	fopen(serobj);
catch
	gs3_forceclose;
	pause(1)
	gs3_forceclose;
	fopen(serobj)
end
	

if ~strcmp(serobj.Status, 'open')
	delete(serobj);
	serobj = 0;
	warning('gs3_open: could not open serial object for GS3');
else
	set(serobj, 'RecordName', 'record.txt');
	set(serobj, 'RecordMode', 'index');
	set(serobj, 'RecordDetail', 'verbose');
	set(serobj, 'FlowControl', 'hardware');
	record(serobj, 'off')
end



