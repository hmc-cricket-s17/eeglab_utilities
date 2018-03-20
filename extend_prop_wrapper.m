clear
eeglab
parent_directory = '/Users/macbookpro/Documents/Cogneuro/MyICA'; % put the name of parent directory
% For the sake of my laziness, please put / at the end.
save_to_here = '/Users/macbookpro/Documents/Cogneuro/MyICA/Component Map/'; % Put the name of child directory
files = dir(parent_directory);
tic
for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.set') )
        path = dir.folder;
        EEG = pop_loadset('filename',dir.name,'filepath',path);
        mkdir(save_to_here, dir.name(1:length(dir.name)-4))
        saving_path = strcat(save_to_here,dir.name);
        saving_path = saving_path(1:length(saving_path)-4);
        
        for i = 1:140
            pop_prop_extended(EEG,0,i,NaN,{'freqrange', [2 40]}, {}, 0)
            file_name = sprintf('cpmp%d.png',i);
            saveas(gca, fullfile(saving_path, file_name)); % save it
            close(gcf) % Close the figure
        end
        toc
    end
end
    

