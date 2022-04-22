function plot_lincomb(c, U)

[m,n] = size(U);
if m ~= 2 && m ~= 3
    error('U must be an array of 2- or 3-dimensional column vectors')
end

W = c(:)' .* U;

P = cumsum([zeros(m,1) W], 2);  % cumulative position
v = P(:,n+1);                   % final position

lw = 2;

set(gca, 'ColorOrderIndex', 1)
held = ishold;

if m == 2
    quiver(P(1,1:n), P(2,1:n), W(1,:), W(2,:), 'AutoScale', 'off', 'LineWidth', lw)
    hold on
    quiver(0, 0, v(1), v(2), 'AutoScale', 'off', 'LineWidth', lw)
    quiver(P(1,1:n), P(2,1:n), U(1,:), U(2,:), 'AutoScale', 'off', 'LineStyle', ':', 'LineWidth', lw)    
    axis equal
    grid on
else
    quiver3(P(1,1:n), P(2,1:n), P(3,1:n), W(1,:), W(2,:), W(3,:), 'AutoScale', 'off')
    hold on
    quiver3(0, 0, 0, v(1), v(2), v(3), 'AutoScale', 'off')
    axis vis3d
    grid on
end

xlabel x
ylabel y
zlabel z
if ~held, hold off; end