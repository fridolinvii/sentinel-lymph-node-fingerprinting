clear all
close all

Str{1,1} = 'Ao_s_1';
Str{1,2} = 'Ao_s_2';
Str{1,3} = 'Ao_s_3';
Str{1,4} = 'Ao_s_4';
Str{1,5} = 'Ao_s_5';

alpha = 1-0.12;

for a = 1
    for source = 1:4
        
        str = Str{a,source};
        
        load(Str{a,source})
        figure(2)
        hold on
        plot(sort(w(:,end)))
        hold off
        figure(1)
        for l = length(w(1,:))
            
            w0 = w(:,l);
            
            q = quantile(w0,alpha);
            
            %            q = 0.65*max(w0);
            w0(w0<q) = 0;
            w0 = w0>0;
            sum(w0)
            
          
	    holes = holesXY(w0,:);
	    save(['holesXY_',num2str(source)],'holes');
	    
  
            plate = circle(w0,source);
            
            
            subplot(2,1,1)
            imagesc(plate)
            title([str,' iter_{',num2str(l),'}'])
            
            if l>1
                subplot(2,1,2)
                plot(r(1:l-1))
                title('relativ Residium')
            end
            
            
            
            
            
            
            pause(1)
            
        end
%         figure
%         imagesc(plate)
        pause
    end
    pause
end


function plate = circle(w0,source)


load data


[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel,holesCombi);
[~,r,xM,yM,~] = source_creator(x,y,z,source);
holes = holesXY(w0,:);




plate = zeros(size(detectorX));

%% source
for l = 1:length(xM)
    p = ( (xM(l)-detectorX).^2+(yM(l)-detectorY).^2) <= (r^2);
    plate(p) = 1;
end




%% holes
r = 1;
for l = 1:length(holes(:,1))
    p = ( (holes(l,1)-detectorX).^2+(holes(l,2)-detectorY).^2) <= (r^2);
    plate(p) = 2;
    
    
end


end






