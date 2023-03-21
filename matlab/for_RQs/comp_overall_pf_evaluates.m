function [gmeans_est_surrogate, gmeans_tru_surrogate, gmeans_tru_actual] ...
    = comp_overall_pf_evaluates(eval_wait_days, eval_times_surrogate, ...
    y_true_surrogate, y_pred_surrogate_mat, VLs_eval_surrogate, ...
    eval_times_actual, y_true_actual, y_pred_actual_mat)
% 
% Compute the true and estimated overall PFs associated to a waiting time.
%   
% Liyan Song on July 2019
% 

% for surrogate timestamps, TODO 3/23 remove "vld"
valid_surrogate_steps = ~isnan(y_pred_surrogate_mat(:, 1));
y_pred_surrogate_mat_vld = y_pred_surrogate_mat(valid_surrogate_steps, :);
y_true_surrogate_vld = y_true_surrogate(valid_surrogate_steps);
eval_times_surrogate_vld = eval_times_surrogate(valid_surrogate_steps);
VLs_eval_surrogate_vld = VLs_eval_surrogate(valid_surrogate_steps);

% for actual timestamps, TODO 3/23 remove "vld"
valid_current = ~isnan(y_pred_actual_mat(:, 1));
y_pred_actual_mat_vld = y_pred_actual_mat(valid_current, :);
y_true_actual_vld = y_true_actual(valid_current);
eval_times_actual_vld = eval_times_actual(valid_current);

% observed labels at surrogated time steps
time_end = max(eval_times_actual_vld);
y_obsv_surrogate = decide_obverve_labels(eval_wait_days, time_end, ...
    y_true_surrogate_vld, VLs_eval_surrogate_vld, eval_times_surrogate_vld);

% estimated overall PF based on surrogate time steps and observed labels
gmeans_est_surrogate = pf_evaluate_overall(...
    y_obsv_surrogate, y_pred_surrogate_mat_vld);

% estimated overall PF based on surrogate time steps
gmeans_tru_surrogate = pf_evaluate_overall(...
    y_true_surrogate_vld, y_pred_surrogate_mat_vld);

% true overall PF
gmeans_tru_actual = pf_evaluate_overall(...
    y_true_actual_vld, y_pred_actual_mat_vld);

end