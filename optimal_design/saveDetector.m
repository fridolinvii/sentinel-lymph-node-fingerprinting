function [detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel,holesCombi)


%% set constant %%
holesZ        = [0,-1];
height        = 36;

numberOfHolesPerLengthX = holesCombi(1);
numberOfHolesPerLengthY = holesCombi(2);

%% detector %% 

[detectorY,detectorX] = meshgrid(0:pixelSize:pixelSize*(numberOfPixel(2)-1),0:pixelSize:pixelSize*(numberOfPixel(1)-1));
detectorX = detectorX + pixelSize;
detectorY = detectorY + pixelSize;


%% holesXY %% 

lx = numberOfPixel(1)*pixelSize/(numberOfHolesPerLengthX+1);
lx = (1:numberOfHolesPerLengthX)*lx;
ly = numberOfPixel(2)*pixelSize/(numberOfHolesPerLengthY+1);
ly = (1:numberOfHolesPerLengthY)*ly;


[holesX,holesY] = meshgrid(lx,ly);

holesXY(:,1) = holesX(:);
holesXY(:,2) = holesY(:);


%% create pos %%
[x,y,z] = meshgrid(0:numberOfPixel(1)*pixelSize,0:numberOfPixel(2)*pixelSize,81:250);
% save('pos','x','y','z')
% save('holesXY','holesXY')

