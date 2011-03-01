function sdatum = extract_speakerdata(sdata, n)

sdatum.speakernum = sdata.speakernum(n);
sdatum.azimuths = sdata.azimuths(n);
sdatum.elevations = sdata.elevations(n);
sdatum.termbank = sdata.termbank(n);
sdatum.termnum = sdata.termnum(n);
sdatum.dachannel = sdata.dachannel(n);
sdatum.mpxchannel = sdata.mpxchannel(n);
sdatum.xlsmap = sdata.xlsmap(n, :);
sdatum.row = sdata.row(n);
