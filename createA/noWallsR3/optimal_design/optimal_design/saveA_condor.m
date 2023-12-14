function saveA_condor(n,zo,numberOfSources)
% n = str2num(n)+1;




pixelSize = 172e-3;
numberOfPixel = [195 487];


holesZ        = [0,-1];
height        = 36;
holesCombi = [10 20];

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel,holesCombi);
numberOfHoles = length(holesXY(:,1));

s = source_creator(x,y,z,numberOfSources);
% find activ pixel and ignore the rest
p = s>0;
x = x(p);
y = y(p);
z = z(p);








A = [];

for zl = zo
   
    z_ = z(:);
    
    o = z_ == zl;
    x_ = x(o);
    y_ = y(o);
    z_ = zl;
    %% define positon over or under the hole %%
    edges = holesZ;
    
    
    
    A_= sparse(numel(detectorX),numel(x_));
    
    %     for s = 1:numel(x_)
    % see if it is seen by the detector
    Str = [num2str(n) ' of ',num2str(numberOfHoles),'; ',num2str(zl)];%,' of ',num2str(length(A(1,:)))];
    disp(Str)
    
    
    
    
    
    % look at each of the pixel on the detector
    detector = (1:numel(detectorX))';
    
       
    
    
    
    
    
    %% Richtungsvector
    dir = 0.5*([detectorX(detector),detectorY(detector)]-holesXY(n,:))./sqrt((detectorX(detector)-holesXY(n,1)).^2+(detectorY(detector)-holesXY(n,2)).^2);
    
    % Punkte wo Strahlen durchgehen
    o = ones(length(dir(:,1)),1);
    midTopL = [bsxfun(@plus,holesXY(n,:),dir),edges(1)*o];
    midTopR = [bsxfun(@minus,holesXY(n,:),dir),edges(1)*o];
    midBotL = [bsxfun(@plus,holesXY(n,:),dir),edges(2)*o];
    midBotR = [bsxfun(@minus,holesXY(n,:),dir),edges(2)*o];
    
    % Richtungsvector um Punkt auf dem activity field zu finden
    DirTopL = bsxfun(@minus,midTopL,[detectorX(detector),detectorY(detector),-height*o]);
    DirTopR = bsxfun(@minus,midTopR,[detectorX(detector),detectorY(detector),-height*o]);
    


    
    tTopL_ = (z_-(-height))./DirTopL(:,3);
    tTopR_ = (z_-(-height))./DirTopR(:,3);
    
    
    DirBotL = bsxfun(@minus,midBotL,[detectorX(detector),detectorY(detector),-height*o]);
    DirBotR = bsxfun(@minus,midBotR,[detectorX(detector),detectorY(detector),-height*o]);
    

    
    tBotL_ = (z_-(-height))./DirBotL(:,3);
    tBotR_ = (z_-(-height))./DirBotR(:,3);
    
    
    % find two Points on the activity Field

    
    
    MidTopL_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tTopL_,DirTopL));
    MidTopR_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tTopR_,DirTopR));
    MidBotL_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tBotL_,DirBotL));
    MidBotR_ = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tBotR_,DirBotR));
    
    
    
    
    % Midpoint and radius of Image on the activity Field
    %             rTop = norm(MidTop(1,:)-MidTop(2,:))/2;
    
    MidTop_ = MidTopL_ - MidTopR_;
    rTop_ = sqrt(MidTop_(:,1).^2+MidTop_(:,2).^2+MidTop_(:,3).^2);
    MidPointTop_ = (MidTopL_+MidTopR_)/2;
    
    MidBot_ = MidBotL_ - MidBotR_;
    rBot_ = sqrt(MidBot_(:,1).^2+MidBot_(:,2).^2+MidBot_(:,3).^2);
    MidPointBot_ = (MidBotL_+MidBotR_)/2;
    
    %% Find out which holes are activ %%
    
    % sqTop = (bsxfun(@minus,MidPointTop(:,1),sqx)).^2+(bsxfun(@minus,MidPointTop(:,2),sqy)).^2;
    % sqTop = sqTop <= bsxfun(@times,rTop,ones(sqTop)).^2;
    
    
    
    for d = 1:numel(detectorX)
        
        
        %disp([d,numel(detectorX)])
        
        
        sqTop_ = ((MidPointTop_(d,1)-x_).^2+(MidPointTop_(d,2)-y_).^2) <= rTop_(d).^2;
        sqBot_ = ((MidPointBot_(d,1)-x_).^2+(MidPointBot_(d,2)-y_).^2) <= rBot_(d).^2;
        
        
        
        %% A without statistic
        
        sq_ = (sqTop_>0).*(sqBot_>0);
        sq_ = sq_>0;
        A_(d,:) = sparse(sq_');
        
        
        
        
        
    end
    
    
    A = [A,A_];
    
end



mkdir(['A_',num2str(numberOfSources),'/Ao']);
save(['A_',num2str(numberOfSources),'/Ao/A_',num2str(n)],'A','-v7.3');
