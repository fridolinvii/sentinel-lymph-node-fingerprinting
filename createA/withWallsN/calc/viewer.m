clear all
close all

%% show source %% 
p = 6;
t = 16;
A = 'Ao';

Str = ['radiantSource',A,'/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
load(Str)


load ../saveA/pos.mat


cut = ((y>5).*(y<78))>0;
radiantSource = radiantSource(cut(:));
[x,y,z] = meshgrid(unique(x(cut)),unique(y(cut)),unique(z(cut)));


xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));





sigma = .0;
radiantSource = radiantSource.*(z(:)/max(z(:))).^2;
radiantSource = imgaussfilt(reshape(radiantSource,yl,xl,zl),2);
radiantSource = radiantSource.*(radiantSource>(sigma*max(radiantSource(:))));
 r = max(radiantSource(:)); 
 r1 = ((x(:)-21).^2+(y(:)-41).^2+(z(:)-130).^2)<2.5^2;
 r1 = r1*r;
% r2 = ((x(:)-23).^2+(y(:)-41.5).^2+(z(:)-130).^2)<2.5^2;
% r2 = r2*r;


 radiantSource = r1;

radiantSource = reshape(radiantSource,yl,xl,zl);
%radiantSource = imgaussfilt(radiantSource,2);


volvisApp(x,y,z,radiantSource)



p = find(radiantSource == max(radiantSource(:)));
disp([x(p),y(p),z(p)])



