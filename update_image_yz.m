% 更新粒子运动的可视化
mode = exist('fig', 'var') && isvalid(fig);
if ~mode
    % 初始化图像窗口
    fig = figure;
    set(fig, 'Position', [100, 100, 1200, 800]);  % 设置窗口尺寸 [x, y, 宽度, 高度]
    hold on
    axis([0 4 0 1]);  % 设置 XZ 平面范围
    set(gca, 'Box', 'on');
    xlabel('y', 'FontSize', 14);  % 设置 x 轴字体大小
    ylabel('z', 'FontSize', 14);  % 设置 z 轴字体大小
    %ylabel('z');  % 去掉 y 轴标签
    grid on;  % 添加网格（可选）

    % 初始化粒子颜色（全部设置为黑色）和动画点
    color = repmat([0, 0, 0], num, 1);  % 黑色
    point = cell(num, 1);
    for m = 1:num
        % 修改为实心点，颜色为黑色
        point{m} = animatedline('MaximumNumPoints', 1, ...
            'Color', color(m,:), 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 15);  % 调整 MarkerSize
    end
end

% 更新粒子位置（只绘制 x 和 z 坐标）
for m = 1:num
    addpoints(point{m}, U(m,2), U(m,3));  % 只绘制 x 和 z
end

% 更新标题和绘图
title(sprintf("T=%.3f", T), 'FontSize', 16);  % 设置标题字体大小
drawnow;

% 保存当前帧到GIF
% make_GIF(fig, "Animation", mode);
