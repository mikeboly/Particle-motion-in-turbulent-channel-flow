% beta = 0.01;
% tau = 0.6;

filename1 = sprintf('./results/nosaff_ensembleData_%g_%g.mat', beta, tau);
filename2 = sprintf('./results/nosaff_pressure_gradient_%g_%g.mat', beta, tau);
filename3 = sprintf('./results/nosaff_Drag_force_%g_%g.mat', beta, tau);

particle_data = load(filename1);
particle_data = particle_data.ensembleData;
pressure_data = load(filename2);
pressure_data = pressure_data.pressure_gradient;
drag_data = load(filename3);
drag_data = drag_data.Drag_force;

%% 绘制粒子速度分布和密度分布(关于垂直于壁面的方向)

% particle_data包含T=500-700所有粒子的位置和速度信息
dz = 0.01;
z1 = 0:dz:1;
num = size(particle_data, 1);
% 计算速度分布
wp = zeros(length(z1), 1);
for i = 1 : length(z1)
    wp(i) = sum(particle_data(:,6) .* (particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz)) / sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz);
end
% 计算密度分布
density = zeros(length(z1), 1);
for i = 1 : length(z1)
    density(i) = sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz) / (dz * num);
end


% 绘制密度分布柱状图
figure
bar(z1, density, 'histc');
ylabel('density');
xlabel('z/H');
title(sprintf('Density Distribution (\\beta = %g, \\tau = %g, without lift)', beta, tau));
saveas(gcf, sprintf('./figs/nosaff_Density_Distribution_%g_%g.png', beta, tau));

% 绘制速度分布
figure
plot(wp, z1, 'LineWidth', 2);
xlabel('$\langle w_{particle} \rangle$', 'Interpreter', 'latex');
ylabel('z/H');
title(sprintf('Wall-normal Velocity Distribution (\\beta = %g, \\tau = %g, without lift)', beta, tau));
saveas(gcf, sprintf('./figs/nosaff_Velocity_Distribution_%g_%g.png', beta, tau));

%%
% dz = 0.01;
% z1 = 0:dz:1;
% num = size(pressure_data, 1);
% % 计算压力梯度分布
% pressure_distri = zeros(length(z1), 1);
% for i = 1 : length(z1)
%     pressure_distri(i) = sum(pressure_data(:,3) .* (particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz)) / sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz);
% end

% % 计算Drag force分布
% drag_distri = zeros(length(z1), 1);
% for i = 1 : length(z1)
%     drag_distri(i) = sum(drag_data(:,3) .* (particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz)) / sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz);
% end

% % 绘制分布图
% figure
% hold on
% plot(pressure_distri, z1, 'LineWidth', 2, 'LineStyle', '--');
% plot(drag_distri, z1, 'LineWidth', 2, 'LineStyle', '-.');
% plot(lift_distri, z1, 'LineWidth', 2, 'LineStyle', ':');
% set(gcf, 'Position', [100, 100, 800, 600]); % 调整绘制窗口大小
% hold off
% xlabel('Force');
% ylabel('z/H');
% title(sprintf('Force Distribution (\\beta = %g, \\tau = %g, without lift)', beta, tau));
% legend('Pressure Gradient', 'Drag Force', 'Lift Force');

% saveas(gcf, sprintf('./figs/nosaff_Force_Distribution_%g_%g.png', beta, tau));