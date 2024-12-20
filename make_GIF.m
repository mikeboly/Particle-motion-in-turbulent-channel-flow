function [] = make_GIF(fig, name, mode, Q)
if nargin < 4
    Q = 32;
end
delay = 1/20;
F = getframe(fig);
I = frame2im(F);
[I, map] = rgb2ind(I, Q, "nodither");
if mode
    imwrite(I, map, name + ".gif",...
        "WriteMode", "append", "DelayTime", delay);
else
    imwrite(I, map, name + ".gif", "DelayTime", delay);
end
end
