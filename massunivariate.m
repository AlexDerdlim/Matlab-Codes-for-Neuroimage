%%mass univariate

%revisar ubicación de massunivariate
%which gui_erp

%Acá está la sintaxis por si decides ver los datos del mass univariate en tu compu por mientras:

% PARA Frn
load 'C:\Users\gacam\Dropbox\PROYECTO JORGE DICIEMBRE2022/HNH5vsMNH5.GRP' -mat
GRP=tmaxGRP(GRP,2,'time_wind',[100 250],'mean_wind','yes','save_GRP', 'no','n_perm', 5000,'include_chans', {'Fz','FCz','Cz'});
close all

% Se decide ocupar todos los electrodos y usar ventana 350-450
load 'C:\Users\gacam\Dropbox\PROYECTO JORGE DICIEMBRE2022/HH1vsMH1.GRP' -mat
GRP=tmaxGRP(GRP,1,'time_wind',[350 450],'mean_wind','yes','save_GRP', 'no','n_perm', 5000);
close all