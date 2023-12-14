function [detectorX,detectorY,holesXY,x,y,z,activity] = saveDetector(pixelSize,numberOfPixel)


%% set constant %%
holesZ        = [0,-1];
height        = 36;


%% detector %%

[detectorY,detectorX] = meshgrid(0:pixelSize:pixelSize*(numberOfPixel(2)-1),0:pixelSize:pixelSize*(numberOfPixel(1)-1));
detectorX = detectorX + pixelSize;
detectorY = detectorY + pixelSize;


%% holesXY %%

holesX = -1.24+4*pixelSize+[9.5;3.7;5.8;4.3;6.4;5.5;7.6;6;19.1;14;17;17.6;17.1;14;16.6;16.5;26.6;27.7;27;24.3;31.7;28.8;29.7;30.1];
holesY = 9*pixelSize+[4.4;13.2;25.2;37;49;57.5;69.4;79.3;9.5;17.9;23.9;34.4;47.3;59.7;68.1;78.9;2.9;15.2;30.1;38.4;47.5;57.6;71.1;80.3];

holesXY = [holesX,holesY];


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
activity = [];
% for 




save('pos','x','y','z','activity')
save('holesXY','holesXY')

