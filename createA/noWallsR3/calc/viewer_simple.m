clear all
%close all

pixelSize = 172e-3;
numberOfPixel = [195 487];
[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);

sigmax = 1;
sigmay = 1;
sigmaz = 1;



for p = 7
A{1} = 'Ao';
A{2} = 'An';


for n = 3%0:5
    t = 2^n;


xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));
    

for a = 1%:2
Str = ['radiantSource',A{a},'/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
load(Str)

radiantSource = reshape(radiantSource(:),yl,xl,zl);
[xview,yview,zview] = projection(radiantSource,x,sigmax,sigmay,sigmaz);
subplot(3,1,a)
imagesc(xview)
xlabel('z')
ylabel('y')
title([A{a},'_',num2str(p)])
subplot(3,1,a+1)
imagesc(yview)
xlabel('z')
ylabel('x')
subplot(3,1,a+2)
imagesc(zview')
xlabel('y')
ylabel('x')

end

pause(1)
end
pause
end