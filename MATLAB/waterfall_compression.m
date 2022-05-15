%% Read image
clear
I = imread('waterfall_colour.jpg');
I = I(1:4:end, 1:4:end, :);  % downsample to keep things manageable
I = double(I) / 255;
[rows, cols, channels] = size(I);
tol = 0.01;

%%
colours = 'rgb';
figure, tiledlayout(2,2), nexttile, hold on
set(gca, 'YScale', 'log')
grid on
for c = 1:3
    [U{c}, Sigma{c}, V{c}] = svd(I(:,:,c), 'econ');
    sigma{c} = diag(Sigma{c});
    nu(c) = find(sigma{c} / sigma{c}(1) < tol, 1, 'first');
    plot(sigma{c}/sigma{c}(1), colours(c))
end
title("RGB: " + num2str(nu))

%%
H = rgb2hsv(I);
nexttile, hold on
set(gca, 'YScale', 'log')
grid on
for c = 1:3
    [U{c}, Sigma{c}, V{c}] = svd(H(:,:,c), 'econ');
    sigma{c} = diag(Sigma{c});
    nu(c) = find(sigma{c} / sigma{c}(1) < tol, 1, 'first');
    plot(sigma{c}/sigma{c}(1))
end
title("HSV: " + num2str(nu))

%%
Stacked = [I(:,:,1); I(:,:,2); I(:,:,3)];

[U,Sigma,V] = svd(Stacked);
sigma = diag(Sigma);
nu = find(sigma/sigma(1) < tol, 1, 'first');
nexttile, semilogy(sigma), grid on
title("RGB stacked: " + num2str(nu))

% Reconstruct 
Stacked_nu = U(:, 1:nu) * Sigma(1:nu, 1:nu) * V(:, 1:nu)';
I_nu(:,:,1) = Stacked_nu(1:rows, :);
I_nu(:,:,2) = Stacked_nu(rows+1:2*rows, :);
I_nu(:,:,3) = Stacked_nu(2*rows+1:3*rows, :);

%%
SHtacked = [H(:,:,1); H(:,:,2); H(:,:,3)];

[U,Sigma,V] = svd(SHtacked);
sigma = diag(Sigma);
nu = find(sigma/sigma(1) < tol, 1, 'first');
nexttile, semilogy(sigma), grid on
title("HSV stacked: " + num2str(nu))

%%
figure, montage({I, I_nu})
title('Before and after reconstruction using stacked RGB');