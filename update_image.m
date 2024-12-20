% 更新粒子运动的可视化
mode = exist('fig', 'var') && isvalid(fig);
if ~mode
    % 初始化图像窗口
    fig = figure;
    hold on
    axis([0 2 0 4 0 1]);  % 设置空间范围
    set(gca, 'Box', 'on');
    view(160, 20);  % 设置视角
    xlabel('x'); ylabel('y'); zlabel('z');

    % 初始化粒子颜色（全部设置为黑色）和动画点
    color = repmat([0, 0, 0], num, 1);  % 黑色
    point = cell(num, 1);
    for m = 1:num
        % 修改为实心点，颜色为黑色
        point{m} = animatedline('MaximumNumPoints', 1, ...
            'Color', color(m,:), 'LineStyle', 'none', 'Marker', '.', 'MarkerSize', 10);
    end
end

% 更新粒子位置
for m = 1:num
    %addpoints(anl{m}, U(m,1), U(m,2), U(m,3));
    addpoints(point{m}, U(m,1), U(m,2), U(m,3));
end

% 更新标题和绘图
title(sprintf("T=%.3f", T));
drawnow;

% 保存当前帧到GIF
make_GIF(fig, "Animation", mode);
