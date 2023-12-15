function [s,r,xM_,yM_,zM_] = source_creator(x,y,z,numberOfSources)

strength = 10;
r = 2.5;

xM_ = []; yM_ = []; zM_ = [];
s = 0;
%% one source %%
if numberOfSources == 1
    
    xM = mean(x(:));
    yM = mean(y(:));
    zM = 100;
    sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
    s = s+sM(:);
    
    xM_ = [xM_,xM]; yM_ = [yM_,yM]; zM_ = [zM_,zM];
    
    
else
    
    
    xM = quantile(x(:),0.75);
    yM = quantile(y(:),0.75);
    zM = 90;
    xM_ = [xM_,xM]; yM_ = [yM_,yM]; zM_ = [zM_,zM];
    
    sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
    s = s+sM(:);
    
    
    
    
    xM = quantile(x(:),0.25);
    yM = quantile(y(:),0.25);
    zM = 120;
    xM_ = [xM_,xM]; yM_ = [yM_,yM]; zM_ = [zM_,zM];
    
    sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
    s = s+sM(:);
 
    if numberOfSources == 3
        
        xM = mean(x(:));
        yM = mean(y(:));
        zM = 100;
        xM_ = [xM_,xM]; yM_ = [yM_,yM]; zM_ = [zM_,zM];
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
    elseif numberOfSources == 4
        
        
        xM = quantile(x(:),0.75);
        yM = quantile(y(:),0.25);
        zM = 100;
        xM_ = [xM_,xM]; yM_ = [yM_,yM]; zM_ = [zM_,zM];
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        xM = quantile(x(:),0.25);
        yM = quantile(y(:),0.75);
        zM = 110;
        xM_ = [xM_,xM]; yM_ = [yM_,yM]; zM_ = [zM_,zM];
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        
    end
    
end



end


