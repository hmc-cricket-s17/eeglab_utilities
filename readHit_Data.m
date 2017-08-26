clear
parent_directory = '/Users/macbookpro/Downloads/Salma_Data/Result/'; % put the name of parent directory
% For the sake of my laziness, please include / at the end
save_to_path = '/Users/macbookpro/Downloads/Salma_Data/Result/'; % where you want to save the data
files = dir(parent_directory);
for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.txt') )
        path = dir.folder;
        fid = fopen(strcat(parent_directory,dir.name));
        if(fid ~= -1)
        tline = fgetl(fid);
        ind = 1;
        data = struct('judgement', cell(1), 'absolute', [], 'relative', [],'note', [], 'cool',0,'good',0, 'bad',0,'miss',0);
        while ischar(tline) && length(tline)~= 0
            %% Cut the unnecesssary thing
           
            
            prop = isstrprop(tline, 'alpha');
            nums = isstrprop(tline, 'digit');

            if(sum(prop) > 22)
                tline = IamStupid(tline);
            end
            [judgement, absolute,relative,note] = seperate(tline); 
            data.judgement{ind} = char(judgement);
            data.absolute(ind) = absolute;
            data.relative(ind) = relative;
            data.note(ind) = note;
            tline = fgetl(fid);
            ind = ind+1;
        end
        
        save(strcat(save_to_path, strcat(dir.name,'.mat')),'data');
        fclose(fid);   

        end
        end
    end




function [judgement, absolute,relative,note] = seperate(tline)
    if tline(10) == 'C' || tline(10) == 'G' || tline(10) == 'M'
        judgement = tline(1:13);
        numStart = 14;
    
    else 
        judgement = tline(1:12);
        numStart = 13;
    end

    index = strfind(tline,',');
    absolute = str2double(tline(numStart:index(1)));
    relative = str2double(tline(index(1):index(2)-1));
    if length(index) == 3
        note = str2double(tline(index(3) -1));
    else
        note = str2double(tline(end));
    end
    
end


function right_line = IamStupid(tline)

    if length(strfind(tline,'J') )<4
        if tline(10) == 'C' || tline(10) == 'G' || tline(10) == 'M'
            right_line = tline(14:end);
        else
            right_line = tline(13:end);
        end
    else
        ind_list = strfind(tline,'T');
        ind = ind_list(end -1);
        if tline(ind+2) == 'C' || tline(ind+2) == 'D' || tline(ind+2) == 'M'
            right_line = tline(ind+6:end);
        else
            right_line = tline(ind+5:end);
        end
        
    end
end