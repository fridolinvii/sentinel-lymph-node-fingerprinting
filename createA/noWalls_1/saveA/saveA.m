function saveA(k)
k = str2num(k)+1;

pixelSize = 172e-3;
numberOfPixel = [195 487];

%save('data')

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
zo = unique(z)';


hol = load('/nfs/server/condor/users/miac/carlo/noWalls_1/saveA/out/numberOfHoles.txt');
zll = load('/nfs/server/condor/users/miac/carlo/noWalls_1/saveA/out/zl.txt');


data =[hol,zll];

%data = [];

%for n = 1:24
 %  for zl = 81:180
%	 data = [data;n,zl];
 %   end
%end





    tic 
    saveA_condor(data(k,1),data(k,2))
    toc

end
