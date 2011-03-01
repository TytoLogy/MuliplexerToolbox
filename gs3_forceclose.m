function status = gs3_forceclose
%--------------------------------------------------------------------------
% status = gs3_forceclose
%--------------------------------------------------------------------------
% Multiplexer toolbox
%--------------------------------------------------------------------------
% gs3_forceclose cleans up serial port if odd things occur
%--------------------------------------------------------------------------
% SEE ALSO: gs3_close, serial, fopen, set, get
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sharad J. Shanbhag
% sharad.shanbhag@einstein.yu.edu
%--------------------------------------------------------------------------
% Revision History
%	7 May, 2008 (SJS): file created
%	23 Feb 2010 (SJS):
%		- updated documentation
%--------------------------------------------------------------------------

S = instrfind;

if isempty(S)
	status = 0;
	return
end

for i = length(S):-1:1
	if strcmp(S(i).Status, 'open')
		fclose(S(i));
	end
	delete(S(i));
end

status = length(S);
	
