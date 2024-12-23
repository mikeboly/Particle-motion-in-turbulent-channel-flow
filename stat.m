readfile;

%%
% 绘制湍流场沿垂直于壁面的平均速度剖面

uy_avg = mean(uy,[1,2]);
plot(uy_avg(:), z, 'LineWidth', 2);
xlabel('u_{y,fluid}');
ylabel('z');
title('平均速度剖面');

%%
%  绘制不同湍流场速度分量RMS脉动的剖面

figure
uy_rms = sqrt(mean(uy.^2,[1,2])-mean(uy,[1,2]).^2);
ux_rms = sqrt(mean(ux.^2,[1,2])-mean(ux,[1,2]).^2);
uz_rms = sqrt(mean(uz.^2,[1,2])-mean(uz,[1,2]).^2);

plot(uy_rms(:), z, 'LineWidth', 2);
xlabel('RMS');
ylabel('z');
hold on
plot(ux_rms(:), z, 'LineWidth', 2);
plot(uz_rms(:), z, 'LineWidth', 2);
legend('u_y','u_x','u_z');
title('均方根速度脉动剖面');

%%

% 绘制粒子速度分布和密度分布(关于垂直于壁面的方向)
% ensembleData包含T=500-700所有粒子的位置和速度信息
dz = 0.01;
z1 = 0:dz:1;
num = size(ensembleData, 1);
% 计算速度分布
wp = zeros(length(z1), 1);
for i = 1 : length(z1)
    wp(i) = sum(ensembleData(:,6) .* (ensembleData(:,3) >= z1(i) & ensembleData(:,3) < z1(i) + dz)) / sum(ensembleData(:,3) >= z1(i) & ensembleData(:,3) < z1(i) + dz);
end
% 计算密度分布
density = zeros(length(z1), 1);
for i = 1 : length(z1)
    density(i) = sum(ensembleData(:,3) >= z1(i) & ensembleData(:,3) < z1(i) + dz) / (dz * num);
end
% 绘制速度分布
figure
plot(wp, z1, 'LineWidth', 2);
xlabel('$\langle w_{particle} \rangle$', 'Interpreter', 'latex');
ylabel('z/H');
% 绘制密度分布
figure
plot(density, z1, 'LineWidth', 2);
xlabel('density');
ylabel('z/H');

% num_U = size(U, 1);
% % 计算速度分布
% vp_y = zeros(length(z1), 1);
% for i = 1 : length(z1)
%     vp_y(i) = sum(U(:,6) .* (U(:,3) >= z1(i) & U(:,3) < z1(i) + dz)) / sum(U(:,3) >= z1(i) & U(:,3) < z1(i) + dz);
% end
% % 计算密度分布
% density = zeros(length(z1), 1);
% for i = 1 : length(z1)
%     density(i) = sum(U(:,3) >= z1(i) & U(:,3) < z1(i) + dz) / (dz * num_U);
% end
% % 绘制速度分布
% figure
% plot(vp_y, z1, 'LineWidth', 2);
% xlabel('$\langle v_{y,fluid} \rangle$', 'Interpreter', 'latex');
% ylabel('z');
% % 绘制密度分布
% figure
% plot(density, z1, 'LineWidth', 2);
% xlabel('density');
% ylabel('z');


%%

% 绘制xz平面的沿着y方向涡量场
figure;
y_sec = 60;
imagesc(x, z, squeeze(omega_y(:,y_sec,:))');
axis off;
set(gca, 'Position', [0 0 1 1]); % Remove white borders
saveas(gcf, sprintf('./figs/Vorticity_image.png'));

%%
%平均后的涡量场
omega_y_avg = mean(omega_y,2);
figure
imagesc(x,z,squeeze(omega_y_avg)');
axis off;
set(gca, 'Position', [0 0 1 1]); % Remove white borders
saveas(gcf, sprintf('./figs/Vorticity_image.png'));

%%
% 绘制xy平面的涡量场
figure;
z_sec = 10;
imagesc(x, y, squeeze(omega_z(:,:,z_sec))');
colorbar;
xlabel('x');
ylabel('y');
title(['Vorticity field at z = ', num2str(z_sec)]);

%h平均后的涡量场
omega_z_avg = mean(omega_z,3);
figure
imagesc(x,y,squeeze(omega_z_avg)');
colorbar;
xlabel('x');
ylabel('y');
title('Mean Vorticity field in x-y plane');

% 绘制yz平面的涡量场
figure;
x_sec = 10;
imagesc(y, z, squeeze(omega_x(x_sec,:,:))');
colorbar;
xlabel('y');
ylabel('z');
title(['Vorticity field at x = ', num2str(x_sec)]);
%平均后的涡量场
omega_x_avg = mean(omega_x,1);
figure
imagesc(y,z,squeeze(omega_x_avg)');
colorbar;
xlabel('y');
ylabel('z');
title('Mean Vorticity field');





%% 绘制yz平面密度分布图
figure;
dz = 0.1;
dy = 0.1;
z1 = 0:dz:1;
y1 = 0:dy:4;
density = zeros(length(y1), length(z1));
for i = 1 : length(y1)
    for j = 1 : length(z1)
        density(i, j) = sum(U(:,2) >= y1(i) & U(:,2) < y1(i) + dy & U(:,3) >= z1(j) & U(:,3) < z1(j) + dz) / (dy * dz * num);
    end
end
imagesc(z1, y1, density);
