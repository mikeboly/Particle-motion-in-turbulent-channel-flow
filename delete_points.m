function [U, point, anl] = delete_points(U, point, anl)
    % x方向的周期性边界条件
    U(U(:,1) < 0, 1) = U(U(:,1) < 0, 1) + 2;  % 从x=0左边出界的粒子返回到x=2
    U(U(:,1) > 2, 1) = U(U(:,1) > 2, 1) - 2;  % 从x=2右边出界的粒子返回到x=0

    % y方向的周期性边界条件
    U(U(:,2) < 0, 2) = U(U(:,2) < 0, 2) + 4;  % 从y=0出界的粒子返回到y=4
    U(U(:,2) > 4, 2) = U(U(:,2) > 4, 2) - 4;  % 从y=4出界的粒子返回到y=0

    % z方向的反弹边界条件
    % 粒子触碰 z=0 边界
    rebound_bottom = U(:,3) < 0;
    if any(rebound_bottom)
        U(rebound_bottom, 3) = 0;              % 将z位置调整到z=0
        U(rebound_bottom, 6) = -U(rebound_bottom, 6); % 反转vz速度
    end

    % 粒子触碰 z=1 边界
    rebound_top = U(:,3) > 1;
    if any(rebound_top)
        U(rebound_top, 3) = 1;                 % 将z位置调整到z=1
        U(rebound_top, 6) = -U(rebound_top, 6); % 反转vz速度
    end
end
