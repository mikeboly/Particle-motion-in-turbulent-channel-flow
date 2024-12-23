beta = 2;
tau = 0.01;

filename1 = sprintf('./results/ensembleData_%g_%g.mat', beta, tau);
filename2 = sprintf('./results/pressure_gradient_%g_%g.mat', beta, tau);
filename3 = sprintf('./results/Drag_force_%g_%g.mat', beta, tau);
filename4 = sprintf('./results/Lift_force_%g_%g.mat', beta, tau);
particle_data = load(filename1);
particle_data = particle_data.ensembleData;
pressure_data = load(filename2);
pressure_data = pressure_data.pressure_gradient;
drag_data = load(filename3);
drag_data = drag_data.Drag_force;
lift_data = load(filename4);
lift_data = lift_data.Lift_force;

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
title(sprintf('Density Distribution (\\beta = %g, \\tau = %g)', beta, tau));
saveas(gcf, sprintf('./figs/Density_Distribution_%g_%g.png', beta, tau));

% 绘制速度分布
figure
plot(wp, z1, 'LineWidth', 2);
xlabel('$\langle w_{particle} \rangle$', 'Interpreter', 'latex');
ylabel('z/H');
title(sprintf('Wall-normal Velocity Distribution (\\beta = %g, \\tau = %g)', beta, tau));
saveas(gcf, sprintf('./figs/Velocity_Distribution_%g_%g.png', beta, tau));
% % 绘制密度分布
% figure
% plot(density, z1, 'LineWidth', 2);
% xlabel('density');
% ylabel('z/H');

%% 绘制最后时刻(最后8000个数据）粒子分布图 xz yz xy

% 读取涡量图
vorticity_image = imread('./figs/vorticity_image.png');

% 显示涡量图
figure;
h = imagesc(x, z, vorticity_image);
set(h, 'AlphaData', 0.5); % 设置透明度为0.5
caxis([-1 1]); % 设置colorbar数据范围为-1到1
colorbar; % 添加colorbar来表示涡量大小
hold on;
% 绘制xz平面图
scatter(particle_data(end-8000:end,1), particle_data(end-8000:end,3), 5, 'filled', 'k');
xlabel('x/H');
ylabel('z/H');
title(sprintf('Particle Distribution in x-z Plane (\\beta = %g, \\tau = %g)', beta, tau));
hold off;
saveas(gcf, sprintf('./figs/Particle_Distribution_xz_%g_%g.png', beta, tau));

% % 绘制yz平面图
% figure
% scatter(particle_data(end-8000:end,2), particle_data(end-8000:end,3), 5, 'filled', 'k');
% xlabel('y/H');
% ylabel('z/H');
% title(sprintf('Particle Distribution in y-z Plane (\\beta = %g, \\tau = %g)', beta, tau));
% saveas(gcf, sprintf('./figs/Particle_Distribution_yz_%g_%g.png', beta, tau));
% 
% % 绘制xy平面图
% figure
% scatter(particle_data(end-8000:end,1), particle_data(end-8000:end,2), 5, 'filled', 'k');
% xlabel('x/H');
% ylabel('y/H');
% title(sprintf('Particle Distribution in x-y Plane (\\beta = %g, \\tau = %g)', beta, tau));
% saveas(gcf, sprintf('./figs/Particle_Distribution_xy_%g_%g.png', beta, tau));

%% 绘制不同Force关于z的分布图

dz = 0.01;
z1 = 0:dz:1;
num = size(pressure_data, 1);
% 计算压力梯度分布
pressure_distri = zeros(length(z1), 1);
for i = 1 : length(z1)
    pressure_distri(i) = sum(pressure_data(:,3) .* (particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz)) / sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz);
end

% 计算Drag force分布
drag_distri = zeros(length(z1), 1);
for i = 1 : length(z1)
    drag_distri(i) = sum(drag_data(:,3) .* (particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz)) / sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz);
end

% 计算Lift force分布
lift_distri = zeros(length(z1), 1);
for i = 1 : length(z1)
    lift_distri(i) = sum(lift_data(:,3) .* (particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz)) / sum(particle_data(:,3) >= z1(i) & particle_data(:,3) < z1(i) + dz);
end

% 绘制分布图
figure
hold on
plot(pressure_distri, z1, 'LineWidth', 2, 'LineStyle', '--');
plot(drag_distri, z1, 'LineWidth', 2, 'LineStyle', '-.');
plot(lift_distri, z1, 'LineWidth', 2, 'LineStyle', ':');
set(gcf, 'Position', [100, 100, 800, 600]); % 调整绘制窗口大小
hold off
xlabel('Force');
ylabel('z/H');
title(sprintf('Force Distribution (\\beta = %g, \\tau = %g)', beta, tau));
legend('Pressure Gradient', 'Drag Force', 'Lift Force');

saveas(gcf, sprintf('./figs/Force_Distribution_%g_%g.png', beta, tau));