%%%%%%%%% Scripts to run AMICA in a loop %%%%%%%%%%%%%
%% Because I am using FASTER, I have folders that have a .set file for each.
%% So, you enter the parent file and then this program will run AMICA for
%% the .set files in the all of directories under the parent directory

%% Dependency
%       eeglab
%       AMICA
%       getFolders.m

clear
parent_directory = '/Users/macbookpro/Documents/Beep_Only/DownSample'; % put the name of parent directory


% Extract only those that are directories.
subFolders = getFolders(parent_directory);

num_pca = 64; % number of pca
max_iter = 2000; % number of iterations for AMICA;

for dir_ind = length(subFolders):-1:1
    dir = subFolders(dir_ind);
    path = strcat(strcat(dir.folder, '/'), dir.name);
    cd(path)
    
    filename = strtrim(ls('*.set')); % The name of the EEG set. Searching for .set file
    
    
    EEG = pop_loadset('filename',filename,'filepath',path);

    %%%% Run AMICA and save the data %%%% 
    [W,S,mods] = runamica15(EEG.data(:,:), 'pcakeep', num_pca, 'max_iter', 2000);
    EEG.icaweights = W;
    EEG.icasphere = S(1:size(W,1),:);
    EEG.icawinv = mods.A(:,:,1);
    EEG.mods = mods;
    EEG.icachansind = [];
    
    new_filename = strcat('AMICA_64_',filename);
    amica_folder_path = strcat(path, '/amicaouttmp');
    EEG = pop_saveset( EEG, 'filename',new_filename,'filepath',amica_folder_path    ); % Save the data

    %%%% Plotting the result %%%%
    pop_topoplot(EEG,0, [1:64] ,'170613_TRIAL7_LP epochs',[8 8] ,0,'electrodes','off'); % plot components map

    fname = '/Users/macbookpro/Documents/Beep_Only/Components Map'; % Path to the place you want to save the components map
    saveas(gca, fullfile(amica_folder_path, 'map'), 'png'); % save it
    close(gcf) % Close the figure
end
