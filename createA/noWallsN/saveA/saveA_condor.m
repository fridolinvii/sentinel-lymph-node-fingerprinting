function saveA_condor(n,zl)
% n = str2num(n)+1;




pixelSize = 172e-3;
numberOfPixel = [195 487];


holesZ        = [0,-1];
height        = 36;

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
numberOfHoles = length(holesXY(:,1));

x_ = x(:);
y_ = y(:);
z_ = z(:);



%% calculate everything on the same hight
o = z_ == zl;
x_ = x(o);
y_ = y(o);
z_ = zl;





%% define positon over or under the hole %%
edges = holesZ;



% for n = 1:numberOfHoles

A_mid = sparse(numel(detectorX),numel(x_));
A_low= sparse(numel(detectorX),numel(x_));
A_top = sparse(numel(detectorX),numel(x_));
A_= sparse(numel(detectorX),numel(x_));

%     for s = 1:numel(x_)
% see if it is seen by the detector
Str = [num2str(n) ' of ',num2str(numberOfHoles),'; ',num2str(zl)];%,' of ',num2str(length(A(1,:)))];
disp(Str)





% look at each of the pixel on the detector
detector = (1:numel(detectorX))';


%% create lower part of cube %%
h = 10^-1;

m  = -.5:h:.5;
ly = bsxfun(@plus,y_,m);
lx = bsxfun(@times,(x_-.5),ones(size(ly)));
% ly = y_(s)-.5:h:(y_(s)+.5-h);
% lx = (x_(s)-.5)*ones(size(ly));

tx = bsxfun(@plus,x_,m);
ty = bsxfun(@times,(y_+.5),ones(size(tx)));
% tx = x_(s)-.5:h:(x_(s)+.5-h);
% ty = (y_(s)+.5)*ones(size(tx));

m = .5:-h:-.5;
ry = bsxfun(@plus,y_,m);
rx = bsxfun(@times,x_+.5,ones(size(ry)));
% ry = y_(s)+.5:-h:(y_(s)-.5+h);
% rx = (x_(s)+.5)*ones(size(ly));

bx = bsxfun(@plus,x_,m);
by = bsxfun(@times,y_-.5,ones(size(bx)));
% bx = x_(s)+.5:-h:(x_(s)-.5+h);
% by = (y_(s)-.5)*ones(size(tx));


sqx = [lx,tx,rx,bx];
sqy = [ly,ty,ry,by];









%% Richtungsvector on the ground
% der Länge .5
dir = 0.5*([detectorX(detector),detectorY(detector)]-holesXY(n,:))./sqrt((detectorX(detector)-holesXY(n,1)).^2+(detectorY(detector)-holesXY(n,2)).^2);

% Punkte wo Strahlen durchgehen
o = ones(length(dir(:,1)),1);
midTopL = [bsxfun(@plus,holesXY(n,:),dir),edges(1)*o];
midTopR = [bsxfun(@minus,holesXY(n,:),dir),edges(1)*o];
midBotL = [bsxfun(@plus,holesXY(n,:),dir),edges(2)*o];
midBotR = [bsxfun(@minus,holesXY(n,:),dir),edges(2)*o];

% Richtungsvector um Punkt auf dem activity field zu finden 
% vom "Loch Oben" zum Detector
DirTopL = bsxfun(@minus,midTopL,[detectorX(detector),detectorY(detector),-height*o]);
DirTopR = bsxfun(@minus,midTopR,[detectorX(detector),detectorY(detector),-height*o]);



%% We take position of detector as the ortsvector %%
tTopL = ((z_-.5)-(-height))./DirTopL(:,3);
tTopR = ((z_-.5)-(-height))./DirTopR(:,3);

%top
tTopLt = ((z_+.5)-(-height))./DirTopL(:,3);
tTopRt = ((z_+.5)-(-height))./DirTopR(:,3);

%mid
tTopL_ = (z_-(-height))./DirTopL(:,3);
tTopR_ = (z_-(-height))./DirTopR(:,3);


DirBotL = bsxfun(@minus,midBotL,[detectorX(detector),detectorY(detector),-height*o]);
DirBotR = bsxfun(@minus,midBotR,[detectorX(detector),detectorY(detector),-height*o]);


tBotL = ((z_-.5)-(-height))./DirBotL(:,3);
tBotR = ((z_-.5)-(-height))./DirBotR(:,3);

tBotLt = ((z_+.5)-(-height))./DirBotL(:,3);
tBotRt = ((z_+.5)-(-height))./DirBotR(:,3);


tBotL_ = (z_-(-height))./DirBotL(:,3);
tBotR_ = (z_-(-height))./DirBotR(:,3);


% find two Points on the activity Field, with Ortsvector on the Detector

MidTopL = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tTopL,DirTopL));
MidTopR = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tTopR,DirTopR));
MidBotL = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tBotL,DirBotL));
MidBotR = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tBotR,DirBotR));

MidTopLt = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tTopLt,DirTopL));
MidTopRt = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tTopRt,DirTopR));
MidBotLt = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tBotLt,DirBotL));
MidBotRt = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tBotRt,DirBotR));


