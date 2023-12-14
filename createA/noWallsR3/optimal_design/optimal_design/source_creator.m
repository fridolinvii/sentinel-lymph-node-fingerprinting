function s = source_creator(x,y,z,numberOfSources)

strength = 10;
r = 5;


s = 0;
%% one source %%
if numberOfSources == 1
    
    xM = mean(x(:));
    yM = mean(y(:));
    zM = 100;
    sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
    s = s+sM(:);
    
else
    
    if numberOfSources == 2
        
        xM = quantile(x(:),0.5);
        yM = quantile(y(:),1/3);
        zM = 110;
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        xM = quantile(x(:),1/2);
        yM = quantile(y(:),2/3);
        zM = 110;
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        
    elseif numberOfSources == 3
        
        xM = quantile(x(:),0.5);
        yM = quantile(y(:),1/3);
        zM = 110;
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        xM = quantile(x(:),1/3);
        yM = quantile(y(:),1/2);
        zM = 110;
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        xM = quantile(x(:),2/3);
        yM = quantile(y(:),2/3);
        zM = 110;
        
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
    elseif numberOfSources == 4
        xM = mean(x(:));
        yM = mean(y(:));
        zM = 100;
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
        
        xM = mean(x(:));
        yM = mean(y(:));
        zM = 120;
        sM = strength.*( (bsxfun(@minus,x,xM).^2+bsxfun(@minus,y,yM).^2+(bsxfun(@minus,z,zM).^2))<= r.^2);
        s = s+sM(:);
    end
    
    
    
    
    
    
end