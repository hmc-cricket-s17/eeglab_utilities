%%%% getfolders %%%%%
%% This function returns all of the directories (only directories not the files) 
%% under the path (input).
%% This function excludes folders starting from '.' 

%% input (path): path to the directory you want to inspect
%% output (folders): list of folders (type, folder)

%% This code is taken from 
%% https://www.mathworks.com/matlabcentral/newsreader/view_thread/258220

function folders = getfolders(path)

folders = dir(path);

for k = length(folders):-1:1
    % remove non-folders
    if ~folders(k).isdir
        folders(k) = [ ];
        continue
    end

    % remove folders starting with .
    fname = folders(k).name;
    if fname(1) == '.'
        folders(k) = [ ];
    end
end
