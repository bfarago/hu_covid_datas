# THIS IS AN EXAMPLE PROJECT FOR OCTAVE and matlab.
# you can download octave (free) from : https://www.gnu.org/software/octave/download.html
# To update the adat.csv file, you can downloaded raw datas best from:
# "https://hu.wikipedia.org/wiki/2020-as_COVID%E2%80%9319-koronav%C3%ADrus-j%C3%A1rv%C3%A1ny_Magyarorsz%C3%A1gon"
# First fix the unicode '-' at the first row, or any other typos :( manually... 

#used packages
pkg load signal;
pkg load data-smoothing;
pkg load financial;

# Open Input csv file
fin = fopen('agestructure.csv', 'rt');
Inputs= textscan(fin, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',
  'Delimiter', "\t", 'CollectOutput', 1, 'HeaderLines', 1);
fclose(fin);
DateFormatIn='yyyy-mm-dd';
StartDate= datenum(Inputs{1}(1,1), DateFormatIn);

#convert 2D array to 1D arrays
Datums = [datenum(Inputs{1})-StartDate];
for n=0:10
  da_male{n+1}  = Inputs{2}(:, 1+n*3);
  da_female{n+1}= Inputs{2}(:, 2+n*3);
  da_sum{n+1}= Inputs{2}(:, 3+n*3);
  dif_sum{n+1}= [ diff( Inputs{2}(:, 3+n*3) ); 0];
end
da_sum{n+1}
inputrows=rows(Datums)-1
iX=[0:1:inputrows]

#display curves
close all;
#figure 8
dateaxis('x',29, StartDate);
for n=4:11
  tit1=10*(n-1)
  tit= sprintf(";%d-%d;", tit1, tit1+9)
  plot(Datums, da_sum{n}, tit);
  #semilogy
  hold on;
end
dateaxis('x',29, StartDate);
legend("location", "northwest");
title('Age structure'), xlabel('Days'), ylabel('Nr of people');
hold off;
print -djpg 'figure8.jpg'
#
