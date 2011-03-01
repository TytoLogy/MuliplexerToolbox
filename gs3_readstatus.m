function A = gs3_readstatus(serobj)
%A = GS3_READSTATUS(SEROBJ);
%
%	gets the GS3 multiplexer status
%
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sshanbha@aecom.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	19 June 2007 (SJS): file created
%--------------------------------------------------------------------------
MAXCOUNT = 5;
debug = 1;

if nargin ~= 1
	error('gs3_readstatus: incorrect input args');
end

if ~strcmp(serobj.Status, 'open')
	error('gs3_readstatus: serial port not open or misconfigured');
end

while serobj.BytesAvailable ~= 0
	gs3_flush(serobj);
	pause(1)
end

fwrite(serobj, '99');

rflag = 0;
count = 0;

while rflag == 0
	bflag = gs3_bufwait(serobj, 2);
	if bflag == 1
		rflag = 1;
	elseif bflag == -1 
		if debug, warning('gs3_readstatus: timeout, resetting...'); end
		while serobj.BytesAvailable ~= 0
			gs3_flush(serobj);
			pause(1)
		end
		rflag = 0;
		count = count + 1;
		fwrite(serobj, '99');
	end
	
	if count > MAXCOUNT
		warning('gs3_readstatus: timeout error');
		A = -1;
		return
	end
		
end


if serobj.BytesAvailable > 0
	a = fread(serobj, serobj.BytesAvailable);
else
	if debug, warning('gs3_readstatus: read error'); end
	A = -1;
	return
end

% there are typically 2 repeats of the pattern [1 0] at the start
nstart = min(find(a==48));

if isempty(nstart)
	if debug
		warning('gs3_readstatus: start of status string not found');
		save gs3_readstatuserror a	
	end
	A = -1;
	return
end

ar = a(nstart:length(a));
if length(ar) ~= 288
	if debug
		warning('gs3_readstatus: start of status string not found');
		save gs3_readstatuserror ar a
	end
	A = -2;
	return
end

A = zeros(24, 11);
j = 0;
for i = 1:24
	A(i, :) = ar(j+1:j+11)';
	j = j+12;
end
