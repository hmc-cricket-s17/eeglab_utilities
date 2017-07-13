
parent_directory = '/Users/macbookpro/Documents/Dipfit'; % put the name of parent directory

files = dir(parent_directory);

for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.set') )
        path = dir.folder;
        EEG = pop_loadset('filename',dir.name,'filepath',path);
        
        EEG = pop_dipfit_settings(EEG, 'hdmfile','/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/standard_BESA.mat', 'mrifile', ...
        '/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/avg152t1.mat', ...
        'chanfile','/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp' ...
        ,'coordformat','Spherical', 'coord_transform', [0 0 0 0 0 0 0.9719 0.9719 0.9719]);
        
        
        comps = 1:size(EEG.icaweights,1);
        EEG = pop_multifit(EEG,comps,'dipoles',2, 'threshold', [100]);
        
        new_filename = strcat('dipfit2_', dir.name);
        new_filepath = '/Users/macbookpro/Documents/Dipfit';
        
        EEG = pop_saveset( EEG, 'filename',new_filename,'filepath', new_filepath ); % Save the data
    end
end
    

