function least_squares_pic(dopause)

% To do: tidy up and add comments

if nargin == 1 && dopause
    dopause = @() pause;
else
    dopause = @() 0;
end

A = sym([8 1 ; -1 6 ; -2 3]);
b = sym([4; -3; 2]);
x = (A'*A) \ (A'*b);

figure
pts = [zeros(3,1) A diff(double(A),[],2)];
mp = mean(pts, 2);


fill3(pts(1,:), pts(2,:), pts(3,:), 'c', 'EdgeColor', 'none')
axis vis3d, axis equal, hold on

legend('colspace(A)', 'location', 'bestoutside')

dopause();


quiver3(mp(1), mp(2), mp(3), b(1), b(2), b(3), 'k', 'autoscale', 'off', 'LineWidth', 2, 'DisplayName', 'b')

dopause();


bP = A * x;
quiver3(mp(1), mp(2), mp(3), bP(1), bP(2), bP(3), 'r', 'autoscale', 'off', 'LineWidth', 2, 'DisplayName', 'Ax')

dopause();

r = b - bP;
quiver3(mp(1)+bP(1), mp(2)+bP(2), mp(3)+bP(3), r(1), r(2), r(3), 'b', 'autoscale', 'off', 'LineWidth', 2, 'DisplayName', 'b-Ax')

dopause();


% ylim([-1,6])

dopause();

w = A*(x+[0.1;-0.2]);
r2 = b - w;
quiver3(mp(1), mp(2), mp(3), w(1), w(2), w(3), 'r:', 'autoscale', 'off', 'LineWidth', 2, 'DisplayName', 'Ax_1')

dopause();

quiver3(mp(1)+w(1), mp(2)+w(2), mp(3)+w(3), r2(1), r2(2), r2(3), 'b:', 'autoscale', 'off', 'LineWidth', 2, 'DisplayName', 'b-Ax_1')

dopause();

r2P = bP - w;
quiver3(mp(1)+w(1), mp(2)+w(2), mp(3)+w(3), r2P(1), r2P(2), r2P(3), 'k:', 'autoscale', 'off', 'LineWidth', 2, 'DisplayName', 'Ax - Ax_1')
