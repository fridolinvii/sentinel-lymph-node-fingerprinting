clear all; close all;

col{1} = 'withWallsN';
col{2} = 'noWallsR3';
col{3} = 'noWallsN';


load pos;
numberOfPixel = [195 487];


numberOfSources = [1,2,3,4];


error{1} =  [];
error{2} =  [];
error{3} =  [];




K1 = [];
K2 = [];
K3 = [];
for n = 1:24
      disp(["Create matrix K: ",num2str(n), " of 24"])
    str = ['../',col{1},'/saveA/A/Ao/A_',num2str(n)];
    load(str);
    K1 = [K1;Ao];
    str = ['../',col{2},'/saveA/A/Ao/A_',num2str(n)];
    load(str);
    K2 = [K2;Ao];
    str = ['../',col{3},'/saveA/A/Ao/A_',num2str(n)];
    load(str);
    K3 = [K3;Ao];
end



for pattern = 1:9
        for c = 1:3
            s = source_creator_pattern(x,y,z,pattern);
            
            
            if c == 1
                 K = K1(:,s>0);
            elseif c == 2
                K = K2(:,s>0);
            else
                K = K3(:,s>0);
            end
            
           
            
            
            disp([col{c},"; pattern = ",num2str(pattern), " of 9"]);
            %             pause(0.1)
            Km = K'*K; Km = Km^-1; Km = Km*Km;
            V = trace(K*(Km*K'));
            
            
          
           error{c} = [error{c},V];

            
            
        end
end
save('error_pattern','error')
