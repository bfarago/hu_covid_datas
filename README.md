# hu_covid_datas
Matlab / Octave example project using Hungarian Covid19 raw datas

The aim of this project to help on you learing the Matlab script language quickly.

Input data come from this [wikipedia link](https://hu.wikipedia.org/wiki/2020-as_COVID%E2%80%9319-koronav%C3%ADrus-j%C3%A1rv%C3%A1ny_Magyarorsz%C3%A1gon),
updated on 2021-02-03. <br>
Day zero in curves is 2020-03-04 when the first 2 people tested positive to Covid19 in Budapest. <Br>
Other curves:
[Trajectory](https://aatishb.com/covidtrends/?location=Australia&location=Brazil&location=Canada&location=China&location=France&location=Germany&location=Hong+Kong&location=Hungary&location=India&location=Italy&location=Japan&location=Russia&location=Singapore&location=South+Korea&location=Spain&location=Taiwan&location=Turkey&location=US&location=United+Kingdom) |
[Waze stats](http://wazestats.com/active.php?city=7) |
[Johns Hopkins University](https://www.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6) |
[Reproduction numbers](https://stochastik-tu-ilmenau.github.io/COVID-19/) |
[CoronaHu](https://coronahu.site/) |
[WorldoMeters](https://www.worldometers.info/coronavirus/country/hungary/) |
[Pandemia.hu](http://pandemia.hu/koronavirus-magyarorszag/)


<BR><BR>
<CENTER>
<B>Figure 1:</B><BR>
Delta values are oversampled 24 times to get hourly resolution, interpolated, then filtered to calculate the mean curve.
<br>
<img src='figure1.jpg'>
<BR>
<B>Figure 2:</B><BR>
The curves are linear interpolated only.
<br>
<img src='figure2.jpg'>
<BR>
<B>Figure 3:</B><BR>
<img src='figure3.jpg'>
<BR>
Day zero on figure 4-7 is 2020-04-01 when the county statistics started to shown on government publications. <Br>
<B>Figure 4:</B><BR>
Absolute numbers where max is less than 50.<br>
<img src='figure4.jpg'>
<BR>
<B>Figure 5:</B><BR>
Absolute numbers where max is greater than 50.<br>
<img src='figure5.jpg'>
<BR>
<B>Figure 6:</B><BR>
Delta numbers where daily change max is greater than 10.
<BR>
<img src='figure6.jpg'>
<BR>
<B>Figure 7:</B><BR>
The normalized deltas on all the counties.
<BR>
<img src='figure7.jpg'>
<BR>
<B>Figure 8:</B><BR>
Age structure.
<BR>
<img src='figure8.jpg'>
<BR>
<B>Figure 9:</B><BR>
Age structure.
<BR>
<img src='figure9.jpg'>
<BR>
</CENTER>
