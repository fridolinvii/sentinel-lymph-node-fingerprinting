clear all
close all

pixelSize = 172e-3;
numberOfPixel = [195 487];
[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);

xl = length(unique(x));
yl = length(unique(y));
zl = length(unique(z));
y_ = y(:,1,:);
z_ = z(:,1,:);
y_ = reshape(y_,yl,zl);
z_ = reshape(z_,yl,zl);

t = 16;
sigma = .0;

O{1} = 'calc';
O{2} = 'optimal_design';


for rot = [0 25]
    for dist = 0:5:25
        for o = 1:2

            r = 0;
            for x_ = 12:16%1:max(x(:))
                Str = [O{o},'/radiantSourceAo/special_experiment/rot_',num2str(rot),'/dist_',num2str(dist),'/radiantSource_expt_',num2str(t)];
                load(Str)
                m = max(radiantSource(:));
                
                
                
                radiantSource = radiantSource.*(z(:)/min(z(:))).^2;
                radiantSource = imgaussfilt(reshape(radiantSource,yl,xl,zl),2);
                radiantSource = radiantSource.*(radiantSource>(sigma*max(radiantSource(:))));
                radiantSource = reshape(radiantSource,yl,xl,zl);
                
                radiantSource = radiantSource(:,x_,:);
                radiantSource = reshape(radiantSource,yl,zl);
                
                %         radiantSource(1) = m;
                
                r = r+radiantSource/5;
                
            end
            
            radiantSource = r;
            radiantSource = imgaussfilt(radiantSource,1);
            
            
            
            subplot(2,1,o)
            surf(z_',y_',radiantSource','EdgeColor','none')
            title([O{o},'\_rot\_',num2str(rot),'\_dist\_',num2str(dist),'\_x\_12:16'])
            xlabel('z')
            ylabel('y')
            view([0,0,11])
            
            [yM,zM] = source(rot,dist);
            hold on
            plot3(zM,yM,m*ones(length(yM)),'ro')
            hold off
            
            
            
        end
        pause
    end
end


function [yM,zM] = source(rot,dist)

if rot == 0
    yM = 41;
    zM = 95;
    
    
    if dist > 0
        yM = [yM,yM];
        zM = [zM,zM+dist];
    end
    
end

if rot == 25
    if dist == 0
        yM = 41;
        zM = 95;
    else
        
        yM = 35;
        zM = 100;
    end
    
    if dist > 0
        
        yM = [yM,yM-dist*sin(2*pi/(360/25))];
        zM = [zM,zM+dist*cos(2*pi/(360/25))];
        
    end
end










end

