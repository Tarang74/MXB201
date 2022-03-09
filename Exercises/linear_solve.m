function x = linear_solve(A, b)
% Solves A*x = b for general A and b
% Tim Moroney, MXB201, 2020

[m, n] = size(A);

if m ~= size(b,1)
    error('A and b must conform.')
end

[R, ~, bv] = rref2([A b]);
r  = rank(R(:, 1:n)); % rank of A
r2 = rank(R);         % rank of [A b]

if r ~= r2
    error('No solution.')
end

x = zeros(n, size(b,2), class(A)); % start with zero vector
x(bv, :) = R(1:r, n+1:end);        % then fill in the basic variables

% For underdetermined systems, add the general homogeneous solution
if r < n
    warning('Infinitely many solutions.');
    N = null(A);
    c = sym('c', [n-r, 1]);
    x = x + N * c;
end