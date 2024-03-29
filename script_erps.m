%% Primero, crear lista con los archivos que se utilizar�n
subject_list_EEG= {...
'1013949_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'1136580_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',... 
'1208364_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'1468581_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'1645050_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'1848438_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'1935177_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'2003970_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'2009952_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'2081736_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'2084727_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'2108655_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'2117628_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'9763331_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
'73195803_mujer_no_humor_interpolated.set_DownFilt.set_401a500.set',...
};


%% Segundo, crear un loop que haga todo. 
for s=1:15 
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',[subject_list_EEG{s}],'filepath','/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/preprocesamiento feedback_Nov09_22/mujer_no_humor_interpolated/05_EVM5_MNH'); %AC� HAY QUE PONER EL DIRECTORIO DONDE EST�N TODOS LOS EEG.
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw

%EEG = pop_epoch2continuous(EEG); %convierte archivos a continuos
%EEG.setname='1a100 epochs3_ep2con3'
%EEG = eeg_checkset( EEG )

%EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'List', '/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/List.txt', 'SendEL2', 'EEG', 'UpdateEEG', 'askUser', 'Warning', 'on' )% lee bines
%EEG.setname='1a100 epochs3_ep2con3_elist2'
%EEG = eeg_checkset( EEG )
%EEG = pop_epochbin( EEG , [-189.0  1000.0],  [ -189 0])% IGT feedback
%EEG.setname='1a100 epochs3_ep2con3_elist2_be2'
%EEG = eeg_checkset( EEG )

%Computamos ERPs con ERPLAB
fprintf('\n\n\n*** %s: Averaging ***\n\n\n', subject_list_EEG{s});              
%ERP = pop_averager( EEG , 'Criterion', 'good', 'SEM', 'on' );% GUI: 09-Oct-2020 19:43:39
ERP = pop_averager( EEG , 'Criterion', 'good', 'DQ_custom_wins', 0, 'DQ_flag', 1, 'DQ_preavg_txt', 0, 'ExcludeBoundary', 'on', 'SEM', 'on');% GUI: 20-Oct-2022 14:20:39

%Se guarda archivo, con extensi�n .ERP
ERP.erpname = [subject_list_EEG{s} '_ERPs'];  % name for erpset menu

%Cambiar directorio donde se guardar�n los archivos.
pop_savemyerp(ERP, 'erpname', ERP.erpname, 'filename', [ERP.erpname '.erp'],'filepath','/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/preprocesamiento feedback_Nov09_22/mujer_no_humor_interpolated/05_MNH_erps', 'Warning', 'on');

end