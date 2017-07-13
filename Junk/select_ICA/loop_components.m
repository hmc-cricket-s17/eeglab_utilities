function a = loop_components(EEG)

%% dipfit settings
EEG = pop_dipfit_settings(EEG, 'hdmfile','/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/standard_BESA.mat', 'mrifile', ...
'/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/avg152t1.mat', ...
'chanfile','/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp' ...
,'coordformat','Spherical', 'coord_transform', [0 0 0 0 0 0 0.9719 0.9719 0.9719]);

%% 

%% Fit the model
% Single dipole
comps = 1:size(EEG.icaweights,1);
EEG = pop_multifit(EEG,comps, 'threshold', [100]);

%%

% Double dipole
EEG = pop_multifit(EEG, 'dipoles', 2)

for i = 1: size(EEG.icaweights, 1)
    
end


% remove the dipoles from the model that are not selected, but keep
% the original dipole model (to keep the GUI consistent)
% Taken from pop_dipfit_nonlinear.m
function fit_dipfit(current, select)
model_before_fitting = EEG.dipfit.model(current);
    EEG.dipfit.model(current).posxyz = EEG.dipfit.model(current).posxyz(select,:);
    EEG.dipfit.model(current).momxyz = EEG.dipfit.model(current).momxyz(select,:);
end