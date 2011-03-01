function A = gs3_read(s)

if nargin ~= 1
	error('gs3_read: incorrect input args');
end

if ~strcmp(s.Status, 'open')
	error('gs3_read: serial port not open or misconfigured');
end

retval = gs3_bufwait(s);

if retval == 0
	A = 0;
	return
end

if s.BytesAvailable > 0
	a = fread(s, s.BytesAvailable);
else
	warning('gs3_read: read error');
	A = -1;
	return
end

% there are typically 2 repeats of the pattern [1 0] at the start

nstart = min(find(a==48));

if isempty(nstart)
	warning('gs3_read: start of status string not found');
	A = -1;
	return
end

nend = length(a);

ar = a(nstart:nend);
if length(ar) ~= 288
	warning('gs3_read: start of status string not found');
	A = -1;
	return
end

A = zeros(24, 11);
j = 0;
for i = 1:24
	A(i, :) = ar(j+1:j+11)';
	j = j+12;
end
