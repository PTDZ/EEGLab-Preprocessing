%% Re-refence to average reference
%  For all files stored in ALLEEG structure

for ii = 1:numel(ALLEEG)  
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',ii,'study',0);
    
        newName=sprintf('EyeOpen_%d_avg_ref',ii);
        EEG = pop_reref( EEG, []);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',newName,'gui','off'); 

    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end

%% Deletes previous data
fixed = numel(ALLEEG);
for ii = fixed:-1:1
    if ALLEEG(ii).ref == 'common'
        ALLEEG(ii) = [];
    end      
end
%% Saves new dataset
save('AVERAGE_REF.mat','ALLEEG');



