% xlmap: 
% speakernum az  el  TermBlock  Termnum  DAchan  MPXchan



xlsmap = xlsread('speaker_map.xls', 'Matlab', 'a1:g144');

speakernum = xlsmap(:, 1);
azimuths = xlsmap(:, 2);
elevations = xlsmap(:, 3);
termbank = xlsmap(:, 4);
termnum = xlsmap(:, 5);
dachannel = xlsmap(:, 6);
mpxchannel = xlsmap(:, 7);

save arraymap speakernum azimuths elevations termbank termnum dachannel mpxchannel

save xlsmap xlsmap



