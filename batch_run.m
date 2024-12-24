%批量运行
tau_vals = [0.02,0.04,0.06,0.08, 0.2,0.4];
beta_vals = [0.01,2];

for i = 1:length(tau_vals)
    for j = 1:length(beta_vals)
        tau = tau_vals(i);
        beta = beta_vals(j);
        main;
    end
end