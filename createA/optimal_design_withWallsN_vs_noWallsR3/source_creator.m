function s = source_creator(x,y,z,numberOfSources)



% r = 2;
xM = mean(x(:)); xR = length(unique(x(:)))/2;
yM = mean(y(:)); yR = length(unique(y(:)))/2;
zM = mean(z(:)); zR = length(unique(z(:)))/2;
%
% possible = (
% ((xM-x).^2<(xR-r)^2).*((yM-y).^2<(yR-r)^2).*((zM-z).^2<(zR-r)^2)   )>0;
r = 2.5;
possible = (   ((xM-x).^2./(xR-r)^2)+((yM-y).^2./(yR-r)^2)+((zM-z).^2./(zR-r)^2)   )<=1;








s = 0;

for n = 1:numberOfSources
    xU =x(possible(:));
    yU =y(possible(:));
    zU =z(possible(:));
    
    xr = randi([1,numel(x)]);
    yr = randi([1,numel(x)]);
    zr = randi([1,numel(x)]);
    
    pos = randi([1,sum(possible(:))]);
    %sM = (bsxfun(@minus,x,xU(pos)).^2+bsxfun(@minus,y,yU(pos)).^2+(bsxfun(@minus,z,zU(pos)).^2))<= r^2;
    sM = (bsxfun(@minus,x,x(xr)).^2+bsxfun(@minus,y,y(yr)).^2+(bsxfun(@minus,z,z(zr)).^2))<= (1+rand(1)*3)^2;
    s = s+sM;
    
    %possible = (possible.*(sM==0))>0;
    
    
    
end





