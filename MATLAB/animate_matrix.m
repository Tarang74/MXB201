function animate_matrix(A, overlay, vector)
% Tim Moroney, 2021

if nargin == 0
    A = randn(2,2);
elseif isequal(class(A), 'sym')
    A = double(A);
end

if nargin < 2 || isempty(overlay)
    overlay = '';
end

numpts = 256;

lw = 2;

if ~isequal(size(A), [2 2]) && ~isequal(size(A), [3 2])
    error('A must be a 2x2 matrix or a 3x2 matrix.')
end

issquare = size(A,1) == 2;

showeig = false; showsing = false;
if contains(overlay, 'e', 'IgnoreCase', true)
    showeig = issquare;
end
if contains(overlay, 's', 'IgnoreCase', true)
    showsing = true;
end

if nargin < 3
    animate = true;
    angle = 0;
else
    animate = false;
    angle = double(atan2(vector(2), vector(1)));
end

t = 2*pi*linspace(0, 1, numpts) + angle;
z = exp(1i*t);
circle = [real(z); imag(z)];
ellipse = A * circle;

handle = figure;
if animate
    set(handle, 'Visible', true, 'KeyPressFcn', @KeyPressed)
end
hold on

warning('off', 'MATLAB:legend:IgnoringExtraEntries')

% Eigenvectors
if issquare
    [V,D] = eig(A);
    if isreal(D)
        s = max(1, abs(diag(D)));
        ep(1) = plot(s(1)*[-V(1,1) V(1,1)], s(1)*[-V(2,1), V(2,1)], 'k--', 'linewidth', lw);
        ep(2) = plot(s(2)*[-V(1,2) V(1,2)], s(2)*[-V(2,2), V(2,2)], 'k--', 'linewidth', lw);
    else
        ep = plot([],[]);
    end
    set(ep, 'Visible', showeig)
end

% Singular vectors
[U,S,V] = svd(A);

if issquare
    set(gca, 'ColorOrderIndex', 1)
    sp(1) = plot([-V(1,1) V(1,1)], [-V(2,1), V(2,1)], '--', 'linewidth', lw);
    sp(2) = plot(S(1,1)*[-U(1,1) U(1,1)], S(1,1)*[-U(2,1), U(2,1)], '--', 'linewidth', lw);
    set(gca, 'ColorOrderIndex', 1)
    sp(3) = plot([-V(1,2) V(1,2)], [-V(2,2), V(2,2)], '--', 'linewidth', lw);
    sp(4) = plot(S(2,2)*[-U(1,2) U(1,2)], S(2,2)*[-U(2,2), U(2,2)], '--', 'linewidth', lw);
    set(sp, 'Visible', showsing)
else
    sub1 = subplot(1,2,1);
    hold on
    sp(1) = plot([-V(1,1) V(1,1)], [-V(2,1), V(2,1)], '--', 'linewidth', lw);
    set(sub1, 'ColorOrderIndex', 1)
    sp(2) = plot([-V(1,2) V(1,2)], [-V(2,2), V(2,2)], '--', 'linewidth', lw);
    axis equal
    sub2 = subplot(1,2,2);
    set(sub2, 'ColorOrderIndex', 2);
    hold on
    sp(3) = plot3(S(1,1)*[-U(1,1) U(1,1)], S(1,1)*[-U(2,1), U(2,1)], S(1,1)*[-U(3,1), U(3,1)], '--', 'linewidth', lw);
    set(sub2, 'ColorOrderIndex', 2)
    sp(4) = plot3(S(2,2)*[-U(1,2) U(1,2)], S(2,2)*[-U(2,2), U(2,2)], S(2,2)*[-U(3,2), U(3,2)], '--', 'linewidth', lw);
    axis vis3d
    set(sp, 'Visible', showsing)
end

% Circle and ellipse
if issquare
    set(gca, 'ColorOrderIndex', 1)
    circplot = plot(circle(1,:), circle(2,:), 'linewidth', lw);
    ellplot = plot(ellipse(1,:), ellipse(2,:), 'linewidth', lw);
