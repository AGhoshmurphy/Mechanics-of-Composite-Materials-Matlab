% Maximum Strain Theory Results
SR_max_pos_MS = 50.08; % obtained from the previous code
SR_max_neg_MS = 61.33; % obtained from the previous code

% Tsai-Wu Theory Results
SR_max_pos_TW = 34.19; % obtained from the previous code
SR_max_neg_TW = 52.75; % obtained from the previous code

% Create a bar chart
SR_values = [SR_max_pos_MS, SR_max_neg_MS; SR_max_pos_TW, SR_max_neg_TW];
bar(SR_values)

% Add labels and legend
xlabel('Failure Criteria')
ylabel('Maximum Strength Ratio')
legend('Maximum Strain Theory', 'Tsai-Wu Theory')