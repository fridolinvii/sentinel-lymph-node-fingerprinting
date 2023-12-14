clear all
close all

addpath ../../wspgl1

ao = load('../saveA/A/Ao');
an = load('../saveA/A/An');
% an = load('../saveA/A/A_low');
% an.An = an.A_low;



p = 1;
walls = 'withWalls';
col = 'R1';

for n = 16%5:-1:0
    
    
    t = 2^n;
    
    dis = ['pattern_',num2str(p),'_expt_',num2str(t)];
    disp(dis)
    
    
    Str = ['../Carlo/image_bearbeitet/pattern_',num2str(p),'/cut/',walls,'_',col,'_pattern_',num2str(p),'_expt_',num2str(t)];
    load(Str)
    
    
    %% omit all pixel which are not used %%
    cut = unused(:)==0;
%     An = an.An(cut,:);
%     Ao = ao.Ao(cut,:);
%     P_use = P_use(cut);

    An = an.An;
    Ao = ao.Ao;

    
    %% cut area %%
    d = P_use(:)>0;
    dc = medfilt2(P_use==0);
    dc = dc(:) == 0;
    % possible position
    vn = (An'*d);
    vo = (Ao'*d);
    % impossible position
    vcn = (An'*dc);
    vco = (Ao'*dc);
    
    % limited possible position 
    qn = (vn.*vcn)>0;
    qo = (vo.*vco)>0;
    
%     qn = vn>0;
%     qo = vo>0;
    
    
    radiantSourceAo = zeros(size(vo));
    radiantSourceAn = zeros(size(vn));
    
    An = an.An(cut,:);
    Ao = ao.Ao(cut,:);
    P_use = P_use(cut);
    
    
    StrAo = ['radiantSourceAo/pattern_',num2str(p)];
    StrAn = ['radiantSourceAn/pattern_',num2str(p)];
    
    mkdir(StrAo); mkdir(StrAn);
    
    if sum(qo)>0
        disp(['qo_',num2str(n)])
        radiantSourceAo(qo) = wspgl1(Ao(:,qo),P_use);
        
%        q = radiantSourceAo>0;
%        radiantSourceAo(q) = wspgl1(Ao(:,q),P_use);
    end
    
    StrAo = ['radiantSourceAo/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
    radiantSource = radiantSourceAo;
    save(StrAo,'radiantSource');
    
    
    
    
    if sum(qn)>0
        disp(['qn_',num2str(n)])
        radiantSourceAn(qn) = wspgl1(An(:,qn),P_use);
        
%        q = radiantSourceAn>0;
%        radiantSourceAn(q) = wspgl1(An(:,q),P_use);
    end
    
    StrAn = ['radiantSourceAn/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
    radiantSource = radiantSourceAn;
    save(StrAn,'radiantSource');
    
    
    
    
end
