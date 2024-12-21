% 主程序：模拟粒子在流场中的运动轨迹
% 通过Runge-Kutta方法进行时间推进

% 并行设置（可选）
% parpool("Threads", 4)

% 初始化参数
lambda = 5;        % 参数lambda
D = 0.01;           % 几何尺寸相关参数（粒子直径）
Re = 5600;          % 雷诺数
dt = 5e-3;          % 时间步长
rho_c = 1;          % 流体密度

beta = 3/(2*lambda + 1);  % 参数beta
tau = Re*D^2/12/beta;     % 弛豫时间tau
tau = 0.5;
% dt = min(dt, tau/2);    % 可选：限制时间步长

% 初始化方法（如未定义 method）
if ~exist('method', 'var')
    interpolation   % 计算插值函数
    RK_scheme       % 定义Runge-Kutta方案
end

Scheme = RK3;       % 使用三阶Runge-Kutta方法
steps = length(Scheme);  % Runge-Kutta步数

T = 0;             % 初始化时间
create_points1      % 生成初始粒子分布
update_image      % 初始化可视化

count = 0;         % 计数器

% 计算 Saffman 升力前的系数
saffman_coeff = 4 * beta / (rho_c * pi * D^3);

while num > 0 && T <= 100  % 主循环：粒子存在且时间未到达最大值
    U0 = U;        % 保存当前状态
    rhs = zeros(num, 6, steps);  % 初始化右侧项

    % Runge-Kutta时间推进
    for s = 1 : steps
        rhs(:,1:3,s) = U(:,4:6);  % 速度项
        
        % Saffman 升力项计算
        omega = func_omega(U(:,1:3));  % 计算涡量
        rel_vel = func_u(U(:,1:3)) - U(:,4:6);  % 相对速度 u - v
        saffman_force = saffman_coeff * saffman_lift_force(rel_vel, omega, D, Re);  % Saffman 升力

        % 添加到右端项
        rhs(:,4:6,s) = beta*(-func_Dp(U(:,1:3)) + func_Lu(U(:,1:3))/Re) ...
             + (func_u(U(:,1:3)) - U(:,4:6))/tau; ...
             %- saffman_force;  % 添加 Saffman 升力项
         %rhs(:,4:6,s) =  (func_u(U(:,1:3)) - U(:,4:6))/tau - saffman_force;  % 添加 Saffman 升力项
        

        U = U0;
        for l = 1 : s
            U = U + Scheme(s,l)*dt*rhs(:,:,l);  % 组合Runge-Kutta项
        end
    end

    % 删除超出边界的粒子
    [U, point] = delete_points(U, point);
    num = size(U, 1);  % 更新粒子数量

    T = T + dt;       % 时间推进
    count = count + 1;

    % 每10步更新一次可视化
    if count >= 10
        update_image_yz
        count = 0;
    end
end



