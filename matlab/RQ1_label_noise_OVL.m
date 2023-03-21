% For investigating RQ1, implement the computation of the levels of label
% noise with respect to waiting times. 
% 
% Liyan Song on Jan.2020, cleaned on March 2022
% 

clear, clc, close all

% load the data
data_name = 'brackets';
dir_data = '../data/';
data_flnm = [dir_data, data_name,'.csv'];
Data = xlsread(data_flnm);
[commit_time_all, X_all, y_tru_all, vl_days_all] = deal(...
    Data(:,1), Data(:,2:end-2), Data(:,end-1), Data(:,end));

% the factors investigated
wait_days_lst = [15; 30; 60; 90]; 
stream_len_lst = (1000:1000:5000)';
stream_len_max = max(stream_len_lst);


% compute label noise in the overall (research) scenario
noise_ovl_mat = nan*ones(length(wait_days_lst), length(stream_len_lst));
for ww = 1:length(wait_days_lst)
    wait_days = wait_days_lst(ww);
    for tt = 1:length(stream_len_lst)
        stream_len = stream_len_lst(tt);
        time_stream_end = commit_time_all(stream_len);
        % observed labels
        [labels_obv, labels_tru_use] = decide_obverve_labels(...
            wait_days, time_stream_end, y_tru_all, vl_days_all, commit_time_all);
        % label noise in the research scenario
        noise_ovl = comp_label_noise_research(labels_obv, labels_tru_use);
        noise_ovl_mat(ww, tt) = noise_ovl; % (w,T)
    end
end

