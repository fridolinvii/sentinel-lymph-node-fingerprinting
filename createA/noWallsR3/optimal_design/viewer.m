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

radiantSource = radiantSource(:).*(z(:)/min(z(:))).^2;
radiantSource = imgaussfilt(reshape(radiantSource,yl,xl,zl),1);

volvisApp(x,y,z,radiantSource)