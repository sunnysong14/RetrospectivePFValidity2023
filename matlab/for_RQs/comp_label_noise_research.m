function noise_research = comp_label_noise_research(labels_obv, labels_tru)
% Compute label noise in the research scenario. 
% 
% The function can handle NaN inputs and set the output as NaN.
% 
% Liyan Song on Dec.2019
% 

% refer to the paper for the formulation
fenzi = sum(abs(labels_obv - labels_tru));
fenmu = sum(labels_tru);
noise_research = fenzi/fenmu;

% when no data with class 1 exists and all observed labels are correct, the
% NaN value of label noise should be altered to 0
if isnan(noise_research)
    noise_research = 0; 
end

end
