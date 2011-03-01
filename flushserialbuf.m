function out = flushserialbuf(serobj)

if serobj.BytesAvailable
	out = fread(serobj, serobj.BytesAvailable);
else
	out = 0;
end
