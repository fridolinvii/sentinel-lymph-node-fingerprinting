clear all
close all

%% show source %% 
rot = 0;
dist = 10;
t = 16;
A = 'Ao';

sigma = .0;

Str = ['radiantSource',A,'/special_experiment/rot_',num2str(rot),'/dist_',num2str(dist),'/radiantSource_expt_',num2str(t)];
load(Str)


load ../saveA/pos.mat


% cut = ((y>5).*(y<78))>0;
% radiantSource = radiantSource(cut(:));
% [x,y,z] = meshgrid(unique(x(cut)),unique(y(cut)),unique(z(cut)));



xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));






radiantSource = radiantSource.*(z(:)/min(z(:))).^2;
radiantSource = imgaussfilt(reshape(radiantSource,yl,xl,zl),2);

radiantSource = radiantSource.*(radiantSource>(sigma*max(radiantSource(:))));

radiantSource = reshape(radiantSource,yl,xl,zl);
radiantSource = imgaussfilt(radiantSource,2);

volvisApp(x,y,z,radiantSource)






