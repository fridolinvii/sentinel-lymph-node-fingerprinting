clear all
close all



sigmax = 1;
sigmay = 1;
sigmaz = 1;



for p = 1%1:9
A{1} = 'Ao';
A{2} = 'An';


for n = 4%0:5
    t = 2^n;

load ../saveA/pos.mat
xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));
    

for a = 1%:2
Str = ['radiantSource',A{a},'/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
load(Str)

radiantSource = reshape(radiantSource,yl,xl,zl);
[xview,yview,zview] = projection(radiantSource,x,sigmax,sigmay,sigmaz);
subplot(3,1,a)
imagesc(xview)
xlabel('z in mm')
ylabel('y in mm')
title(A{a})
subplot(3,1,a+1)
imagesc(yview)
xlabel('z in mm')
ylabel('x in mm')
subplot(3,1,a+2)
imagesc(zview')
xlabel('y in mm')
ylabel('x in mm')

end

pause(1)
end
end



