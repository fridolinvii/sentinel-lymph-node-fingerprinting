clear all, close all;

[x,y] = meshgrid(0:0.001:1,0:0.001:1);
xc = mean(x(:)); yc = mean(y(:));

dtrue = ((xc-x).^2+(yc-y).^2<=.1^2)+rand(size(x));
dtrue(1,1) = max(dtrue(:));


d1 = ((xc-x).^2+(yc-y).^2<=.1^2);
d2 = ((.2-x).^2+(.15-y).^2<=.1^2);
d3 = ((xc+0.1-x).^2+(yc-y).^2<=.1^2);


d1(1,1) = 1;
d2(1,1) = 1;
d3(1,1) = 1;

figure
subplot(3,2,1)
imagesc(dtrue)
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
subplot(3,2,2)
imagesc(dtrue)
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
colorbar
figure
subplot(3,2,1)
imagesc(d1)
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
subplot(3,2,3)
imagesc(d2)
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
subplot(3,2,5)
imagesc(d3)
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

subplot(3,2,2)
imagesc(dtrue.*(d1));
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
subplot(3,2,4)
imagesc(dtrue.*(d2));
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})
subplot(3,2,6)
imagesc(dtrue.*(d3));
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})




C1 = sqrt(sum(dtrue(:).*d1(:)))
C2 = sqrt(sum(dtrue(:).*d2(:)))
C3 = sqrt(sum(dtrue(:).*d3(:)))

