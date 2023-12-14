clear all
close all

addpath ../../wspgl1

ao = load('../saveA/A/Ao');

walls = 'withWalls';
col = 'N';

for time = 3:5
    t = 2^time;
    for p = 1:9
        
        
        
        dis = ['pattern_',num2str(p),'_expt_',num2str(t)];
        disp(dis)
        
        
        Str = ['../Carlo/image_bearbeitet/pattern_',num2str(p),'/cut/',walls,'_',col,'_pattern_',num2str(p),'_expt_',num2str(t)];
        load(Str)
        
        
        %% omit all pixel which are not used %%
        cut = unused(:)==0;
        Str = ['radiantSourceAo/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
        load(Str);
        
        % possible position
        qo = imgaussfilt(radiantSource,1)>0;
        
        radiantSourceAo = zeros(size(qo));


        Ao = ao.Ao(cut,:);
        P_use = P_use(cut);
        
        
        StrAo = ['radiantSourceAo_new/pattern_',num2str(p)];
        mkdir(StrAo);
        
        if sum(qo)>0
            disp(['qo_',num2str(t)])
            radiantSourceAo(qo) = wspgl1(Ao(:,qo),P_use,50);
        end
        
        StrAo = ['radiantSourceAo_new/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
        radiantSource = radiantSourceAo;
        save(StrAo,'radiantSource');
        
        
        
       
        
        
        
    end
end
