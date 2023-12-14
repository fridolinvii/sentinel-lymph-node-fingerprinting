% clear all; close all


load pos
%load Ao


load o;

 pos = zeros(35700,4);
%pos = zeros(numel(x),4);

xl = 1:2:max(x(:)); zl = 1:2:100; yl = 1:2:max(y(:));
[xn,yn,zn] = meshgrid(xl,yl,zl);

%Ao = Ao(:,o(:));
f = 1:numel(xn);
% o = zeros(size(x));
l = 0; countx = 0; county=-1; countz=-1;
for x_ = xl
countx = 1+countx;
    for y_ = yl
county = 1+mod(county+1,length(yl));
        for  z_ = zl
countz = 1+mod(countz+1,length(zl));
            s = zeros(size(xn));
            l = l+1;
            s(county,countx,countz) = 1;
            
            
            
            pos(l,:) = [x_,y_,z_+80,f(s>0)];
            
            
            
%             o(y_,x_,z_) = 1;

             disp([l,35700])
%disp([l,numel(x)])
        end
    end
end

% d = Ao(:,o)*sp;

% d = sparse(d);
 save('d','pos')
%save('o','o')
