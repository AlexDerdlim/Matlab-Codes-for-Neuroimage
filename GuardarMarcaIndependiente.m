%% crear lista con los archivos a usar HNH
subject_list_EEG= {...
    '1028904.set',...
    '1280148.set',...
    '1648041.set',...
    '1929195.set',...
    '1944150.set',...
    '1974060.set',...
    '2066781.set',...
    '2132583.set',...
    '2410746.set',...
    '2827856.set',...
    '3940719.set',...
    '3976521.set',...
    '7453210.set',...
    '8539956.set',...
    '8576974.set',...
    };

%% crear un loop
for s=1:15
    
    STUDY = []; EEG=[]; CURRENTSTUDY= 0; ALLEEG = []; CURRENTSET = [];
    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

    %directorio donde están los archivos
    EEG = pop_loadset('filename', [subject_list_EEG{s}], 'filepath', 'D:\Dropbox\Jorge Flores\2023\nuevos analisis EEG humor 2023 SIFT\HH_Study\HNH_chanloc\HNH_prep'); 
    [ALLEEG,EEG,CURRENTSET] = eeg_store(ALLEEG, EEG, 0);
    EEG = eeg_checkset(EEG);
    eeglab redraw

    %seleccionar marca 55 "reward"
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    EEG = pop_rmdat( EEG, {'100'},[-0.2 2] ,0);
    EEG = eeg_checkset( EEG );
    eeglab redraw

     %directorio donde se guardan los archivos
    EEG = pop_saveset(EEG, 'filename', [subject_list_EEG{s}],'filepath','D:\Dropbox\Jorge Flores\2023\nuevos analisis EEG humor 2023 SIFT\HH_Study\HNH_chanloc\HNH_prep\HNH_video');
    [ALLEEG EEG] =eeg_store(ALLEEG, EEG, CURRENTSET);

end