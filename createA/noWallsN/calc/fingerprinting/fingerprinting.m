
 clear all, close all
 load ../../saveA/A/Ao.mat
 load data/pos
 load data/d
 load data/o;

 
 
 
 alpha_{16} = 0.75;
 
for time =  [1 2 4 8 16 32]
  
for pattern = [1 2 3 4 5 6 7 8 9]
load(['../../Carlo/image_bearbeitet/pattern_',num2str(pattern),'/uncut/noWalls_N_pattern_',num2str(pattern),'_expt_',num2str(time),'.mat'])
%P(unused) = 0;
Ptrue = P;
P=P(unused==0);
o = o(:)>0;
 A = Ao(unused(:)==0,o);
% A = Ao(:,o);

xl = 1:2:max(x(:)); zl = 81:2:180; yl = 1:2:max(y(:));
[x_,y_,z_] = meshgrid(xl,yl,zl);



alpha = 0.75;
source = [];
fold = 10^10;
iter = 0;
while true
%iter = iter+1
Hard = bsxfun(@times,A,P(:));

%Frobenius Norm^2
F = sqrt(sum(Hard.*Hard,1));
p = find(max(F)==F);

if (median(F)/max(F))>alpha %max(F) < (alpha*fold)
median(F)/max(F)
P(A(:,p(1))>0) = 0;
subplot(3,1,1)
imagesc(Ptrue)
subplot(3,1,2)
Pnew = Ptrue;
Pnew(unused==0) = P;
imagesc(Pnew)
subplot(3,1,3)
plot(F)
pause(0.1)


break
end


source = [source;x_(p(:)),y_(p(:)),z_(p(:))];

median(F)/max(F)

fold = max(F);
P(A(:,p(1))>0) = 0;


Pold = P;
subplot(3,1,1)
imagesc(Ptrue)
subplot(3,1,2)
Pnew = Ptrue;
Pnew(unused==0) = P;
imagesc(Pnew)
subplot(3,1,3)
plot(F)
pause(0.1)



end

disp(['Pattern ',num2str(pattern)])
sources{time,pattern} = source;
source
end
end

save('sources','sources')
