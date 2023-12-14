clear all
close all

parpool(4)

pixelSize = 172e-3;
numberOfPixel = [195 487];

% save('data')

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
zo = unique(z)';



data = [];



parfor n = 1:24
   tic
   saveA_condor_2(n)
   toc
end
