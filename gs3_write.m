function a = gs3_write(serobj, charstr)

loop = 1;
errflag = 0;
while loop == 1
	try
		fwrite(serobj, charstr);
	catch
		errflag = 1;
	end
	if errflag == 1
		loop = 1;
	else
		loop = 2;
	end
end
	
a = gs3_flush(serobj);
