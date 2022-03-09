function [R, E, bv] = rref2(A)
%RREF2   Reduced row echelon form with elimination matrix returned.
%   [R, E] = RREF2(A) is as for RREF except the product of the
%   elementary matrices used to row reduce A is returned as E.
%   n.b. if A is invertible, E is inv(A).
%   [R, E, bv] = RREF2(A) also returns the indices of the basic variables.

[m,n] = size(A);

A_I = [A eye(m,m)];     % augment A with the identity matrix
R_E = rref(A_I);        % row reduce the augmented matrix
R = R_E(:, 1:n);        % extract the reduced row echeclon form
E = R_E(:, n+1:end);    % extract the elimination matrix

% Identify basic variables if requested
if nargout == 3
    bv = [];
    piv = 1; j = 1;
    while j <= n && piv <= m
        if R(piv, j) == 1
            bv(end+1) = j;  %#ok<AGROW>
            piv = piv + 1;
        end
        j = j + 1;
    end
end