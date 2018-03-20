clear
eeglab
originalPath = '/Users/macbookpro/Documents/Cogneuro/MyICA'; % put the name of parent directory
originalName = 'AMICA_64_Processed_1.set';
% For the sake of my laziness, please put / at the end.


for event = {'OnC0','OnP0', 'COMX', 'COSO','COHL', 'COLH', 'STR0'}
    disp(event)
    EEG = pop_loadset('filename',originalName,'filepath',originalPath);
    EEG = pop_epoch( EEG, event, [-0.3  1], 'newname', char(event), 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    disp('yay')
    EEG = pop_rmbase( EEG, [-300    0]);
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset(EEG, 'filename', char(event),'filepath',originalPath);
    
   
end
    

