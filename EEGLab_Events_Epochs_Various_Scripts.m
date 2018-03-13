%% Chooses one type of event - e.g. B2(EI) and cuts it from the signal, then saves new data
% For all files stored in ALLEEG structure

% Choose duration in ms (start_e, end_e)
start_e = 0;
end_e = 750;

for ii = 1:numel(ALLEEG)   
   [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',ii,'study',0);
    EEG = pop_rmdat( EEG, {'B2(EI)'},[start_e end_e] ,0);
    newName=sprintf('EI_%d',ii);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',newName,'gui','off'); 
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end
%

%% Makes epochs based on chosen event (here for 0-1; and event named 'TicToc'
% For all files stored in ALLEEG structure

for ii = 1:numel(ALLEEG)  
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',ii,'study',0);
   
    newName=sprintf('Data_%d_epochs',ii);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, {  'TicToc'  }, [0  1], 'newname', newName, 'epochinfo', 'yes');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',newName,'gui','off'); 

    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end

%% Epoch-2-continious data
% For all files stored in ALLEEG structure

for ii = 1:numel(ALLEEG)  
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',ii,'study',0);
   
    newName=sprintf('Data_%d_cont',ii);
    EEG = eeg_checkset( EEG );
    
    EEG = epoch2continuous(EEG);
    
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',newName,'gui','off'); 

    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end

%% Removes boundary events 
% For all files stored in ALLEEG structure

fixed = numel(ALLEEG);
for ii = fixed:-1:1
    fixed_events = numel(ALLEEG(ii).event);
        for kk = fixed_events:-1:1
            tf = isequal(ALLEEG(ii).event(kk).type,'boundary');
                if tf == 1
                     ALLEEG(ii).event(kk) = [];
                end     
        end
end



