% Inputs:
%   EEG        - EEGLAB dataset structure (see EEGGLOBAL)
%
% Optional inputs:
%   typecomp   - [0|1] 1 -> display channel properties 
%                0 -> component properties {default: 1 = channel}
%   chanorcomp - channel or component number[s] to display {default: 1}
%
%   winhandle  - if this parameter is present or non-NaN, buttons 
%                allowing the rejection of the component are drawn. 
%                If non-zero, this parameter is used to back-propagate
%                the color of the rejection button.
%   spectopo_options - [cell array] optional cell arry of options for 
%                the spectopo() function. 
%                For example { 'freqrange' [2 50] }
%  This comment is taken from pop_prop.m of eeglab
%
% Author Shota Yasunaga / California Institute of Technology 2017
%
%

function fig = component_full_property(EEG, chanorcomp, winhandle, spec_opt)

fig = figure(1);

%% topography map
subplot(3,3,1)
topoplot( EEG.icawinv(:,chanorcomp), EEG.chanlocs, 'chaninfo', EEG.chaninfo, ...
                 'shading', 'interp', 'numcontour', 3);


%% time series
subplot(3,3,[2,3])
% pop_prop(EEG, 0, chanorcomp, winhandle,spec_opt); % 0 means plotting component)
%% ERP image

ERPIMAGELINES = 200; % show 200-line erpimage
while size(EEG.data,2) < ERPIMAGELINES*EEG.srate
   ERPIMAGELINES = 0.9 * ERPIMAGELINES;
end
ERPIMAGELINES = round(ERPIMAGELINES);
if ERPIMAGELINES > 2   % give up if data too small
    if ERPIMAGELINES < 10
        ei_smooth = 1;
    else
        ei_smooth = 3;
    end
  erpimageframes = floor(size(EEG.data,2)/ERPIMAGELINES);
  erpimageframestot = erpimageframes*ERPIMAGELINES;
  eegtimes = linspace(0, erpimageframes-1, length(erpimageframes)); % 05/27/2014 Ramon: length(erpimageframes) by EEG.srate/1000  in eegtimes = linspace(0, erpimageframes-1, EEG.srate/1000);
  
% plot component
 icaacttmp = eeg_getdatact(EEG, 'component', chanorcomp);
 offset = nan_mean(icaacttmp(:));
 erpimage(reshape(icaacttmp(:,1:erpimageframestot),erpimageframes,ERPIMAGELINES)-offset,ones(1,ERPIMAGELINES)*10000, eegtimes , ...
            EI_TITLE, ei_smooth, 1, 'caxis', 2/3, 'cbar','yerplabel', '');

end
% erpimage
subplot(3,3,[4,7])
if EEG.trials < 6
    ei_smooth = 1;
else
    ei_smooth = 3;
end

EEG.times = linspace(EEG.xmin, EEG.xmax, EEG.pnts);
icaacttmp  = eeg_getdatact(EEG, 'component', chanorcomp);
         offset     = nan_mean(icaacttmp(:));
         era        = nan_mean(squeeze(icaacttmp)')-offset;
         era_limits = get_era_limits(era);
         erpimage( icaacttmp-offset, ones(1,EEG.trials)*10000, EEG.times*1000, ...
                       '', ei_smooth, 1, 'caxis', 2/3, 'cbar','erp', 'yerplabel', '','erp_vltg_ticks',era_limits);   
          

%% activity power spectrum
subplot(3,3,[6,9])
spectopo( EEG.icaact(chanorcomp,:), EEG.pnts, EEG.srate, 'mapnorm', EEG.icawinv(:,chanorcomp), spec_opt{:} );
                   
                   
%% dipfit
subplot(3,3,[5,8])
pop_dipplot(EEG, chanorcomp, 'mri', ...
    '/Users/macbookpro/Dropbox/Matlab/Toolboxes/eeglab14_0_0b/plugins/dipfit2.3/standard_BESA/avg152t1.mat'...
    , 'summary', 'on', 'num','on', 'normlen', 'on')

end


% Taken from pop_prop.m of eeglab
function era_limits=get_era_limits(era)
%function era_limits=get_era_limits(era)
%
% Returns the minimum and maximum value of an event-related
% activation/potential waveform (after rounding according to the order of
% magnitude of the ERA/ERP)
%
% Inputs:
% era - [vector] Event related activation or potential
%
% Output:
% era_limits - [min max] minimum and maximum value of an event-related
% activation/potential waveform (after rounding according to the order of
% magnitude of the ERA/ERP)

mn=min(era);
mx=max(era);
mn=orderofmag(mn)*round(mn/orderofmag(mn));
mx=orderofmag(mx)*round(mx/orderofmag(mx));
era_limits=[mn mx];


end



function ord=orderofmag(val)
%function ord=orderofmag(val)
%
% Returns the order of magnitude of the value of 'val' in multiples of 10
% (e.g., 10^-1, 10^0, 10^1, 10^2, etc ...)
% used for computing erpimage trial axis tick labels as an alternative for
% plotting sorting variable

val=abs(val);
if val>=1
    ord=1;
    val=floor(val/10);
    while val>=1,
        ord=ord*10;
        val=floor(val/10);
    end
    return;
else
    ord=1/10;
    val=val*10;
    while val<1,
        ord=ord/10;
        val=val*10;
    end
    return;
end
end
