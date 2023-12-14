clear all
close all

parpool(4)

pixelSize = 172e-3;
numberOfPixel = [195 487];

% save('data')

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
zo = unique(z)';



data = [];

o = [1:3 5:6 9:11 13:14 16:24];

parfor n=1:24%n1 = length(o)
  % n = o(n1); 
   tic
   saveA_condor_2(n)
   toc
end
