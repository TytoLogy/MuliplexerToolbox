function A = gs3_flush(s)

if nargin ~= 1
	error('gs3_flush: incorrect input args');
end

if ~strcmp(s.Status, 'open')
	error('gs3_flush: serial port not open or misconfigured');
end

if s.BytesAvailable > 0
	A = fread(s, s.BytesAvailable);
else
	A = 0;
end
