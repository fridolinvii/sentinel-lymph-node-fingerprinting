close all
clear  all




% ksiz = 2;


%l1 = '_huge';
l1 = [];
%l1 = ['_80']
%l1 = '_n';
% l1 = '_total'

sigmax = 3;
sigmay = 3;
sigmaz = 2;

sigma = 1;
v = [0,0,1];




position = [2,5,4];
%time = [120,40,60];
%hight = [50,150,100];
position = [2,5,8,4];
hight = 100;



alpha = .2;

for c = 1:4
    
    pos =  position(c);
    %h = hight(c);
    h = 100;
    %t = time(c);
    t = 30;
    if h == 50;
        load('data/data_')
        l1 = [];
    end
    if h == 100 || h == 150
        load('data/data_80c')
        l1 = '_80';
    end
    siz = size(x);
    
    %% load radiantSource %%
    location = ['radiantSource/',num2str(pos),l1,'/dist_',num2str(h),'_expt_',num2str(t)];
    load(location)
    
    
    %% weight %%
    if sum(radiantSource(:))>0
        radiantSource =(z(:)./min(z(:))).^2.*(radiantSource(:));%./max(radiantSource(:)));
    end
    %% imgaussfilt %%
    radiantSource = reshape(radiantSource, siz);
    %radiantSource = imgaussfilt(radiantSource,sigma);
    
    
    
    
    
    %% projection %%
    a = radiantSource;
    
    
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
    
    
    mx = max(xview(:));
    my = max(yview(:));
    mz = max(zview(:));
    
    
    
    %% plot position of radiant Source %%
    dist = 15;
    x_ = mean(x(:))-6; %13
    y_ = mean(y(:));
    
    %% plot projection %%
    figure(1)
    
    l = 10^-13;
    xu = unique(x);
    yu = unique(y);
    zu = unique(z)-35;
    
    
    %      subplot(3,3,c)
