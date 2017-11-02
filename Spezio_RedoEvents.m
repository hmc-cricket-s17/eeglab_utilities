% Redo events in an EEG file
% Assumes file is already loaded

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
newevfield = 'trialnum';
TrialStartInds = strmatch('STR',evinfo{2});
num_trials = length(TrialStartInds);
for trial_num = 1:num_trials-1
    
    start_trial_ind = TrialStartInds(trial_num);
    end_trial_ind = TrialStartInds(trial_num+1)-1;
    
    [newcellarraystring{1:length(start_trial_ind:end_trial_ind)}] = ...
        deal(sprintf('Trial%d',trial_num));
    
    EEG = pop_editeventfield(EEG,...
        newevfield,...
        newcellarraystring,...
        'trialnum_info','Trial Number',...
        'indices',[start_trial_ind:end_trial_ind]);
    
end

start_trial_ind = TrialStartInds(end);
end_trial_ind = size(evinfo{2},1);
trial_num = trial_num + 1;
[newcellarraystring{1:length(start_trial_ind:end_trial_ind)}] = ...
        deal(sprintf('Trial%d',trial_num));
EEG = pop_editeventfield(EEG,...
        newevfield,...
        newcellarraystring,...
        'indices',[start_trial_ind:end_trial_ind]);
    
 %% Save EEG file
 EEG = eeg_checkset( EEG );
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 eeglab redraw;