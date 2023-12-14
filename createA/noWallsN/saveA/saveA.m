function saveA(k)
k = str2num(k)+1;

pixelSize = 172e-3;
numberOfPixel = [195 487];

%save('data')

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
zo = unique(z)';



data = [];

for n = 1:24
   for zl = zo
        data = [data;n,zl];
    end
end





    tic 
    saveA_condor(data(k,1),data(k,2))
    toc

end
