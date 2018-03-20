clear
eeglab
parent_directory = '/Users/macbookpro/Documents/Cogneuro/MyICA/Epochs/'; % put the name of parent directory
% For the sake of my laziness, please put / at the end.
rect = '/Users/macbookpro/Documents/Cogneuro/MyICA/Epochs/Rectangular/';
tf = '/Users/macbookpro/Documents/Cogneuro/MyICA/Epochs/Time_Frequency/';
compERP = '/Users/macbookpro/Documents/Cogneuro/MyICA/Epochs/Component_ERP/';
crossCoh = '/Users/macbookpro/Documents/Cogneuro/MyICA/Epochs/crossCoh/';

files = dir(parent_directory);
tic
for dir_ind = 1: length(files)
    dir = files(dir_ind);
    if(endsWith(dir.name, '.set') )
        path = dir.folder;
        EEG = pop_loadset('filename',dir.name,'filepath',path);
        
        
        %mkdir(rect, dir.name(1:length(dir.name)-4))
%        mkdir(tf, dir.name(1:length(dir.name)-4))
%        mkdir(compERP, dir.name(1:length(dir.name)-4))
        mkdir(crossCoh, dir.name(1:length(dir.name)-4))

        
        
        %% Rectangular ERP
%         saving_path = strcat(rect,dir.name);
%         saving_path = saving_path(1:length(saving_path)-4);
%         pop_plotdata(EEG, 0, [5:2:9 10:14 16 20 21 58 61 66] , [], dir.name(1:length(dir.name)-4), 0, 1, [0 0]);
%         saveas(gca, fullfile(saving_path, 'ERP.png')); % save it
%         close(gcf) % Close the figure
         
         
        
        for i = [5 7 9 10 11 12 13 14 16 20 21 58 61 66]
            %% Individual ERP

            for j = [5 7 9 10 11 12 13 14 16 20 21 58 61 66]
            %disp(i)
            %disp(j)
                if i < j
                    saving_path = strcat(crossCoh,dir.name);
                    saving_path = saving_path(1:length(saving_path)-4);
            file_name = sprintf('cpmp%d-%d.png',i,j);
            caption = sprintf('IC %d-%d',i,j);
%             %disp(i)
%             figure; pop_erpimage(EEG,0, [i],[[]],file_name,10,1,{},[],'' ,'yerplabel','','erp','on','cbar','on','topo', { mean(EEG.icawinv(:,[i]),2) EEG.chanlocs EEG.chaninfo } );
%             %pop_newtimef( EEG, 0, i, [-300  992], [3         0.5] , 'topovec', EEG.icawinv(:,5), 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', [caption], 'baseline',[0], 'freqs', [5 30], 'plotphase', 'off', 'padratio', 1);
            figure; pop_newcrossf( EEG, 0, i, j, [-300  992], [3         0.5] ,'type', 'phasecoher', 'topovec', EEG.icawinv(:, [i  j])', 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'title',caption,'padratio', 1, 'freqs', [10 30]);
            saveas(gca, fullfile(saving_path, file_name)); % save it
%             % Close the figure
            close(gcf)
                end
            end
            
            %% Time frequency
%             saving_path = strcat(tf,dir.name);
%             saving_path = saving_path(1:length(saving_path)-4);
%             
%             figure; pop_newtimef( EEG, 0, i, [-300  992], [3         0.5] , 'topovec', EEG.icawinv(:,5), 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', [caption], 'baseline',[0], 'freqs', [5 30], 'plotphase', 'off', 'padratio', 1);
%             saveas(gca, fullfile(saving_path, file_name)); % save it
%             % Close the figure
%             close(gcf)
        end
        toc
    end
end
    

