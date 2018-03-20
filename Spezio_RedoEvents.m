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

counter = 1;
EEG = pop_editeventfield(EEG,newevfield,'0');
for i = length(TrialStartInds)
    if(trial_num == num_trials) % If it's the end of indices
        end_trial_ind = size(evinfo{2},1) + 1;
    else
        end_trial_ind = TrialStartInds(trial_num+1);
    end
    while counter < end_trial_ind
        counter = counter +1;
        EEG = pop_editeventvals(EEG,'changefield',{counter newevfield char(strcat('Trial',num2str(i)))});
    end
end


EEG = pop_editeventfield(EEG,newevfield,valueList);

 %% Save EEG file
 EEG = eeg_checkset( EEG );
 [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
 eeglab redraw;