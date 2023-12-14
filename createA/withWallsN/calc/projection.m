function [xview,yview,zview] = projection(radiantSource,x,sigmax,sigmay,sigmaz)
a = radiantSource;
siz = size(x);
zview = zeros(siz(1),siz(2));
yview = zeros(siz(1),siz(3));
xview = zeros(siz(2),siz(3));
for k = 1:siz(3)
    z1 =  a(:,:,k);
    zview = zview + z1;
    for l = 1:siz(2)
        y1 = a(:,l,k);
        yview(:,k) = yview(:,k)+y1;
    end
    for l = 1:siz(1)
        x1 = a(l,:,k)';
        xview(:,k) = xview(:,k)+x1;
    end
end

%% filter %%
xview = imgaussfilt(xview,sigmax);
yview = imgaussfilt(yview,sigmay);
zview = imgaussfilt(zview,sigmaz);




end