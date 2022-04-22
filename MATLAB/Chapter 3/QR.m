function [Q,R] = QR(A)
% Computes the QR decomposition for a matrix with full column rank using
% the Gram-Schmidt process.
% Tim Moroney, MXB201, 2021

[m,n] = size(A);

if rank(A) < n
    error('A must have full column rank.');
end

Q = zeros([m,n], class(A));
R = zeros([n,n], class(A));

% The Gram-Schmidt process
for j = 1:n
    R(1:j-1, j) = Q(:, 1:j-1)' * A(:, j);    % record the dot products
    v = A(:, j) - Q(:, 1:j-1) * R(1:j-1, j); % subtract the projections
    R(j, j) = norm(v);                       % record the norm
    Q(:, j) = v / R(j, j);                   % normalise
end