MidTopL_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tTopL_,DirTopL));
MidTopR_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tTopR_,DirTopR));
MidBotL_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tBotL_,DirBotL));
MidBotR_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),(-height)*o],bsxfun(@times,tBotR_,DirBotR));




% Midpoint and radius of Image on the activity Field
%             rTop = norm(MidTop(1,:)-MidTop(2,:))/2;
MidTop = MidTopL - MidTopR;
rTop = sqrt(MidTop(:,1).^2+MidTop(:,2).^2+MidTop(:,3).^2);
MidPointTop = (MidTopL+MidTopR)/2;

MidBot = MidBotL - MidBotR;
rBot = sqrt(MidBot(:,1).^2+MidBot(:,2).^2+MidBot(:,3).^2);
MidPointBot = (MidBotL+MidBotR)/2;

MidTopt = MidTopLt - MidTopRt;
rTopt = sqrt(MidTopt(:,1).^2+MidTopt(:,2).^2+MidTopt(:,3).^2);
MidPointTopt = (MidTopLt+MidTopRt)/2;

MidBott = MidBotLt - MidBotRt;
rBott = sqrt(MidBott(:,1).^2+MidBott(:,2).^2+MidBott(:,3).^2);
MidPointBott = (MidBotLt+MidBotRt)/2;

MidTop_ = MidTopL_ - MidTopR_;
rTop_ = sqrt(MidTop_(:,1).^2+MidTop_(:,2).^2+MidTop_(:,3).^2);
MidPointTop_ = (MidTopL_+MidTopR_)/2;

MidBot_ = MidBotL_ - MidBotR_;
rBot_ = sqrt(MidBot_(:,1).^2+MidBot_(:,2).^2+MidBot_(:,3).^2);
MidPointBot_ = (MidBotL_+MidBotR_)/2;

%% Find out which holes are activ %%

% sqTop = (bsxfun(@minus,MidPointTop(:,1),sqx)).^2+(bsxfun(@minus,MidPointTop(:,2),sqy)).^2;
% sqTop = sqTop <= bsxfun(@times,rTop,ones(sqTop)).^2;


% load('calibN')
%load /nfs/server/condor/users/miac/carlo/experiment_13.07.17/_collimator_withWalls_N_new/saveA/calibN
%activ = activity{n};
%activ = activ(:)>0;
a_ = 1:numel(detectorX);


for d = a_

    
%      disp([d,numel(detectorX)])

sqTop = ((MidPointTop(d,1)-sqx).^2+(MidPointTop(d,2)-sqy).^2) <= rTop(d).^2;
sqBot = ((MidPointBot(d,1)-sqx).^2+(MidPointBot(d,2)-sqy).^2) <= rBot(d).^2;

sqTopt = ((MidPointTopt(d,1)-sqx).^2+(MidPointTopt(d,2)-sqy).^2) <= rTopt(d).^2;
sqBott = ((MidPointBott(d,1)-sqx).^2+(MidPointBott(d,2)-sqy).^2) <= rBott(d).^2;


sqTop_ = ((MidPointTop_(d,1)-x_).^2+(MidPointTop_(d,2)-y_).^2) <= rTop_(d).^2;
sqBot_ = ((MidPointBot_(d,1)-x_).^2+(MidPointBot_(d,2)-y_).^2) <= rBot_(d).^2;

%% calculate area
sq = (sqTop>0).*(sqBot>0);
sq = sq>0;

sqt = (sqTopt>0).*(sqBott>0);
sqt = sqt>0;

sq_ = (sqTop_>0).*(sqBot_>0);
sq_ = sq_>0;



%sqy_ = sqy(:,[2:end,1]);
%sqx_ = sqx(:,[2:end,1]);
%sq_sum = sum(sqt,2)>0;
%l_sq = 1:length(sq_sum);
%l_sq = l_sq(sq_sum);

%for l = 1:l_sq
%    
%    sq_new_ = sq_(l,:);
%	A_mid(d,l) = sparse(polyarea(sqx(l,sq_new_),sqy(l,sq_new_)));
    
%    sq_newt = sqt(l,:);
%	A_top(d,l) = sparse(polyarea(sqx(l,sq_newt),sqy(l,sq_newt)));
    
%	sq_new = sq(l,:);
%	A_low(d,l) = sparse(polyarea(sqx(l,sq_new),sqy(l,sq_new)));
%end




%Area = .5*(sum(sq.*sqx.*sqy_,2)-sum(sq.*sqy.*sqx_,2));
%A(d,:) = Area';


%% A without statistic



sq_ = (sqTop_>0).*(sqBot_>0);
sq_ = sq_>0;
A_(d,:) = sparse(sq_');




end




%     end


% mkdir A/An/A
% save(['A/An/A/A_',num2str(n),'_',num2str(zl)],'A_low','A_mid','A_top','-v7.3');



A = A_;
mkdir A/Ao/A
save(['A/Ao/A/A_',num2str(n),'_',num2str(zl)],'A','-v7.3');
% end

