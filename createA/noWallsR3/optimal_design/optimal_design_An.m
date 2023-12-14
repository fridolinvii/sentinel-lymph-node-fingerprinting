function [weight,A] = optimal_design(radiantSource,cut,pattern,weightedA)
% input: possible positon of radiantSource

pixelSize = 172e-3;
numberOfPixel = [195 487];



[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);

radiantSource = imgaussfilt(reshape(radiantSource,size(x)),1);
radiantSource = radiantSource > (0.25*max(radiantSource(:)));

% find activ pixel and ignore the rest
p = radiantSource>0;


A = 0;
a = 0;
if weightedA == 1
    for k = 1:length(holesXY)
        dis = ['create weighted optimal design Matrix: ', num2str(k) ' of ' , num2str(length(holesXY))];
        disp(dis)
        
        %% create weighted A%%
        Str = ['../saveA/A/An/A_',num2str(k)];
        load(Str)
        if a == 0
            a = 1;
            A = sparse(Ao*0);
        end
        
        load(['weight/pattern_',num2str(pattern)])
        w = w(:,end);
        
        
        A = sparse(A+w(k)*Ao);
    end
    
    weight = w;
    
else
    
    
    %% create Matrix K for optimal design %%
    
    K = []; Wh = [];
    tic
    for k = 1:length(holesXY)
        dis = ['create optimal design Matrix: ', num2str(k) ' of ' , num2str(length(holesXY))];
        disp(dis)
        
        %% create K %%
        Str = ['../saveA/A/An/A_',num2str(k)];
        load(Str)
        K = sparse([K;Ao(cut(:),p)]);
        
        %% create weight matrix W %%
        sizeA = size(Ao(cut(:),p));
        oh = (k-1)*sizeA(1)+1:k*sizeA(1);
        W = zeros(sizeA(1)*length(holesXY),1);
        W(oh) = 1;
        Wh = sparse([Wh,W]);
    end
    toc
    
    
    
    %% create weight for optimal design %%
    
    
    tic
    weight = weighter(K,Wh,pattern);
    A = 0;
    toc
    
end