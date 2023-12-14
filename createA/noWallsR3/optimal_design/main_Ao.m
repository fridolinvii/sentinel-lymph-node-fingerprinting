clear all
close all

addpath ../../wspgl1

ao = load('../saveA/A/Ao');
%an = load('../saveA/A/An');

pixelSize = 172e-3;
numberOfPixel = [195 487];
[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);



for n = 4:-1:3
    for p = 1:9
        walls = 'noWalls';
        col = 'R3';
        
        %:-1:0
        
        
        t = 2^n;
        
        dis = ['pattern_',num2str(p),'_expt_',num2str(t)];
        disp(dis)
        
        
        Str = ['../Carlo/image_bearbeitet/pattern_',num2str(p),'/cut/',walls,'_',col,'_pattern_',num2str(p),'_expt_',num2str(t)];
        load(Str)
        Str = ['../calc/radiantSourceAo/pattern_',num2str(p),'/radiantSource_expt_',num2str(t),'.mat'];
        load(Str)
        
        
        %% find optimal design for given sparse activityroom %%
        %         weight  = optimal_design(radiantSource,P_use>0,p,0);
        
        %% create new weighted A %%
        cut = unused(:)==0;
        [~,Ao]  = optimal_design(radiantSource,cut,p,1);
        radiantSource = imgaussfilt(reshape(radiantSource,size(x)),1);
        %         qo = radiantSource(:) > (0.25*max(radiantSource(:)));
        
        
        
        %% cut area %%
        d = P_use(:)>0;
        dc = medfilt2(P_use==0);
        dc = dc(:) == 0;
        % possible position
        %    vn = (An'*d);
        vo = (Ao'*d);
        % impossible position
        %    vcn = (An'*dc);
        vco = (Ao'*dc);
        
        % limited possible position
        %   qn = (vn.*vcn)>0;
        qo = (vo.*vco)>0;
        

        Ao = ao.Ao(cut,:);
        P_use = P_use(cut);

        
        
        StrAo = ['radiantSourceAo/pattern_',num2str(p)];
        %    StrAn = ['radiantSourceAn/pattern_',num2str(p)];
        
        mkdir(StrAo);% mkdir(StrAn);
        
        
        radiantSourceAo =  zeros(size(radiantSource));
        if sum(qo)>0
            disp(['qo_',num2str(n)])
            radiantSourceAo(qo) = wspgl1(Ao(:,qo),P_use);
        end
        
        StrAo = ['radiantSourceAo/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
        radiantSource = radiantSourceAo;
        save(StrAo,'radiantSource');
        
        
        
        
        % if sum(qn)>0
        %     disp(['qn_',num2str(n)])
        %     radiantSourceAn(qn) = wspgl1(An(:,qn),P_use);
        
        %        q = radiantSourceAn>0;
        %        radiantSourceAn(q) = wspgl1(An(:,q),P_use);
        % end
        
        % StrAn = ['radiantSourceAn/pattern_',num2str(p),'/radiantSource_expt_',num2str(t)];
        % radiantSource = radiantSourceAn;
        % save(StrAn,'radiantSource');
        
        
        
        
    end
end