else
    subplot(1,2,1)
    set(sub1, 'ColorOrderIndex', 1)
    plot(circle(1,:), circle(2,:), 'linewidth', lw);
    subplot(1,2,2)
    set(sub2, 'ColorOrderIndex', 2)
    plot3(ellipse(1,:), ellipse(2,:), ellipse(3,:), 'linewidth', lw);
end

% Arrows
if issquare
    if norm(circle(:,1)) > norm(ellipse(:,1))
        set(gca, 'ColorOrderIndex', 1)
        q(1) = quiver(0, 0, circle(1,1), circle(2,1), 0, 'linewidth', lw);
        set(gca, 'ColorOrderIndex', 2)
        q(2) = quiver(0, 0, ellipse(1,1), ellipse(2,1), 0, 'linewidth', lw);
    else
        set(gca, 'ColorOrderIndex', 2)
        q(2) = quiver(0, 0, ellipse(1,1), ellipse(2,1), 0, 'linewidth', lw);
        set(gca, 'ColorOrderIndex', 1)
        q(1) = quiver(0, 0, circle(1,1), circle(2,1), 0, 'linewidth', lw);
    end
else
    subplot(1,2,1)
    set(sub1, 'ColorOrderIndex', 1)
    q(1) = quiver(0, 0, circle(1,1), circle(2,1), 0, 'linewidth', lw);
    subplot(1,2,2)
    set(sub2, 'ColorOrderIndex', 2)
    q(2) = quiver3(0, 0, 0, ellipse(1,1), ellipse(2,1), ellipse(3,1), 0, 'linewidth', lw);
end

% Labels
if issquare
    xlabel x_1
    ylabel x_2
    axis image
    if animate, title('Press space to finish'); end
    legend([circplot, ellplot], 'x', 'Ax', 'Location', 'BestOutside')
%     drawlegend
else
    subplot(1,2,1)
    xlabel x_1
    ylabel x_2
    axis image
    title('x')
    subplot(1,2,2)
    axis equal
    xlabel x_1
    ylabel x_2
    zlabel x_3
    title('Ax (rotate me in 3D space!)')
    if animate, sgtitle('Press space to finish'); end
 end

i = 0;
done = ~animate;
paused = false;
while ~done
    i = mod(i, numpts) + 1;
    drawframe;
end

    function drawframe
        q(1).UData = circle(1,i);
        q(1).VData = circle(2,i);
        q(2).UData = ellipse(1,i);
        q(2).VData = ellipse(2,i);
        if ~issquare, q(2).WData = ellipse(3,i); end
        drawnow
    end

    function drawlegend
        if showeig
            if showsing
                legend([circplot, ellplot, ep(1), sp(1:2)], 'x', 'Ax', 'Eigenvector', 'Right sing vec', 'Left sing vec', 'Location', 'BestOutside')
            else
                legend([circplot, ellplot, ep(1)], 'x', 'Ax', 'Eigenvector', 'Location', 'BestOutside')
            end
        else
            if showsing
                legend([circplot, ellplot, sp(1:2)], 'x', 'Ax', 'Right sing vec', 'Left sing vec', 'Location', 'BestOutside')
            else
                legend([circplot, ellplot], 'x', 'Ax', 'Location', 'BestOutside')
            end
        end
    end


    function KeyPressed(~, event)
        switch lower(event.Character)
            case 'e'
                if issquare
                    showeig = ~showeig;
                    set(ep, 'Visible', showeig)
%                     drawlegend
                end
            case 's'
                showsing = ~showsing;
                set(sp, 'Visible', showsing)
%                 drawlegend
            case 'p'
                paused = ~paused;
            case '='
                if paused
                    i = mod(i, numpts) + 1;
                    drawframe;
                end
            case '-'
                if paused
                    i = mod(i, numpts) - 1;
                    drawframe;
                end
            case {' ', 'q'}
                if issquare, title(''), else sgtitle(''); end
                done = true; return;
            otherwise
                paused = false;
        end
        if paused, waitforbuttonpress; end
    end

end