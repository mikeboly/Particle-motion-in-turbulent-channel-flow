% 主程序：模拟粒子在流场中的运动轨迹
% 通过Runge-Kutta方法进行时间推进

% 并行设置（可选）
% parpool("Threads", 4)

% 初始化参数
lambda = 10;        % 参数lambda
D = 0.001;          % 几何尺寸相关参数
Re = 5600;         % 雷诺数
dt = 5e-2;         % 时间步长

beta = 3/(2*lambda + 1);  % 参数beta
tau = Re*D^2/12/beta;     % 弛豫时间tau
% dt = min(dt, tau/2);    % 可选：限制时间步长

tau = 3;
% 初始化方法（如未定义 method）
if ~exist('method', 'var')
    interpolation   % 计算插值函数
    RK_scheme       % 定义Runge-Kutta方案
end

Scheme = RK3;       % 使用三阶Runge-Kutta方法
steps = length(Scheme);  % Runge-Kutta步数
%%
T = 0;             % 初始化时间
create_points1      % 生成初始粒子分布
update_image       % 初始化可视化

count = 0;         % 计数器

%%
while num > 0 && T <= 100  % 主循环：粒子存在且时间未到达最大值
    U0 = U;        % 保存当前状态
    rhs = zeros(num, 6, steps);  % 初始化右侧项

    % Runge-Kutta时间推进
    for s = 1 : steps
        rhs(:,1:3,s) = U(:,4:6);  % 速度项
        rhs(:,4:6,s) = beta*(-func_Dp(U(:,1:3)) + func_Lu(U(:,1:3))/Re) ...
            + (func_u(U(:,1:3)) - U(:,4:6))/tau;  % 粒子运动方程右侧项
        U = U0;
        for l = 1 : s
            U = U + Scheme(s,l)*dt*rhs(:,:,l);  % 组合Runge-Kutta项
        end
    end

    % 删除(更新)超出边界的粒子
    [U, point, anl] = delete_points(U, point, anl);
    num = size(U, 1);  % 更新粒子数量

    T = T + dt;       % 时间推进
    count = count + 1;

    % 每10步更新一次可视化
    if count >= 10
        update_image
        count = 0;
    end
end
