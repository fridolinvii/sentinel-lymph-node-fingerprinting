clear all
close all

regular = 'r_Ao_';
% regular = '';


for rot = 25%[ 0 25]
    for dist = [ 20]%[0 5 10 15 20 25]
        for b = 3
            
            for exp = 1:8
                Str = ['weight/special_experiment/rot_',num2str(rot),'/dist_',num2str(dist),'/b_',num2str(b),'/exp_',num2str(exp)];
                load(Str)
                w = w(:,end);
                
                
                
                
                figure(dist+1)
                subplot(3,8,exp)
                hold on
                plot([1:length(r)],r,[1,length(r)],[0.1 0.1],'b')
                title(['Source ',num2str(dist),'; b=',num2str(b)])
                hold off
                
                figure(dist+1)
                subplot(3,8,exp+16)
                q = sort(w);
                plot(q)
                
                
                figure(dist+1)
                subplot(3,8,exp+8)
                eps = 2.^-eps;
                % h = (2.^-err)*he;
                loglog(eps,error,'-o',eps,eps/100,eps,eps.^2)
                %             legend('error','h','h^2')
                
                
                
            end
        end
    end
end


