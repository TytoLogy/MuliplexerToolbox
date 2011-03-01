function out = gs3_bufwait(serobj, wtime)

if nargin == 1
	wtime = 5;	% wait 5 seconds at most
end

clockflag = 0;
t0 = clock;
while (serobj.BytesAvailable<290) | clockflag
	if etime(clock, t0) >= wtime;
		warning('gs3_bufwait: timeout')
		pause(1);
		clockflag = 1;
	end
end

if clockflag
	out = -1;
else
	out = 1;
end

