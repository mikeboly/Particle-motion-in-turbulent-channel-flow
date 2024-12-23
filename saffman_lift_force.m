function lift_force = saffman_lift_force(rel_vel, omega, D, Re)
    % 计算 Saffman 升力
    %
    % 输入参数：
    %   rel_vel - 粒子和流体速度差 (u - v)，大小为 [num_particles, 3]
    %   omega - 涡量 (ω)，大小为 [num_particles, 3]
    %   D - 粒子直径
    %   Re - 全局雷诺数
    %
    % 输出参数：
    %   lift_force - Saffman 升力，大小为 [num_particles, 3]

    % 常数
    const = 1.61;        % 常数 1.61
    nu_c = 1 / Re;       % 运动学粘性系数 (ν_c = μ_c / ρ_c)
    rho_c = 1;           % 流体密度
    mu_c = nu_c * rho_c; % 动力粘性系数 (μ_c)

    % 涡量的大小 |ω|
    omega_magnitude = sqrt(sum(omega.^2, 2));  % 每个粒子的涡量大小

    % 速度差 (u - v) 的模长
    rel_vel_magnitude = sqrt(sum(rel_vel.^2, 2));  % 每个粒子的速度差模长

    % 局部雷诺数 Re_r
    Re_r = rel_vel_magnitude .* D / nu_c;  % 逐粒子计算 Re_r

    % 定义 gamma 变量
    gamma = (D / 2) .* (omega_magnitude ./ rel_vel_magnitude);  % 计算 gamma = D/2 |ω| / |u-v|
    gamma(isnan(gamma)) = 0;  % 处理可能的 0/0 问题

    % 计算升力修正系数 FL / FSaff (即 Cs)
    Cs = zeros(size(Re_r));
    idx_small_Re = Re_r <= 40;  % 小 Re_r 的粒子
    idx_large_Re = Re_r > 40;   % 大 Re_r 的粒子

    % 对于 Re_r <= 40 的情况
    Cs(idx_small_Re) = (1 - 0.3314 * sqrt(gamma(idx_small_Re))) ...
        .* exp(-Re_r(idx_small_Re) / 10) + 0.3314 * sqrt(gamma(idx_small_Re));

    % 对于 Re_r > 40 的情况
    Cs(idx_large_Re) = 0.0524 * sqrt(gamma(idx_large_Re) .* Re_r(idx_large_Re));

    % 速度差 (u - v) 和涡量 (ω) 的叉乘
    cross_product = cross(rel_vel, omega, 2);  % 逐粒子计算叉乘

    % 计算最终的 Saffman 升力
    % 此处已剔除 saffman_coeff (在主程序中已定义)
    lift_force = (1./sqrt(omega_magnitude)) .* Cs .* cross_product;

    % 输出升力的大小为 [num_particles, 3] 的矩阵
end