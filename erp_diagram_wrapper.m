clear
parent_directory = '/Users/macbookpro/Documents/Cogneuro/Epochs'; % put the name of parent directory
files = dir(parent_directory);

for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.set') )
        path = dir.folder;
        EEG = pop_loadset('filename',dir.name,'filepath',path);
        
        erp_name = strcat(dir.name, ' ERP');
        
        pop_plotdata(EEG, 0, [5 7 9 11 19 35 39 71] , [1:72], erp_name, 0, 1, [0 0]);
        saveas(gca, fullfile(parent_directory, erp_name)); % save it
        close(gcf) % Close the figure
    end
end
    

