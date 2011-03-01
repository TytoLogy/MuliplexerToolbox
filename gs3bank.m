function bankstr = gs3bank(banknum)

if nargin ~= 1
	error('gs3bank: invalid input argument');
end

if ~between(banknum, 1, 24)
	error('gs3bank: bank number out of bounds (1-24)');
end

if banknum < 10
	bankstr = sprintf('0%d', banknum);
else
	bankstr = sprintf('%d', banknum);
end

