%% Resampling of the data
% For all files stored in ALLEEG structure

for ii = 1:numel(ALLEEG)  
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',ii,'study',0);
    
        newName=sprintf('Data_%d_resampled',ii);
        EEG = eeg_checkset( EEG );
        %Choose new sampling rate, here 500 Hz
        EEG = pop_resample( EEG, 500);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',newName,'gui','off'); 

    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end

%% Delete old data with old sampling rate
fixed = numel(ALLEEG);
for ii = fixed:-1:1
    % Checks for datasets with sampling rate > 500 Hz
    if ALLEEG(ii).srate > 500
        ALLEEG(ii) = [];
    end      
end