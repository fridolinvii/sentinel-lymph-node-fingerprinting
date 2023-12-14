clear all
close all

%% show source %%
p = 1;
t = 16;
A = 'Ao';

Str = ['radiantSource',A,'/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
load(Str)

pixelSize = 172e-3;
numberOfPixel = [195 487];
[~,~,~,x,y,z] = saveDetector(pixelSize,numberOfPixel);

xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));


% radiantSource = pattern(p,x,y,z);



radiantSource = imgaussfilt(reshape(radiantSource,yl,xl,zl),1);

volvisApp(x,y,z,radiantSource)



function radiantSource = pattern(p,x,y,z)

xM = 21;
yM = 41;
zM = 130;
r = 2.5;
switch p
    case 1
        radiantSource = 6*( ((xM-x).^2+(yM-y).^2+(zM-z).^2) < r);
    case 2
        r1 = 6*( ((xM-x).^2+(yM-y).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x).^2+(yM-y).^2+(zM-z-20).^2) < r);
        radiantSource = r1+r2;
    case 3
        r1 = 6*( ((xM-x).^2+(yM-y).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x).^2+(yM-y).^2+(zM-z+20).^2) < r);
        radiantSource = r1+r2;
    case 4
        r1 = 6*( ((xM-x).^2+(yM-y).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x+5).^2+(yM-y).^2+(zM-z).^2) < r);
        radiantSource = r1+r2;
    case 5
        r1 = 6*( ((xM-x).^2+(yM-y).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x-5).^2+(yM-y+20).^2+(zM-z+20).^2) < r);
        radiantSource = r1+r2;
        
    case 6
        r1 = 6*( ((xM-x).^2+(yM-y).^2+(zM-z-20).^2) < r);
        r2 = 3*( ((xM-x).^2+(yM-y).^2+(zM-z+20).^2) < r);
        radiantSource = r1+r2;
    case 7
        r1 = 6*( ((xM-x+5).^2+(yM-y+20).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x-5).^2+(yM-y-20).^2+(zM-z).^2) < r);
        radiantSource = r1+r2;
        
    case 8
        r1 = 6*( ((xM-x).^2+(yM-y).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x-5).^2+(yM-y-20).^2+(zM-z+20).^2) < r);
        r3 = 1.5*( ((xM-x+5).^2+(yM-y+20).^2+(zM-z).^2) < r);
        radiantSource = r1+r2+r3;
    
    case 9
        r1 = 6*( ((xM-x+5).^2+(yM-y+20).^2+(zM-z).^2) < r);
        r2 = 3*( ((xM-x).^2+(yM-y).^2+(zM-z+20).^2) < r);
        r3 = 1.5*( ((xM-x-5).^2+(yM-y+20).^2+(zM-z+20).^2) < r);
        radiantSource = r1+r2+r3;
        
        
        
        
end



end