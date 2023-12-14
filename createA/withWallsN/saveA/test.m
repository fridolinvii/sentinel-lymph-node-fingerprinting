
clear all
close all

pixelSize = 172e-3;
numberOfPixel = [195 487];

[~,~,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);

xM = mean(x(:));
yM = mean(y(:));
zM = mean(z(:));

a = 3; r = 2;

v = ( (xM-x(:)).^2+(yM-y(:)).^2+(zM-z(:)).^2) <= 2^2;

an = load('A/An');
ao = load('A/Ao');
% a_top = load('A/A_top');
% a_low = load('A/A_low');
% a_mid = load('A/A_mid');

% p_top = reshape(a_top.A_top*v,numberOfPixel);
% p_mid = reshape(a_mid.A_mid*v,numberOfPixel);
% p_low = reshape(a_low.A_low*v,numberOfPixel);



pn = reshape(an.An*v,numberOfPixel);
po = reshape(ao.Ao*v,numberOfPixel);

figure(1)
subplot(2,1,1)
imagesc(pn)
title('pn')
subplot(2,1,2)
imagesc(po)
title('po')

% figure(2)
% subplot(3,1,1)
% imagesc(p_top)
% title('p_top')
% subplot(3,1,2)
% imagesc(p_mid)
% title('p_mid')
% subplot(3,1,3)
% imagesc(p_low)
% title('p_low')

