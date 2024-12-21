% 插值函数定义：对流场数据进行插值

readfile  % 读取流场数据

% 计算压力梯度
[Dxp, Dyp, Dzp] = Gradient(x, y, z, pr);

% 计算速度场的拉普拉斯算子
Lux = Laplace(x, y, z, ux);
Luy = Laplace(x, y, z, uy);
Luz = Laplace(x, y, z, uz);

% 计算速度场的梯度
[Dxux, Dyux, Dzux] = Gradient(x, y, z, ux);
[Dxuy, Dyuy, Dzuy] = Gradient(x, y, z, uy);
[Dxuz, Dyuz, Dzuz] = Gradient(x, y, z, uz);

% 计算涡量分量 (omega_x, omega_y, omega_z)
omega_x = Dzuy - Dyuz;  % ω_x = ∂u_y/∂z - ∂u_z/∂y
omega_y = Dxuz - Dzux;  % ω_y = ∂u_z/∂x - ∂u_x/∂z
omega_z = Dyux - Dxuy;  % ω_z = ∂u_x/∂y - ∂u_y/∂x

method = "makima";  % 插值方法：makima插值

% 速度场插值函数
func_ux = griddedInterpolant({x, y, z}, ux, method);
func_uy = griddedInterpolant({x, y, z}, uy, method);
func_uz = griddedInterpolant({x, y, z}, uz, method);
func_u = @(X) [func_ux(X), func_uy(X), func_uz(X)];

% 压力梯度插值函数
func_Dxp = griddedInterpolant({x, y, z}, Dxp, method);
func_Dyp = griddedInterpolant({x, y, z}, Dyp, method);
func_Dzp = griddedInterpolant({x, y, z}, Dzp, method);
func_Dp = @(X) [func_Dxp(X), func_Dyp(X), func_Dzp(X)];

% 拉普拉斯插值函数
func_Lux = griddedInterpolant({x, y, z}, Lux, method);
func_Luy = griddedInterpolant({x, y, z}, Luy, method);
func_Luz = griddedInterpolant({x, y, z}, Luz, method);
func_Lu = @(X) [func_Lux(X), func_Luy(X), func_Luz(X)];

% 涡量插值函数
func_omega_x = griddedInterpolant({x, y, z}, omega_x, method);
func_omega_y = griddedInterpolant({x, y, z}, omega_y, method);
func_omega_z = griddedInterpolant({x, y, z}, omega_z, method);
func_omega = @(X) [func_omega_x(X), func_omega_y(X), func_omega_z(X)];
