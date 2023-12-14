function s = source_creator_pattern(x,y,z,pattern)


 [position,strenght] = find_pattern(pattern);







s = 0;

for n = 1:length(strenght)

    
    xr = position(n,1);
    yr = position(n,2);
    zr = position(n,3);
    
    %sM = (bsxfun(@minus,x,xU(pos)).^2+bsxfun(@minus,y,yU(pos)).^2+(bsxfun(@minus,z,zU(pos)).^2))<= r^2;
    sM = (bsxfun(@minus,x,x(xr)).^2+bsxfun(@minus,y,y(yr)).^2+(bsxfun(@minus,z,z(zr)).^2))<= 2.5^2;
    s = s+sM;
    
    %possible = (possible.*(sM==0))>0;
    
    
    
end





