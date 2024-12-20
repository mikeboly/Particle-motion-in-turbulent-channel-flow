% 绘制湍流场沿垂直于壁面的平均速度剖面

uy_averg = mean(uy,[1,2]);
plot(uy_averg(:), z, 'LineWidth', 2);
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
figure
