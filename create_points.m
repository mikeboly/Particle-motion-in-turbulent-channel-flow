% 生成粒子初始位置与速度

num = 64;  % 粒子数量

% 在x和z方向生成均匀分布的网格点
X = linspace(1/8, 15/8, 8);
Z = linspace(1/16, 15/16, 8);
[X, Z] = meshgrid(X, Z);

% 转换为列向量
X = reshape(X,[],1);
Z = reshape(Z,[],1);

Y = 0.01 * ones(num, 1);  % y方向位置固定为0.01

% 初始化速度分量
vx = zeros(num, 1);
vy = zeros(num, 1);
vz = zeros(num, 1);

% 组合成状态矩阵U：[x, y, z, vx, vy, vz]
U = [X, Y, Z, vx, vy, vz];
