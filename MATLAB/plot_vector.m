function plot_vector(O, U, ls, annotation)

quiver(O(1), O(2), U(1), U(2), ls, 'LineWidth', 2, 'AutoScale', 'off')

axis equal
grid on

if nargin == 4
    axlim = axis; axdist = diff(axlim(1:2));
    normal = [-U(2); U(1)]; normal = normal / norm(normal);
    midpoint = O(:) + U(:)/2;
    location = midpoint + normal * axdist*0.05;
    text(location(1), location(2), annotation, 'FontSize', 16, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')
end