function gmean = pf_evaluate_overall(y_true_col, y_pred_mat)
% 
% Overall PF evaluation for a binary classifion model.
% 
% y_pred_mat: each column contains the predictions with a random seed.
% 
% Liyan Song on Dec.2019
% 

% if the true label is a single value
if length(y_true_col) == 1
    y_true_col = repmat(y_true_col, size(y_pred_mat));
end
is_class1 = (y_true_col()==1);

p = length(y_true_col(is_class1));
n = length(y_true_col(~is_class1));
N = p+n;

if size(y_pred_mat, 2) == 1
    tp = sum(y_true_col(is_class1) == y_pred_mat(is_class1));
    tn = sum(y_true_col(~is_class1) == y_pred_mat(~is_class1));
    
else  % multiple seeds in y_pre_mat
    tp = sum(y_true_col(is_class1) == y_pred_mat(is_class1, :));
    tn = sum(y_true_col(~is_class1) == y_pred_mat(~is_class1, :));    
end
fp = n - tn; % n = TN+FP
fn = p - tp; % p = TP+FN

Pf = [tp; tn; fp; fn];

% performance evaluation
tpr = tp/p;
tnr = tn/n;

[sensitivity, recall] = deal(tpr);
specificity = tnr;

accuracy = (tp+tn)./N;
precision = tp./(tp+fp);
f_measure = 2.*((precision.*recall) ./ (precision+recall));
gmean = sqrt(tpr.*tnr);

% evals = [1-tnr; 1-tpr; accuracy; precision; f_measure; gmean];
% evals: fpr(1), fnr(2), accuracy(3), precision(4), f-Measure(5), g-mean(6)
end
 