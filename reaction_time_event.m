%%%%%%%%%%%%%%% reaction_time_event %%%%%%%%%%%%%%%%%%%%%%
%% This script is to add reaction time field for each event
% Developed by Shota Yasunaga
% Developed on Matlab 2016b
% The code is developed on LIVE lab scrips developed 
% by Michael Spezio



%% Specify data directory
EEGDataDir = '/Users/macbookpro/Documents/Cogneuro';

%% Export events
EEG = eeg_checkset( EEG );
pop_expevents(EEG, fullfile(EEGDataDir,'events.csv'), 'samples');

%% Read in the events
fid = fopen(fullfile(EEGDataDir,'events.csv'));
evinfo = textscan(fid,...
    '%d%s%f%d%f%d',...
    'headerlines',1);
fclose(fid);

%% Find the trial starts and their indices and add field info accordingly
newevfield = 'rt'; % Hey, this means reaction time, not rectangle
onsetInds = strmatch('On',evinfo{2});
num_sets = length(onsetInds);

last_ind = 1;

EEG = pop_editeventfield(EEG,'rt','0');

for j = 1:length(evinfo{2})
    EEG = pop_editeventvals(EEG,'changefield',{j 'trialnum' 0});
end
for trial_num = 1:num_sets
    onset_ind = onsetInds(trial_num);
    
    
    onLatency = EEG.event(onset_ind).latency;
    rt1 = EEG.event(onset_ind + 1).latency - onLatency;
    rt2 = EEG.event(onset_ind + 2).latency - onLatency;
        
    EEG = pop_editeventvals(EEG,'changefield',{onset_ind + 1 'rt' rt1});
    EEG = pop_editeventvals(EEG,'changefield',{onset_ind + 2 'rt' rt2});
       
end




 %% Save EEG file
 EEG = eeg_checkset( EEG );
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 eeglab redraw;