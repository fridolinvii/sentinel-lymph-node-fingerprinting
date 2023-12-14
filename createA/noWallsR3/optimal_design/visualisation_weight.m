clear all 
close all

regular = 'r_Ao_';
% regular = '';


for pattern = 7
    for b = 5
        for exp = 1:8
            Str = ['weight/Ao/pattern_',num2str(pattern),'/b_',num2str(b),'/exp_',num2str(exp)];
            load(Str)
             w = w(:,end);
            
         
           
            
            figure(pattern)
            subplot(3,8,exp)
            hold on
            plot([1:length(r)],r,[1,length(r)],[0.1 0.1],'b')
            title(['Source ',num2str(pattern),'; b=',num2str(b)])
            hold off
            
            figure(pattern)
            subplot(3,8,exp+16)
            q = sort(w);
            plot(q)
            
            
            figure(pattern)
            subplot(3,8,exp+8)
            eps = 2.^-eps;
            % h = (2.^-err)*he;
            loglog(eps,error,'-o',eps,eps/100,eps,eps.^2)
%             legend('error','h','h^2')
            
            
            
            
        end
    end
end


