function p = trig_interp(f, n)
% Returns the degree n trigonometric polynomial interpolant to function f
% Tim Moroney, MXB201, 2021

N = 2*n+1;
tvec = linspace(0, 2*pi, N+1);
tvec = tvec(1:end-1)'; % don't double-count 0 as 2*pi

A = [cos((0:n).*tvec) sin((1:n).*tvec)];
b = f(tvec);
c = A \ b;

% Return symbolic answer with numerical coefficients
syms t real;
p = vpa([cos((0:n)*t) sin((1:n)*t)] * c, 16);