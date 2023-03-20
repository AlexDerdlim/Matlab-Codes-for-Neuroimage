%% CÓDIGO PARA CORTAR ARCHIVOS, para George. 10 Sept 2021

%% Primero, crear lista con los archivos que se utilizarán
subject_list_EEG= {...
'1013949_mujer_no_humor_interpolated.set_DownFilt.set',...
'1136580_mujer_no_humor_interpolated.set_DownFilt.set',... 
'1208364_mujer_no_humor_interpolated.set_DownFilt.set',...
'1468581_mujer_no_humor_interpolated.set_DownFilt.set',...
'1645050_mujer_no_humor_interpolated.set_DownFilt.set',...
'1848438_mujer_no_humor_interpolated.set_DownFilt.set',...
'1935177_mujer_no_humor_interpolated.set_DownFilt.set',...
'2003970_mujer_no_humor_interpolated.set_DownFilt.set',...
'2009952_mujer_no_humor_interpolated.set_DownFilt.set',...
'2081736_mujer_no_humor_interpolated.set_DownFilt.set',...
'2084727_mujer_no_humor_interpolated.set_DownFilt.set',...
'2108655_mujer_no_humor_interpolated.set_DownFilt.set',...
'2117628_mujer_no_humor_interpolated.set_DownFilt.set',...
'9763331_mujer_no_humor_interpolated.set_DownFilt.set',...
'73195803_mujer_no_humor_interpolated.set_DownFilt.set',...
};

%% Segundo, crear un loop que haga todo. 

for s=1:15 
    

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',[subject_list_EEG{s}],'filepath','/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/preprocesamiento feedback_Nov09_22/mujer_no_humor_interpolated/Down_Filt'); %ACÁ HAY QUE PONER EL DIRECTORIO DONDE ESTÁN TODOS LOS EEG.
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw

% % NO USAR, YO NO TENIA MI INFO EPOCADA; ASÏ QUE TUVE QUE EPOCAR
% EEG = pop_epoch( EEG, {  '56'  '57'  }, [-0.1         0.5], 'newname', 't epochs_ep2con epochs', 'epochinfo', 'yes');
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
% EEG = eeg_checkset( EEG );

% Se seleccionan 401:500 trials [EVM5] EEG.trials-99:EEG.trials
% Se seleccionan 301:400 trials [EVM4] EEG.trials-199:EEG.trials-100


% partimos con EVM5 (401:500)
EEG = pop_selectevent( EEG, 'epoch',[EEG.trials-99:EEG.trials] ,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','401a500','gui','off');
eeglab redraw

% Guarda archivo
EEG = pop_saveset( EEG,'filename', [subject_list_EEG{s} '_401a500.set'],'filepath','/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/preprocesamiento feedback_Nov09_22/mujer_no_humor_interpolated/05_EVM5_MNH');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);


% Se borra de memoria el dataset EVM5 (401:500) y se vuelve al
% original
EEG = pop_delset( EEG, [2] );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
eeglab redraw

% Se repite proceso con épocas EVM4 (301:400)
EEG = pop_selectevent( EEG, 'epoch',[EEG.trials-199:EEG.trials-100] ,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','301a400','gui','off');
eeglab redraw

% Guarda archivo con épocas EVM4 (301:400)
EEG = pop_saveset( EEG, 'filename', [subject_list_EEG{s} '_301a400.set'],'filepath','/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/preprocesamiento feedback_Nov09_22/mujer_no_humor_interpolated/04_EVM4_MNH');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

% Se borra de memoria el dataset con épocas de 301:400, se vuelve al
% original
EEG = pop_delset( EEG, [2] );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
eeglab redraw

% Se repite proceso con épocas B10 (450:500)
%EEG = pop_selectevent( EEG, 'epoch',[EEG.trials-50:EEG.trials] ,'deleteevents','off','deleteepochs','on','invertepochs','off');
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','450a500','gui','off');
%eeglab redraw

% Guarda archivo con épocas de 450:500
%EEG = pop_saveset( EEG, 'filename', [subject_list_EEG{s} '_450a500.set'],'filepath','/Users/jorgeflores/Dropbox/Jorge Flores/2021/Nuevos_Analisis_ERPs/preprocesamiento3/mujer_humor/10_Mujer_Humor_Block10');
%[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

% Se borra dataset 2 y se vuelve a dataset1
%EEG = pop_delset( EEG, [2] );
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
%eeglab redraw

end