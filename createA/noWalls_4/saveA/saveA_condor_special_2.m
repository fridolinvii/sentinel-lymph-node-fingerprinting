function saveA_condor_special_2(n)

%% set constant %%

load('data')
holesZ        = [0,-1];
height        = 36;
[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);
numberOfHoles = length(holesXY(:,1));


%% define positon over or under the hole %%
edges = holesZ;


x_ = x(:); y_ = y(:); z_ = z(:);
    
    

% for n = 1:numberOfHoles
        
        Str = ['A/Ao/A_',num2str(n),'_all'];
        load(Str)
        A = Ao;
        a = sum(A,1);
        
        for s = 1:length(A(1,:))
            % see if it is seen by the detector
            
                Str = [num2str(n) ' of ',num2str(numberOfHoles),'; ',num2str(s),' of ',num2str(length(A(1,:)))];
                disp(Str)
                % find out which pixel on the detector can see the coordinates
                detector = A(:,s)>0;
                
                
                % look at each of the pixel on the detector
                
                
                
                %% create lower part of cube %%
                h = 10^-1;
                
                ly = y_(s)-.5:h:(y_(s)+.5-h);
                lx = (x_(s)-.5)*ones(size(ly));
                
                tx = x_(s)-.5:h:(x_(s)+.5-h);
                ty = (y_(s)+.5)*ones(size(tx));
                
                ry = y_(s)+.5:-h:(y_(s)-.5+h);
                rx = (x_(s)+.5)*ones(size(ly));
                
                bx = x_(s)+.5:-h:(x_(s)-.5+h);
                by = (y_(s)-.5)*ones(size(tx));
                
                
                sqx = [lx,tx,rx,bx];
                sqy = [ly,ty,ry,by];
                
                
                
                
                
                
                
                
                
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
                tTopL = ((z_(s)-.5)-(-height))./DirTopL(:,3);
                tTopR = ((z_(s)-.5)-(-height))./DirTopR(:,3);
                
                DirBotL = bsxfun(@minus,midBotL,[detectorX(detector),detectorY(detector),-height*o]);
                DirBotR = bsxfun(@minus,midBotR,[detectorX(detector),detectorY(detector),-height*o]);
                tBotL =  ((z_(s)-.5)-(-height))./DirBotL(:,3);
                tBotR = ((z_(s)-.5)-(-height))./DirBotR(:,3);
                
                
                % find two Points on the activity Field
                MidTopL = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tTopL,DirTopL));
                MidTopR = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tTopR,DirTopR));
                MidBotL = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tBotL,DirBotL));
                MidBotR = bsxfun(@plus,[detectorX(detector),detectorY(detector),0*o],bsxfun(@times,tBotR,DirBotR));
                
                
                % Midpoint and radius of Image on the activity Field
                %             rTop = norm(MidTop(1,:)-MidTop(2,:))/2;
                MidTop = MidTopL - MidTopR;
                rTop = sqrt(MidTop(:,1).^2+MidTop(:,2).^2+MidTop(:,3).^2);
                MidPointTop = (MidTopL+MidTopR)/2;
                
                MidBot = MidBotL - MidBotR;
                rBot = sqrt(MidBot(:,1).^2+MidBot(:,2).^2+MidBot(:,3).^2);
                MidPointBot = (MidBotL+MidBotR)/2;
                
                %% Find out which holes are activ %%
                
                sqTop = ((MidPointTop(:,1)-sqx).^2+(MidPointTop(:,2)-sqy).^2) <= rTop.^2;
                sqBot = ((MidPointBot(:,1)-sqx).^2+(MidPointBot(:,2)-sqy).^2) <= rBot.^2;
                
                %% calculate area
                sq = (sqTop>0).*(sqBot>0);
                sq = sq>0;
                
                sumSq = sum(sq,2)>0;
                pol = 1:length(sq(:,1));
                A_sq = zeros(length(sq(:,1)),1);
                for p = pol(sumSq)
                    A_sq(p) = polyarea(sqx(sq(p,:)),sqy(sq(p,:)));
                end
                A(detector,s) = sparse(A_sq);
                %hight is 1 hence volum = hight * area = area
                
                
           
        end
        mkdir A/An
        An = A;
        save(['A/An/A_',num2str(n)],'An');
    
    
    
% end