%     subplot(3,4,c)
subplot(3,4,c+4)
    %             colormap(jet)
    %             surf(xu,zu,xview','EdgeColor','none','LineStyle','none','FaceLighting','phong')
    %             axis([0,83,0,220,0,mx+l])
    %            xlabel('x')
    %             ylabel('z')
    surf(zu,xu,xview,'EdgeColor','none','LineStyle','none','FaceLighting','phong')
    axis([0,220,0,83,0,mx+l])
    axis([70,220,0,83,0,mx+l])
    xlabel('z [mm]')
    ylabel('x [mm]')
    % axis([min(zu),max(zu),min(xu),max(xu),min(xview2(:)),max(xview2(:))])
    % view([0,-1,0])
    
    %axis([0,83,0,220,0,3])
    view(v)
    
    %title(['exposertime ',num2str(t)])
    %title('second approach')
    
    
    
    % subplot(3,3,c+3)
%     subplot(3,4,c+4)
subplot(3,4,c)
    % imagesc(yview)
    %             surf(yu,zu,yview','EdgeColor','none','LineStyle','none','FaceLighting','phong')
    %             axis([0,83,0,220,0,my+l])
    %             xlabel('y')
    %             ylabel('z')
    surf(zu,yu,yview,'EdgeColor','none','LineStyle','none','FaceLighting','phong')
    % axis([0,220,0,83,0,my+l])
    axis([70,220,0,83,0,my+l])
    xlabel('z [mm]')
    ylabel('y [mm]')
    view(v)
    
    %
    %subplot(3,3,c+6)
    subplot(3,4,c+8)
    surf(yu,xu,zview','EdgeColor','none','LineStyle','none','FaceLighting','phong')
    %axis([0,200,0,83,0,mz+l])
    axis([0,130,0,83,0,mz+l])
    xlabel('y [mm]')
    ylabel('x [mm]')
    %             surf(xu,yu,zview,'EdgeColor','none','LineStyle','none','FaceLighting','phong')
    %             axis([0,83,0,83,0,mz+l])
    %             xlabel('x')
    %             ylabel('y')
    view([0,0,-1])
    
    
    
    
    
    
    
    
    %% plot gaussian mixer %%
    
    
    %% gaussian mixer %%
    
    
    
    [x_xz,z_xz] = meshgrid(zu,xu);
    [y_yz,z_yz] = meshgrid(zu,yu);
    [x_xy,y_xy] = meshgrid(xu,yu);
    
    xview = xview.*(xview>alpha*max(xview(:)));
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
            case 2
                ksiz = 1;
                ksiz_ = 1;
            case 4
                ksiz = 2;
                ksiz_ = 2;
            case 5
                ksiz = 2;
                ksiz_ = 1;
            case 8
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
        
        
        
        
%         subplot(3,4,c)
subplot(3,4,c+4)
        %                   subplot(3,3,c)
        %                   title([pos,t,h])
        hold on
        %                   plot3(g_xz(:,2),g_xz(:,1),mx*(g_xz(:,1)~=0)+l,'r^')
        plot3(g_xz(:,1),g_xz(:,2),mx*(g_xz(:,1)~=0)+l,'r^')
        view(v)
        hold off
        
        %subplot(3,3,c+3)
%         subplot(3,4,c+4)
subplot(3,4,c)
        hold on
        %                   plot3(g_yz(:,2),g_yz(:,1),my*(g_yz(:,1)~=0)+l,'r^')
        plot3(g_yz(:,1),g_yz(:,2),my*(g_yz(:,1)~=0)+l,'r^')
        view(v)
        hold off
        
        %subplot(3,3,c+6)
        subplot(3,4,c+8)
        hold on
        plot3(g_xy(:,2),g_xy(:,1),3*(g_xy(:,1)~=0)*min(zview(:))-l,'r^')
        %                   plot3(g_xy(:,1),g_xy(:,2),3*(g_xy(:,1)~=0)*min(zview(:))-l,'r^')
        view([0,0,-1])
        hold off
        
        
        
        %% plot position of radiant Source %%
        % show position
        
        %subplot(3,3,c)
%         subplot(3,4,c)
subplot(3,4,c+4)
        hold on
        if pos == 2
            %                 plot3(x_,h+dist,max(xview(:)),'co')
            plot3(h+dist,x_,max(xview(:)),'co')
        end
        if pos == 5
            %                 plot3(x_,h+dist,max(xview(:)),'co')
            %                 plot3(x_,h+2*dist,max(xview(:)),'co')
            plot3(h+dist,x_,max(xview(:)),'co')
            plot3(h+2*dist,x_,max(xview(:)),'co')
        elseif pos == 8
            %                 plot3(x_,h+dist,max(xview(:)),'co')
            %                 plot3(x_,h+3*dist,max(xview(:)),'co')
            plot3(h+dist,x_,max(xview(:)),'co')
            plot3(h+3*dist,x_,max(xview(:)),'co')
        elseif pos == 4
            %                 plot3(x_+6,h+dist,max(xview(:)),'co')
            %                 plot3(x_,h+2*dist,max(xview(:)),'co')
            plot3(h+dist,x_+6,max(xview(:)),'co')
            plot3(h+2*dist,x_,max(xview(:)),'co')
        end
        grid off
        hold off
        
        %             subplot(3,3,c+3)
%         subplot(3,4,c+4)
        subplot(3,4,c)
        hold on
        %             plot3(mean(yu)+1,h+dist,max(yview(:)),'co')
        plot3(h+dist,mean(yu)+1,max(yview(:)),'co')
        if pos == 5
            %                 plot3(mean(yu)+1,h+2*dist,max(yview(:)),'co')
            plot3(h+2*dist,mean(yu)+1,max(yview(:)),'co')
        elseif pos == 8
            %                 plot3(mean(yu)+1,h+3*dist,max(yview(:)),'co')
            plot3(h+3*dist,mean(yu)+1,max(yview(:)),'co')
        elseif pos == 4
            %                 plot3(mean(yu)+dist+1,h+2*dist,max(yview(:)),'co')
            plot3(h+2*dist,mean(yu)+dist+1,max(yview(:)),'co')
        end
        grid off
        hold off
        
        
        subplot(3,4,c+8)
        %subplot(3,3,c+6)
        hold on
        
        if pos == 4
            plot3(mean(yu)+1,x_+6,min(zview(:)),'co')
            plot3(mean(yu)+dist+1,x_,min(zview(:)),'co')
            %                 plot3(x_+6,mean(yu)+1,min(zview(:)),'co')
            %                 plot3(x_,mean(yu)+dist+1,min(zview(:)),'co')
        else
            plot3(mean(yu)+1,x_,min(zview(:)),'co')
            %                 plot3(x_,mean(yu)+1,min(zview(:)),'co')
        end
        grid off
        view([0,0,-1])
        hold off
        
        
        
    end
    
    
    
    pause(1);
    
    
    
end

% save('auswerten/50','data2_vxy','data4_vxy','data5_vxy','data8_vxy','data2_vxz','data4_vxz','data5_vxz','data8_vxz','data2_vyz','data4_vyz','data5_vyz','data8_vyz')

