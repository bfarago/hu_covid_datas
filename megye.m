# THIS IS AN EXAMPLE PROJECT FOR OCTAVE and matlab.
# you can download octave (free) from : https://www.gnu.org/software/octave/download.html
# To update the adat.csv file, you can downloaded raw datas best from:
# "https://hu.wikipedia.org/wiki/2020-as_COVID%E2%80%9319-koronav%C3%ADrus-j%C3%A1rv%C3%A1ny_Magyarorsz%C3%A1gon"
# First fix the unicode '-' at the first row, or any other typos :( manually... 

#used packages
pkg load signal;
pkg load data-smoothing;
pkg load financial
clear
# Open Input csv file
fin = fopen('megye.csv', 'rt');
Labels1= textscan(fin, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', 1, 
  'Delimiter', "\t", 'CollectOutput', 1, 'HeaderLines', 0);
Inputs= textscan(fin, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',
  'Delimiter', "\t", 'CollectOutput', 1, 'HeaderLines', 0);
fclose(fin);
DateFormatIn='yyyy-mm-dd';
StartDate= datenum(Inputs{1}(1,1), DateFormatIn);

#convert 2D array to 1D arrays
Datums = [datenum(Inputs{1})-StartDate];
LastRow = 39
Labels=Labels1{1};
Labels(:,1)=[]; #remove first element "Datum"

#{
BKK = Inputs{2}(:, 1);
#interpolation
t=0:66;
iX=[0:0.05:66]
intpmode="spline"
#intpmode="pchip"
iSummInfected= interp1( t, SummInfected, iX, intpmode);
iAInf=interp1( t, ActiveInfected, iX, intpmode);
#filter
[iDCured2, lambda]= regdatasmooth(iX, iDCured,"d",4,"stdev",3e+1,"midpointrule");
#}
numk = length(Inputs{2});
for n=1:20
  p=0
  for k=1: numk
    a= Inputs{2}(k,n)
    if (a < p)
      Inputs{2}(k,n)=p
    else
      p=a
    end
  end
end

#display curves
close all;
hold on;
# removed 5:BUD capital and 21 summary
Removed = [ 5 ];
#figure 4
k=1;
for n=1:20
    if ((Inputs{2}(LastRow, n)<50) && (0==ismember(n, Removed)))
    semilogy(Datums, Inputs{2}(:, n));
    labs1(k++)=Labels(n);
    endif
end
if (k>1)
  xticks([1:7:max(Datums)])
  dateaxis('x',29, StartDate);
  legend(labs1,  "location", "northeastoutside");
endif
title('County numbers (<50) based on days'), xlabel('Days'), ylabel('Nr of people');
hold off;
print -djpg 'figure4.jpg'
#

#one county only
figure
plot(Datums, Inputs{2}(:, 2));
title('Baranya megye'), xlabel('Days'), ylabel('Nr of people');

k=1;
figure
hold on;
for n=1:20
    if ((Inputs{2}(LastRow,n)>=50) && (0==ismember(n, Removed)))
    semilogy(Datums, Inputs{2}(:, n));
    labs2(k++)=Labels(n);
    endif
end
if (k>1)
legend(labs2,  "location", "northeastoutside");
endif
title('County numbers (>=50) based on days'), xlabel('Days'), ylabel('Nr of people');
hold off;
print -djpg 'figure5.jpg'
#

d=diff(Inputs{2});
Datums(end)=[];
k=1;

figure
hold on;
for n=1:20
    if ( max(d(:,n)>=10) && (0==ismember(n, Removed)))
    plot(Datums, d(:, n));
    labs2(k++)=Labels(n);
    endif
end
if (k>1)
legend(labs2,  "location", "northeastoutside");
endif
title('Delta numbers from County dataset based on days'), xlabel('Days'), ylabel('Nr of people');
hold off;
print -djpg 'figure6.jpg'
#
#scramble the similar counties closer
#      1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21
idx1=[20, 6,12, 7, 4, 8,19,13,10, 2,16,15,17, 3,18, 9, 1,11,14, 5,21];
for n=1:21
  idx2(idx1(n))=n;
end
#
figure(7, 'position', [0,0,1000,300]);
for n=1:21
  m=max(d(:,n));
  d(:,n) /= m; #normalize
  d2(:,idx2(n))=d(:,n);
  labels2(n)=Labels(idx1(n));
end
imagesc( d2 );
#meshc(d2);
#colormap (prism (10));
yticks([1:7:max(Datums)])
dateaxis('y',29, StartDate);
xticks([1:1:21]);
h=gca();
set (h, ['x' "ticklabel"], labels2);
colorbar
title('Normalized geographic sequences'), xlabel('County'), ylabel('Days');
print -djpg 'figure7.jpg' '-S1000,600'