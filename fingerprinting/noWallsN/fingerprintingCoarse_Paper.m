
% 
% clear all, close all
% load pos
% load DictLLN


xx = unique(x(:));
xs = zeros(size(x));
for j = 3:3:length(xx)-1
    xs = xs+(x == xx(j));
end


yy = unique(y(:));
ys = zeros(size(y));
for j = 3:3:length(yy)-1
    ys = ys+(y == yy(j));
end


zz = unique(z(:));
zs = zeros(size(z));
for j = 3:3:length(zz)-1
    zs = zs+(z == zz(j));
end

ss = ys.*zs.*xs.*(z<=180);
% ss = ys.*zs.*xs.*(z<=151).*(z>=80).*(x>=16).*(x<=26).*(y<=63).*(y>=21);
% ss = ys.*zs.*xs.*(z<=170).*(z>=80).*(x>=18).*(x<=26).*(y<=63).*(y>=21);
%N = [4500,4000,3000]; %Dict0
%N = [6e3 5e3 3e3]; %Dict3



 [~,xp] = sort(x(:));
N = [0 0 0 0]; % delta = 0.95 % problem with 6 at 32s
for time = 16%[2 4 8 16 32]
    
    
    
    
    for pattern = [1 4 5 6 7 8 9] %2 3
        
        switch pattern
            case 1
                numberOfSources = 1;
            case {8,9}
                numberOfSources = 3;
            otherwise
                numberOfSources = 2;
        end
        
        
        load(['image_bearbeitet/pattern_',num2str(pattern),'/uncut/noWalls_R3_pattern_',num2str(pattern),'_expt_',num2str(time),'.mat'])
        %        load(['image_bearbeitet/withWalls_N/pattern_',num2str(pattern),'/uncut/withWalls_N_pattern_',num2str(pattern),'_expt_',num2str(time),'.mat'])
        
               
        
        Ptrue = P;
        Pnew= P;
        
        cut = P > 0;
        Pc = P(cut(:));
        DictC = Dict(cut(:),:);
        Pnew(cut(:)==0) = 0;
        
        %	oo = sum(Dict,1)<2000;
        %	sum(oo==0)
        %	DictC(:,oo) = 0;
        
        
        alpha = 0.5;
        source = [];
        fold = 10^10;
        iter = 0;
        
        HARD = zeros(numel(x),3+numberOfSources);
        HARD(:,1:3) = [x(:),y(:),z(:)];
        
        for n = 1:numberOfSources+1
            %iter = iter+1
            
            
            F = 0;
            Fall = zeros(size(DictC,2),1);
            t=1;
            T = 1:t:size(DictC,2);
            for i = T
                
                if ss(i) > 0
%                     		 Dict0 = DictC(:,i);
                    
                    Dict0 = (DictC(:,i)>N(n)).*DictC(:,i);
                    %    Dict0 = Dict0;
                    %                    Dict0 = Dict0/max(Dict0);
                    %                     Dict0 = DictC(:,i)/max(DictC(:,1));
%                                         Dict0 = (DictC>N(n)).*DictC;
                    nD = norm(Dict0);
                    if nD > 0
                        Hard = norm(Dict0'*Pc);%/nD;
                    else
                        Hard = 0;
                    end
                    Fall(i) = Hard;
                    HARD(i,3+n) = Hard;
                    if Hard>F
                        DicD = Dict0;
                        F = Hard;
                        p = i;
                    end
                else
                    HARD(i,3+n) = 0;
                end
            end
            
            
            
            Fall = log(Fall);
            if n == 1
                
                
                ll = Fall~=-Inf;
                Fall(ll==0)=-100;
               
                m = mean(Fall(ll));
                ma = max(Fall(ll));
                mi = 2*m-ma;
            end
            
            m/max(Fall)
            source = [source;x(p(:)),y(p(:)),z(p(:))];
            fold = max(F);
            
            %             Pc(DicD>0) = 0;
            Pc(DicD>10^-5) = 0;
            
            
            
            
            %             so = (x==x(p)).*(y==y(p)).*(z==z(p));
            %             oo = Ao(cut(:),:)*so(:);
            %             Pc(oo>0) = 0;
            
            
            Pold = P;
            subplot(2,2,1)
            imagesc(Ptrue)
            subplot(2,2,2)
            
            
            DictN = Dict(:,p)>N(n);
            Pnew(DictN) = 0;
            imagesc(Pnew)
            subplot(2,2,3)
           
            [~,xpp] = sort(x(ll));
            Fal = Fall(ll);
            plot(Fal(xpp))
            axis([0 sum(ll) mi ma])
            
            
            %             subplot(2,2,4)
            %             fall = fft(Fall);
            %             fall = fall.*conj(fall);
            %             plot(fall)
            
            pause(1)
            
            
            DictC = DictC(DicD==0,:);
            Pc = Pc(DicD==0);
            
        end
        
        disp(['Pattern ',num2str(pattern),'; Time ',num2str(time)])
        sources{time,pattern}.position = source;
        sources{time,pattern}.C = HARD;
        source
        m/max(Fall)
 
        
        pause(1)
    end
end

save('Source_Coarse_LL','sources','-v7.3')
