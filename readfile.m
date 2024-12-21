x = h5read('./data/field_grid.h5', '/xcb');
y = h5read('./data/field_grid.h5', '/ycb');
z = h5read('./data/field_grid.h5', '/zcb');
pr = h5read('./data/field_pr.h5', '/pr');
ux = h5read('./data/field_ux.h5', '/q1');
uy = h5read('./data/field_uy.h5', '/q2');
uz = h5read('./data/field_uz.h5', '/q3');

%mesh(x, z, squeeze(uy(:, 120, :))')
%mesh(x, y, uy(:, :, 240)')
%mesh(x, z, squeeze(uz(:, 120, :))')
