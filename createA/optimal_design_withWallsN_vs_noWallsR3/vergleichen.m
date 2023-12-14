% clear all; close all;
% 
% col{1} = 'withWallsN';
% col{2} = 'noWallsR3';
% col{3} = 'noWallsN';
% 
% 
% load pos;
% numberOfPixel = [195 487];
% 
% 
% numberOfSources = [1,2,3,4];
% 
% 
% error1{1} =  [];
% error1{2} =  [];
% error1{3} =  [];
% error2{1} =  [];
% error2{2} =  [];
% error2{3} =  [];
% error3{1} =  [];
% error3{2} =  [];
% error3{3} =  [];
% error4{1} =  [];
% error4{2} =  [];
% error4{3} =  [];
% 
% 
% 
% 
% K1 = [];
% K2 = [];
% K3 = [];
% for n = 1:24
%       disp(["Create matrix K: ",num2str(n), " of 24"])
%     str = ['../',col{1},'/saveA/A/Ao/A_',num2str(n)];
%     load(str);
%     K1 = [K1;Ao];
%     str = ['../',col{2},'/saveA/A/Ao/A_',num2str(n)];
%     load(str);
%     K2 = [K2;Ao];
%     str = ['../',col{3},'/saveA/A/Ao/A_',num2str(n)];
%     load(str);
%     K3 = [K3;Ao];
% end



for nos = 1 %[3 4 2 1]
    for t = 1:100
        for c = 1:3
            s = source_creator(x,y,z,numberOfSources(nos));
            
            
            if c == 1
                 K = K1(:,s>0);
            elseif c == 2
                K = K2(:,s>0);
            else
                K = K3(:,s>0);
            end
            
           
            
            
            disp([col{c},"; t = ",num2str(t), " of 100; nos = ",num2str(nos)]);
                        pause(0.1)
            Km = K'*K; Km = Km^-1; Km = Km*Km;
            V = trace(K*(Km*K'));
            
            
            if nos == 1
                error1{c} = [error1{c},V];
            end
            if nos == 2
                error2{c} = [error2{c},V];
            end
            if nos == 3
                error3{c} = [error3{c},V];
            end
            if nos == 4
                error4{c} = [error4{c},V];
            end
            
            % save('error100','error1','error2','error3','error4')
        end
        
        
        
    end
end

% save('error100','error1','error2','error3','error4')
