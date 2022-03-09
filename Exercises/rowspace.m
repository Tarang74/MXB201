function B = rowspace(A)
%ROWSPACE Basis for row space.
%   The rows of B = ROWSPACE(A) form a basis for the row space of A.
%   SIZE(B,2) is the rank of A.
%
%   Example:
%
%     rowspace(sym(magic(4))) is
%
%     [ 1, 0,  0]
%     [ 0, 1,  0]
%     [ 0, 0,  1]
%     [ 1, 3, -3]
%
%   See also SYM/NULL.

%   Copyright 2011 The MathWorks, Inc.

A_ = A';

if isempty(A) 
    B = sym([]);
elseif any(reshape(~isfinite(A_),[],1))
    error(message('symbolic:sym:InputMustNotContainNaNOrInf')); 
else 
    B = privUnaryOp(A_, 'symobj::colspace');
end
