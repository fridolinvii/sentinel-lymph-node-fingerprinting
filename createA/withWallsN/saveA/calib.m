%
% lower_left  = double(calib_marker_lower_left);
% lower_right = double(calib_marker_lower_right);
% upper_right = double(calib_marker_upper_right);
%
% save('calib')

close all
clear all

load('calib')

pixelSize = 172e-3;
numberOfPixel = [195 487];
[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);


% lower_left = lower_left.*(lower_left<20);
% lower_right = lower_right.*(lower_right<20);
% upper_right = upper_right.*(upper_right<20);


lower_left_cal=lower_left;
lower_right_cal=lower_right;
upper_right_cal = upper_right ;


%% inner part of the colimator

o1 = 39:172;
o2 = 30:458;
o30 = 30*ones(size(o1));
o459 = 459*ones(size(o1));
o40 = 40*ones(size(o2));
o172 = 172*ones(size(o2));


ox = [o1,o1,o40,o172];
oy = [o30,o459,o2,o2];
lower_left_cal(ox,oy) = -1;
lower_right_cal(ox,oy) = -1;
upper_right_cal(ox,oy) = -1;




%% walls
wy = 4:486;
wx = 9:195;

lower_left_cal_walls = -2*ones(size(lower_left));
lower_right_cal_walls = -2*ones(size(lower_left));
upper_right_cal_walls = -2*ones(size(lower_left));


lower_left_cal_walls(wx,wy) = lower_left_cal(wx,wy);
lower_right_cal_walls(wx,wy) = lower_right_cal(wx,wy);
upper_right_cal_walls(wx,wy) = upper_right_cal(wx,wy);


cordX = [39 172];
cordY = [30 459];



%% activity field


ay{1} = 4:56; ay{2} = 60:118; ay{3} = 122:181; 
ay{4} = 185:243; ay{5} = 247:306; ay{6} = 310:367; 
ay{7} = 371:429; ay{8} = 433:486;

ax{1} = 9:69; ax{2} = 73:137; ax{3} = 141:195;

for n1 = 1:3
    for n2 = 1:8
        a = zeros(size(detectorX));
        a(ax{n1},ay{n2}) = 1;
        activity{(n1-1)*8+n2} = a;
        
    end
end










test = zeros(size(detectorX));

for n = 1:24
    
    test = test+activity{n};
%     figure(2)
%     imagesc(test)
%     hold on
%     plot(holesXY(1:n,2)/.172,holesXY(1:n,1)/.172,'r*')
%     hold off
%     
%     
%     
%     pause(1)
    
end



save('calibN', 'cordX','cordY','wx','wy','activity')




figure(1)
subplot(3,1,1)
imagesc(lower_left_cal_walls)
subplot(3,1,2)
imagesc(lower_right_cal_walls)
subplot(3,1,3)
imagesc(upper_right_cal_walls)


figure(3)
subplot(3,1,1)
imagesc(lower_left_cal_walls.*test)
hold on
plot(holesXY(1,2)/.172,holesXY(1,1)/.172,'r*')
subplot(3,1,2)
imagesc(lower_right_cal_walls.*test)
hold on
plot(holesXY(:,2)/.172,holesXY(:,1)/.172,'r*')
subplot(3,1,3)
imagesc(upper_right_cal_walls.*test)
hold on
plot(holesXY(:,2)/.172,holesXY(:,1)/.172,'r*')


figure(4)
load('test_pic')
imagesc(test.*d.*(d<100))
hold on
plot(holesXY(:,2)/.172,holesXY(:,1)/.172,'r*')

