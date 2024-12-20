% 定义全场范围
num_x = 20;  % x方向粒子数
num_y = 40;  % y方向粒子数
num_z = 10;  % z方向粒子数

% 创建均匀分布的网格
X = linspace(0, 2, num_x);
Y = linspace(0, 4, num_y);
Z = linspace(0, 1, num_z);
[X, Y, Z] = meshgrid(X, Y, Z);

% 转换为列向量
X = reshape(X, [], 1);
Y = reshape(Y, [], 1);
Z = reshape(Z, [], 1);

% 初始化速度分量
vx = zeros(size(X));
vy = zeros(size(Y));
vz = zeros(size(Z));

% 组合成状态矩阵U：[x, y, z, vx, vy, vz]
U = [X, Y, Z, vx, vy, vz];
num = size(U, 1);  % 更新粒子总数
