# THIS IS AN EXAMPLE PROJECT FOR OCTAVE and matlab.
# you can download octave (free) from : https://www.gnu.org/software/octave/download.html
# To update the adat.csv file, you can downloaded raw datas best from:
# "https://hu.wikipedia.org/wiki/2020-as_COVID%E2%80%9319-koronav%C3%ADrus-j%C3%A1rv%C3%A1ny_Magyarorsz%C3%A1gon"
# First fix the unicode '-' at the first row, or any other typos :( manually... 

#used packages
pkg load signal;
pkg load data-smoothing;

# Open Input csv file
fin = fopen('adat.csv', 'rt');
Inputs= textscan(fin, '%s %f %f %f %f %f %f %f %f',
  'Delimiter', ',', 'CollectOutput', 1, 'HeaderLines', 1);
fclose(fin);
DateFormatIn='yyyy-mm-dd';
StartDate= datenum(Inputs{1}(1,1), DateFormatIn);

#convert 2D array to 1D arrays
Datums = [datenum(Inputs{1})-StartDate];
ActiveInfected = Inputs{2}(:, 1);
Died = Inputs{2}(:, 2);
Cured = Inputs{2}(:, 3);
SummInfected = Inputs{2}(:, 4);
DActiveInfected = Inputs{2}(:, 5);
DDied = Inputs{2}(:, 6);
DCured = Inputs{2}(:, 7);
DInfected = Inputs{2}(:, 8);

#interpolation
inputrows=rows(Datums)-1
t=0:inputrows;
iX=[0:0.05:inputrows]
intpmode="spline"
#intpmode="pchip"
iSummInfected= interp1( t, SummInfected, iX, intpmode);
iAInf=interp1( t, ActiveInfected, iX, intpmode);
iDied=interp1( t, Died, iX, intpmode);
iCured=interp1( t, Cured, iX, intpmode);
iDAInf=interp1( t, DActiveInfected, iX, intpmode);
iDDied=interp1( t, DDied, iX, intpmode);
iDCured=interp1( t, DCured, iX, intpmode);
iDInfected=interp1( t, DInfected, iX, intpmode);

#filter
#{
fc = 100; % Cut-off frequency (Hz)
fs = 1321; % Sampling rate (Hz)
order = 5; % Filter order
[B,A] = butter(order,2*fc/fs); % [0:pi] maps to [0:1] here
[sos,g] = tf2sos(B,A)
Bs = sos(:,1:3); % Section numerator polynomials
As = sos(:,4:6); % Section denominator polynomials
iDAInf= filter(Bs, As, iDAInf);
#}
[iDCured2, lambda]= regdatasmooth(iX, iDCured,"d",4,"stdev",1e+1,"midpointrule");
[iDAInf2, lambda]= regdatasmooth(iX, iDAInf,"d",2,"stdev",5e+0,"midpointrule");
[iDInfected2, lambda]= regdatasmooth(iX, iDInfected,"d",2,"stdev",5e+0,"midpointrule");
#K=1341;
#iAInf=interpft( ActiveInfected, K);
#iCured=interpft( DCured, K);

#display curves
close all;
#figure 1
plot(iX, iDDied, 'k;dDied;');
title('Deltas based on days'), xlabel('Days'), ylabel('Nr of people');
hold on;
plot(iX, iDCured2, 'g;dCured;');
plot(iX, iDInfected2, 'b;dInfected;');
plot(iX, iDAInf2, 'r;dActive;');
plot(Datums, DInfected, '+b;dInfected;');
plot(Datums, DActiveInfected, '+r;dActive;');
plot(Datums, DCured, '+g;dCured;');
plot(Datums, DDied, '+k;dDied;');
hold off;
print -djpg 'figure1.jpg'
#

#figure 2
figure;
semilogy(Died, SummInfected, 'b;Infected;');
title('Summ based on mortality'), xlabel('Died'), ylabel('Nr of People');
hold on;
semilogy(Died, ActiveInfected, 'r;Active;');
semilogy(Died, Died, 'k;Died;');
semilogy(Died, Cured , 'g;Cured;');
hold off;
legend("location", "northwest");
print -djpg 'figure2.jpg'
#

#figure 3
figure;
plot(iX, iAInf, 'r;Active;');
title('Deltas based on days'), xlabel('Days'), ylabel('Nr of people');
hold on;
plot(iX, iSummInfected, 'b;Infected;');
plot(iX, iDied, 'k;Died;');
plot(iX, iCured, 'g;Cured;');
plot(Datums, SummInfected, '+b;Infected;');
plot(Datums, ActiveInfected, '+r;Active;');
plot(Datums, Died, '+k;Died;');
plot(Datums, Cured, '+g;Cured;');
legend("location", "northwest");
print -djpg 'figure3.jpg'
hold off;
#