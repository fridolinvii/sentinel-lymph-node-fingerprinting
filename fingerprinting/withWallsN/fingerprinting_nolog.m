
% 
clear all, close all
load pos
load DictLLN
% load Dict

% For R3 everything is shifted 2s with 30mbq are 1s with 60mbq etc

xx = unique(x(:));
xs = zeros(size(x));
for j = 1:1:length(xx)
    xs = xs+(x == xx(j));
end


yy = unique(y(:));
ys = zeros(size(y));
for j = 1:1:length(yy)
    ys = ys+(y == yy(j));
end


zz = unique(z(:));
zs = zeros(size(z));
for j = 1:1:length(zz)
    zs = zs+(z == zz(j));
end

ss = ys.*zs.*xs.*(z<=180);
% ss = ys.*zs.*xs.*(z<=151).*(z>=80).*(x>=16).*(x<=26).*(y<=63).*(y>=21);
% ss = ys.*zs.*xs.*(z<=170).*(z>=80).*(x>=18).*(x<=26).*(y<=63).*(y>=21);
%N = [4500,4000,3000]; %Dict0
%N = [6e3 5e3 3e3]; %Dict3



 [~,xp] = sort(x(:));
N = [0 0 0 0]; % delta = 0.95 % problem with 6 at 32s
mnew = 0;
delta = [];
mmm = zeros(1,4);
for time = [1 2 4 8 16 32]
    
    
    
    
    for pattern =[1 2 3 4 5 6 7 8 9] %2 3
        
        switch pattern
            case 1
                numberOfSources = 1;
            case {8,9}
                numberOfSources = 3;
            otherwise
                numberOfSources = 2;
        end
        
        
        load(['image_bearbeitet/pattern_',num2str(pattern),'/uncut/withWalls_N_pattern_',num2str(pattern),'_expt_',num2str(time),'.mat'])
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
        mmm = zeros(1,4);
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
                    if nD > 0.1414
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
            
            
            
            Fall = (Fall);
            mmm(n) = max(Fall);
            if n == 1
                m = mean(Fall(Fall>0));
                ma = max(Fall);
                [position,strength] = find_pattern(pattern);
                mi = 2*m-ma;
            end
            
            mold = mnew;
            mnew = m/max(Fall);
            source = [source;x(p(:)),y(p(:)),z(p(:))];
            fold = max(F);
            
            %             Pc(DicD>0) = 0;
            Pc(DicD>10^-5) = 0;
            
            
            
            
            %             so = (x==x(p)).*(y==y(p)).*(z==z(p));
            %             oo = Ao(cut(:),:)*so(:);
            %             Pc(oo>0) = 0;
            
            
            Pold = P;
            subplot(2,2,1)
            surf(Ptrue,'edgecolor','none')
            view([0,0,1])
            axis tight
            subplot(2,2,2)
            
            
            DictN = Dict(:,p)>N(n);
            Pnew(DictN) = 0;[position,strength] = find_pattern(pattern);
            surf(Pnew,'edgecolor','none')
            view([0,0,1])
            axis tight
            subplot(2,2,3)
           
            fs  = 15;
            plot(Fall(xp))
            axis([0 length(Fall) mi ma])
            xlabel('d','fontsize',fs)
            ylabel('C(d)','fontsize',fs)
            
            
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
 
        HARD1 = (max(HARD));
         delta = [delta;time,pattern,mnew,mold,median((HARD(:,4))),mean(HARD(:,4)),mmm];
        
        
        pause(1)
    end
end

% save('SOURCE','sources','delta','-v7.3')
save('SOURCE_LL_nolog','sources','delta','-v7.3')





% Our algorithem works if left side is allways smaller then the right side
p = [1,5:9];
% Our algorithem works if left side is allways smaller then the right side
for oo = 0:5
2^oo
t = oo*9+p;
"MEDIAN"
delta(t,7:end)./log(delta(t,5))
% "MEAN"
delta(t,7:end)./log(delta(t,6))
end