function weight = optimal_design(radiantSource)
% input: possible positon of radiantSource

pixelSize = 172e-3;
numberOfPixel = [195 487];

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);

% find activ pixel and ignore the rest
p = radiantSource>0;

%% create Matrix K for optimal design %%

