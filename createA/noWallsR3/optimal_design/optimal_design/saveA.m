


counter = load('out/counter.txt');



parfor o = 0:(counter-1)
    saveA_(num2str(o));
end



function saveA_(k)
k = str2num(k)+1;

pixelSize = 172e-3;
numberOfPixel = [195 487];
holesCombi = [10 20];

%save('data')

% [detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel,holesCombi);

data = [];
for numberOfSources = 1:4
    for n = 1:200
        data = [data;n,numberOfSources];
    end
end

clear data
n = load('out/n.txt');
source = load('out/sources.txt');
data = [n,source];


n = data(k,1);
numberOfSources = data(k,2);


s = source_creator(x,y,z,numberOfSources);
% find activ pixel and ignore the rest
p = s>0;
x = x(p);
y = y(p);
z = z(p);


zo = unique(z)';

saveA_condor(n,zo,numberOfSources) 

end







