clear
parent_directory = '/Users/macbookpro/Documents/Dipfit'; % put the name of parent directory
save_to_here = '/Users/macbookpro/Documents/components/';
files = dir(parent_directory);
tic
for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.set') )
        path = dir.folder;
        EEG = pop_loadset('filename',dir.name,'filepath',path);
        mkdir(save_to_here, dir.name)
        saving_path = strcat(save_to_here,dir.name);
        
        for i = 1:size(EEG.icaweights,1)
            pop_prop_extended(EEG,0,i,NaN,{'freqrange', [2 80]}, {}, 0)
            file_name = sprintf('cpmp%d.png',i);
            saveas(gca, fullfile(saving_path, file_name)); % save it
            close(gcf) % Close the figure
        end
        toc
    end
end
    

