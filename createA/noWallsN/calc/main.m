clear all
close all

addpath ../../wspgl1

ao = load('../saveA/A/Ao');

walls = 'noWalls';
col = 'N';

for time = 5:-1:3
    t = 2^time;
    for p = 1:9
        
        
        
        dis = ['pattern_',num2str(p),'_expt_',num2str(t)];
        disp(dis)
        
        
        Str = ['../Carlo/image_bearbeitet/pattern_',num2str(p),'/cut/',walls,'_',col,'_pattern_',num2str(p),'_expt_',num2str(t)];
        load(Str)
        
        
        %% omit all pixel which are not used %%
        cut = unused(:)==0;
        Ao = ao.Ao;
        
        
        %% cut area %%
        d = P_use(:)>0;
        % possible position
        qo = (Ao'*d)>0;
        
        radiantSourceAo = zeros(size(qo));

       
        Ao = ao.Ao(cut,:);
        P_use = P_use(cut);
        
        
        StrAo = ['radiantSourceAo/pattern_',num2str(p)];
        mkdir(StrAo);
        
        if sum(qo)>0
            disp(['qo_',num2str(t)])
            radiantSourceAo(qo) = wspgl1(Ao(:,qo),P_use,1);%20);
        end
        
        StrAo = ['radiantSourceAo/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
        radiantSource = radiantSourceAo;
        save(StrAo,'radiantSource');
        
        
        
       
        
        
        
    end
end
