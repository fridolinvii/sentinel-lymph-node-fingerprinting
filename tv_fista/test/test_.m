

% X=double(imread('cameraman.pgm'));
% X=X/255;
% randn('seed',314);
% Bobs=X +2e-2*randn(size(X));
% 
% X_den=denoise_bound(Bobs,0.02,-Inf,Inf);
% 
% subplot(3,1,1)
% imshow(X,[]);
% subplot(3,1,2)
% imshow(Bobs,[]);
% subplot(3,1,3)
% imshow(X_den,[])

clear all

load('test')
i = 5;
test_den = denoise_bound(test,i,0,50);

subplot(3,1,1)
imagesc(test)
subplot(3,1,2)
imagesc(test_den)

test_den_cut = test_den.*(test_den>(0.6*max(test_den(:))));

subplot(3,1,3)
imagesc(test_den_cut)

pause(1)
