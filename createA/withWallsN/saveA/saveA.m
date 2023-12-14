% clear all
% close all
% 
% parpool(14)
% counter = load('out/counter.txt');
% 
% parfor k = 0:(counter-1)
%     saveA_(num2str(k))
% end







function saveA(k)




pixelSize = 172e-3;
numberOfPixel = [195 487];

% save('data')

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
zo = unique(z)';



data = [];

for n = 1:24
    for zl = zo
        
        %tic
%         saveA_condor(n,zl)
        %toc
        data = [data;n,zl];
    end
end



k = str2num(k)+1;

 n = load('/nfs/server/condor/users/miac/carlo/experiment_13.07.17/_collimator_withWalls_N_new2/saveA/out/numberOfHoles.txt');
 zl = load('/nfs/server/condor/users/miac/carlo/experiment_13.07.17/_collimator_withWalls_N_new2/saveA/out/zl.txt');
% 
 saveA_condor(n(k),zl(k))

%saveA_condor(data(k,1),data(k,2))
end


% parfor k = 1:length(data(:,1))
%    tic
%    saveA_condor(data(k,1),data(k,2))
%    toc
% end
