clear
parent_directory = '/Users/macbookpro/Documents/Brainish Components'; % put the name of parent directory
save_to_path = '/Volumes/ESD-USB/Brainish_256_real';
files = dir(parent_directory);
tic
for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.set') )
        path = dir.folder;
        EEG = pop_loadset('filename',dir.name,'filepath',path);
        [EEG,~] = pop_resample(EEG, 256, 0.8, 0.4);
        pop_saveset(EEG, 'filename',dir.name,'filepath',save_to_path ); % Save the data
        toc
    end
end
    

