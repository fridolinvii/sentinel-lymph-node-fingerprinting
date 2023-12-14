close all
clear  all






sigmax = 2;
sigmay = 2;
sigmaz = 1;

sigma = 1;
v = [0,0,1];




load ../saveA/pos
siz = size(x);


alpha = .3;

t = 16;
position = [1,3,6,5];



for c = 1:4
    
    pos =  position(c);
    
    %% load radiantSource %%
    location = ['radiantSourceAo/pattern_',num2str(pos),'/radiantSource_expt_',num2str(t)];
    load(location)
    
    
    %% weight %%
    if sum(radiantSource(:))>0
        radiantSource =(z(:)./max(z(:))).^2.*(radiantSource(:));%./max(radiantSource(:)));
    end
    %% imgaussfilt %%
    radiantSource = reshape(radiantSource, siz);
    %radiantSource = imgaussfilt(radiantSource,sigma);
    
    
    
    
    
    %% projection %%
    
    [xview,yview,zview] = projection(radiantSource,x,sigmax,sigmay,sigmaz);
    
    
    mx = max(xview(:));
    my = max(yview(:));
    mz = max(zview(:));
    
    
    
    %% plot position of radiant Source %%
    dist = 20;
    x_ = 21;
    y_ = mean(y(:));
    z_ = 130;
    
    %% plot projection %%
    figure(1)
    
    l = 10^-13;
    xu = unique(x);
    yu = unique(y);
    zu = unique(z);
    
    
    subplot(3,4,c+4)
    surf(xu,zu,xview','EdgeColor','none','LineStyle','none','FaceLighting','phong')
    axis([-3,83,78,185,0,mx+l])
    xlabel('x [mm]')
    ylabel('z [mm]')
    view(v)
    
    subplot(3,4,c)
    surf(yu,zu,yview','EdgeColor','none','LineStyle','none','FaceLighting','phong')
    axis([-3,83,78,185,0,my+l])
    xlabel('y [mm]')
    ylabel('z [mm]')
    view(v)
    
    subplot(3,4,c+8)
    surf(yu,xu,zview','EdgeColor','none','LineStyle','none','FaceLighting','phong')
    axis([-3,83,-2,155,0,mz+l])
    xlabel('y [mm]')
    ylabel('x [mm]')
    view(v)
    
    %% plot gaussian mixer %%
    
    
    %% gaussian mixer %%
    
    
    
    [x_xz,z_xz] = meshgrid(zu,xu);
    [y_yz,z_yz] = meshgrid(zu,yu);
    [x_xy,y_xy] = meshgrid(xu,yu);
    
    xview = xview.*(xview>alpha*max(xview(:)));
    xview(:,1:10) = 0;
    yview = yview.*(yview>alpha*max(yview(:)));
    zview = zview.*(zview>alpha*max(zview(:)));
    p_xz = xview~= 0;
    p_yz = yview~= 0;
    p_xy = zview~= 0;
    
    
    if sum(p_xz(:)) > 3
        
        
        XZ = [x_xz(p_xz),z_xz(p_xz)];
        YZ = [y_yz(p_yz),z_yz(p_yz)];
        XY = [x_xy(p_xy),y_xy(p_xy)];
        
        
        switch pos
            case 1
                ksiz = 1;
                ksiz_ = 1;
            case 5
                ksiz = 2;
                ksiz_ = 2;
            case {2,3,6}
                ksiz = 2;
                ksiz_ = 1;
        end
        
        
        
        k_xz = kmeans(XZ,ksiz);
        k_yz = kmeans(YZ,ksiz);
        k_xy = kmeans(XY,ksiz_);
        
        g_xz = [];
        g_yz = [];
        g_xy = [];
        for km = 1:ksiz
            rng(1);
            GM_xz = fitgmdist(XZ(k_xz==km,:),1,'RegularizationValue',0.1);
            rng(1);
            GM_yz = fitgmdist(YZ(k_yz==km,:),1,'RegularizationValue',0.1);
            g_xz = [g_xz;GM_xz.mu];
            g_yz = [g_yz;GM_yz.mu];
            rng(1);
        end
        for km = 1:ksiz_
            GM_xy = fitgmdist(XY(k_xy==km,:),1,'RegularizationValue',0.1);
            
            
            g_xy = [g_xy;GM_xy.mu];
        end
        
        
        
        
        
        subplot(3,4,c+4)
        hold on
        plot3(g_xz(:,2),g_xz(:,1),mx*(g_xz(:,1)~=0)+l,'r^')
        view(v)
        hold off
        
        subplot(3,4,c)
        hold on
        plot3(g_yz(:,2),g_yz(:,1),my*(g_yz(:,1)~=0)+l,'r^')
        view(v)
        hold off
        
        subplot(3,4,c+8)
        hold on
        plot3(g_xy(:,2),g_xy(:,1),mz*(g_xy(:,1)~=0)+l,'r^')
        view(v)
        hold off
        
            

        if pos == 5 || pos == 1
            calc{c}.xy = [g_xy(:,1),g_xy(:,2)];
            calc{c}.xz = [g_xz(:,2),g_xz(:,1)];
            calc{c}.yz = [g_yz(:,2),g_yz(:,1)];
        elseif pos == 3 || pos == 2 || pos == 6
            calc{c}.xy = [g_xy(:,1),g_xy(:,2); g_xy(:,1),g_xy(:,2)];
            calc{c}.xz = [g_xz(2,2),g_xz(2,1);g_xz(1,2),g_xz(1,1)];
            calc{c}.yz = [g_yz(:,2),g_yz(:,1)];
        end
        
        %% plot position of radiant Source %%
        % show position
        
        subplot(3,4,c+4)
        hold on
        if pos == 1 || pos == 2 || pos ==  3 || pos == 4 || pos == 5 || pos ==  8
            plot3(x_,z_,max(xview(:)),'co')
        end
        if pos == 2 || pos ==  6
            plot3(x_,z_+dist,max(xview(:)),'co')
        end
        if pos == 3 || pos == 6
            plot3(x_,z_-dist,max(xview(:)),'co')
        end
        if pos == 5
            plot3(x_+5,z_-dist,max(xview(:)),'co')
        end
        grid off
        hold off
        
        subplot(3,4,c)
        hold on
        if pos == 1 || pos == 2 || pos ==  3 || pos == 4 || pos == 5 || pos ==  8
            plot3(y_,z_,max(yview(:)),'co')
        end
        if pos == 2 || pos ==  6
            plot3(y_,z_+dist,max(yview(:)),'co')
        end
        if pos == 3 || pos == 6
            plot3(y_,z_-dist,max(yview(:)),'co')
        end
        if pos == 5
            plot3(y_-20,z_-dist,max(yview(:)),'co')
        end
        grid off
        hold off
        
        
        subplot(3,4,c+8)
        hold on
        
        if pos == 5
            plot3(y_,x_,max(zview(:))+l,'co')
            plot3(y_-dist,x_+5,max(zview(:))+l,'co')
        else
            plot3(y_,x_,max(zview(:)),'co')
        end
        grid off
        view(v)
        hold off
        
        
        
    end
    

end





%% calculate L2-error %%
exact{1} = [x_,y_,z_];
exact{2} = [x_,y_,z_-dist; x_,y_,z_];
exact{3} = [x_,y_,z_-dist; x_,y_,z_+dist];
exact{4} = [x_,y_,z_; x_+5,y_-dist,z_-dist];

error = [];
error_rel = [];
for c = 1:4
    
    xc = (calc{c}.xz(:,1)+calc{c}.xy(:,1))/2;
    yc = (calc{c}.yz(:,1)+calc{c}.xy(:,2))/2;
    zc = (calc{c}.yz(:,2)+calc{c}.xz(:,2))/2;
    
    
    disp( exact{c}); disp([xc,yc,zc]);
    
    err = 0;
    err_r = [];
    for n = 1:length(xc)
        err = err + norm(exact{c}(n,:)-[xc(n),yc(n),zc(n)]);
        err_r = [err_r,norm(exact{c}(n,:)-[xc(n),yc(n),zc(n)])/norm(exact{c}(n,:))*100];
    end
    error = [error;err];
    error_rel = [error_rel;err_r];
    err_r
    
end

disp([error,error_rel])
