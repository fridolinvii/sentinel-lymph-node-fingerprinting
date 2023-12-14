clear all
close all



sigmax = 1;
sigmay = 1;
sigmaz = 1;



p = 1;
A{1} = 'Ao';
A{2} = 'An';


for n = 0:5
    t = 2^n;

load ../saveA/pos.mat
xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));
    

for a = 1:2
Str = ['radiantSource',A{a},'/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
load(Str)

radiantSource = reshape(radiantSource,yl,xl,zl);
[xview,yview,zview] = projection(radiantSource,x,sigmax,sigmay,sigmaz);
subplot(3,2,a)
imagesc(xview)
xlabel('z')
ylabel('y')
title(A{a})
subplot(3,2,a+2)
imagesc(yview)
xlabel('z')
ylabel('x')
subplot(3,2,a+4)
imagesc(zview)
xlabel('y')
ylabel('x')

end

pause(1)
end