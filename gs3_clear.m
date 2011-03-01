function a = gs3_clear(serobj)

loop = 1;
errflag = 0;
while loop == 1
	try
		fwrite(serobj, '98');
	catch
		errflag = 1;
	end
	if errflag == 1
		loop = 1;
	else
		loop = 0;
	end
end

a = gs3_flush(serobj);
