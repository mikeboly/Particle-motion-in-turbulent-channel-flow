% 绘制湍流场沿垂直于壁面的平均速度剖面

uy_avg = mean(uy,[1,2]);
plot(uy_avg(:), z, 'LineWidth', 2);
xlabel('u_y');
ylabel('z');

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

%%

% 绘制粒子速度分布和密度分布(关于垂直于壁面的方向)
% ensembleData包含T=500-700所有粒子的位置和速度信息
dz = 0.1;
z1 = 0:dz:1;
num = size(ensembleData, 1);
% 计算速度分布
uy = zeros(length(z1), 1);
for i = 1 : length(z1)
    uy(i) = sum(ensembleData(:,6) .* (ensembleData(:,3) >= z1(i) & ensembleData(:,3) < z1(i) + dz)) / sum(ensembleData(:,3) >= z1(i) & ensembleData(:,3) < z1(i) + dz);
end
% 计算密度分布
density = zeros(length(z1), 1);
for i = 1 : length(z1)
    density(i) = sum(ensembleData(:,3) >= z1(i) & ensembleData(:,3) < z1(i) + dz) / (dz * num);
end
% 绘制速度分布
figure
plot(uy, z1, 'LineWidth', 2);
xlabel('u_y');
ylabel('z');
% 绘制密度分布
figure
plot(density, z1, 'LineWidth', 2);
xlabel('density');
ylabel('z');

