%% Last update: June 22, 2017
%% Author: Shota Yasunaga (shota@caltech.edu)

%% Script to move folders named move_name 
%% under parent_directory 
%% to move_to

%%% Dependency %%%
%% Only tested on Matlab 2016b
%% getFolders.m

%% directory you want to loop through
parent_directory = '/Users/macbookpro/Documents/from'; 
%% the folder name you want to move
move_name = 'amicaouttmp';
%% move to this directory
move_to = '/Users/macbookpro/Documents/to';

% Extract only those that are directories.
subFolders = getFolders(parent_directory);

%% loop through every folder under perent_directory
for dir_ind = 1:length(subFolders)
    dir = subFolders(dir_ind);
    % path to the folder
    path = strcat(strcat(parent_directory, '/'), dir.name);
    cd(path)
    list = ls();
    
    %% If there is a folder or file called move_name,
    %% copy that file to move_to
    if strfind(list ,   move_name)
        copyfile(move_name, move_to)
    end
end
