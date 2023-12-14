function [detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel)


%% set constant %%
holesZ        = [0,-1];
height        = 36;


%% detector %%

[detectorY,detectorX] = meshgrid(0:pixelSize:pixelSize*(numberOfPixel(2)-1),0:pixelSize:pixelSize*(numberOfPixel(1)-1));
detectorX = detectorX + pixelSize;
detectorY = detectorY + pixelSize;


%% holesXY %%

%load('calibN')
load /nfs/server/condor/users/miac/carlo/experiment_13.07.17/_collimator_withWalls_N_new2/saveA/calibN
mx = (cordX(2)-cordX(1))/2;
my = (cordY(2)-cordY(1))/7;

dx = cordX(1):mx:cordX(2);
dy = cordY(1):my:cordY(2);






[holesX,holesY] = meshgrid(dx,dy);
holesXY = [holesX(:),holesY(:)].*pixelSize;
holesXY = [4*pixelSize-1.25,9*pixelSize]+holesXY;



% holesXY = [mean(detectorX(:)),mean(detectorY(:));mean(detectorX(:)),mean(detectorY(:))];

% holesXY = [mean(detectorX(:)),mean(detectorY(:))];


%% create pos %%
[x,y,z] = meshgrid(0:numberOfPixel(1)*pixelSize,0:numberOfPixel(2)*pixelSize,81:180);%250);
% [x,y,z] = meshgrid(10:20,35:45,110:120);




%% if walls are needed we need activity for each compartment.
% first we try if the walls are infinitif small
% mx = 3; my = 8;
% ax = []; ay = [];
% for ddx = 1:mx
%     ax = [ax,quantile(detectorX(:),ddx/(mx))];
% end
% for ddy = 1:my
%     ay = [ay,quantile(detectorY(:),ddy/(my))];
% end
% 
% [activityX,activityY] = meshgrid(ax,ay);
% activityXY = [activityX(:),activityY(:)];
% 
% activityTest = ones(size(detectorX));
% for 




save('pos','x','y','z','activity')
save('holesXY','holesXY')

