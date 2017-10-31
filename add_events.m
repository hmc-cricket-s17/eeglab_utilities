new_filename = 'add_events';
new_filepath = '/Users/macbookpro/Desktop';

for i = 1:length(EEG.event)
    % this_event = EEG.event(i);
    % EEG.event(length(EEG.event)+1).type='';
    % next_event = EEG.event(length(EEG.event));
    % EEG.urevent(length(EEG.event)+1).type='';
    % next_urevent = EEG.urevent(length(EEG.event));
    
    disp(length(EEG.event))
    disp(i)
    if strcmp(EEG.event(i).type,'square')
        EEG.event(length(EEG.event) + 1).type = strcat('square',num2str(i));
        EEG.urevent(length(EEG.event) + 1).type = strcat('square',num2str(i));
        
    else
        EEG.event(length(EEG.event) + 1).type = strcat('rt',num2str(i));
        EEG.urevent(length(EEG.event) + 1).type = strcat('rt',num2str(i));        
    end
    EEG.event(length(EEG.event)).latency = EEG.event(i).latency - 10;
    EEG.urevent(length(EEG.event)).latency = EEG.urevent(i).latency - 10;
    disp(EEG.event(length(EEG.event)))
end


EEG = pop_saveset( EEG, 'filename',new_filename,'filepath', new_filepath ); % Save the data