clear all
%close all

pixelSize = 172e-3;
numberOfPixel = [195 487];

sigmax = 1;
sigmay = 1;
sigmaz = 1;


for rot = [0,25]
    for dist = 0:5:25
        A{1} = 'Ao';
        A{2} = 'An';
        
        
        for n = 4%0:5
            t = 2^n;
            
            [detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);

            xl = length(unique(x));
            yl = length(unique(y));
            zl = length(unique(z));
            
            
            for a = 1%:2
                Str = ['radiantSource',A{a},'/special_experiment/rot_',num2str(rot),'/dist_',num2str(dist),'/radiantSource_expt_',num2str(t)];
                load(Str)
                
                
                radiantSource = radiantSource(:).*(z(:)/min(z(:))).^2;
                radiantSource = reshape(radiantSource,yl,xl,zl);
                [xview,yview,zview] = projection(radiantSource,x,sigmax,sigmay,sigmaz);
                subplot(3,1,a)
                imagesc(xview)
                xlabel('z')
                ylabel('y')
                title([A{a},'\_',num2str(rot),'\_',num2str(dist)])
                subplot(3,1,a+1)
                imagesc(yview)
                xlabel('z')
                ylabel('x')
                subplot(3,1,a+2)
                imagesc(zview')
                xlabel('y')
                ylabel('x')
                
            end
            
            pause(1)
        end
        pause
    end
end