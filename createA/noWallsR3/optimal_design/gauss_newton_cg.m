function [w,r] = gauss_newton_cg(K,L,v,w0,Wh,m,alpha,sigma,beta,maxit)
warning('off','all')

k = 0;
w = w0;
w_ = w0;

Jold = F(w,Wh,v,m,K,L,alpha,beta,sigma);
Jold_ = Jold+1;
s = 1;
stopper = 0;



tol = 10^-1;
DF0 = norm(DF(K,v,w,Wh,L,alpha,sigma,beta));
rResidium = 1;
r = [];
% norm(s) > tol
while  rResidium>tol && k < maxit && stopper == 0 && norm(Jold-Jold_)>10^-12
    
    
    k = k+1;
%     beta = sigma/sum(w)*0.3;
    [s,~,DF_new] = s_calc(w,Wh,v,m,K,L,alpha,beta,sigma,Jold);
    
    
    stepsize = 1;
    
    wnew = w+stepsize*s';
    wnew = max(zeros(size(wnew)),wnew);
    Jnew = F(wnew,Wh,v,m,K,L,alpha,beta,sigma);
    
    
    
    while stepsize>10^-14 && Jold<Jnew
        
        stepsize = stepsize/2;
        
        wnew = w+stepsize*s';
        wnew = max(zeros(size(wnew)),wnew);
%         beta = sigma/sum(w)*0.3;
        Jnew = F(wnew,Wh,v,m,K,L,alpha,beta,sigma);
        
        if stepsize<10^-14
            stopper = 1;
        end
        
    end
    
    
    
    
    
    w = wnew;
    w_ = [w_,wnew];
%     disp(w');
    Jold_ = Jold;
    Jold = Jnew;
    
    rResidium = DF_new/DF0;
    r = [r,rResidium];
%     Str = ['rResidium: ', num2str(rResidium), '; diff: ', num2str(DF0-DF_new)];
%     disp(Str)
    Str = ['Itteration: ',sprintf('%5.0f',k),'; reltativ residium: ',sprintf('%7.7g',rResidium),' ; J = ',sprintf('%7.4f',Jold),' ; stepsize = ',sprintf('%0.2g',stepsize), ' ;  norm(Jold-Jold_) : ', num2str(norm(Jold-Jold_))];
    disp(Str)
%     Str = [num2str(norm(s)),' > ',num2str(tol),' && ',...
%         num2str(k),' < ',num2str(maxit),' && ',...
%         num2str(stopper),' == 0 && ',...
%         num2str(norm(Jold-Jold_)), '>10^-3'];
%     disp(Str);
    
    
end


w = w_;

end

function [s,Jh,normDJh] = s_calc(w,Wh,v,m,K,L,alpha,beta,sigma,Jh)



dJh = DF(K,v,w,Wh,L,alpha,sigma,beta);
normDJh = norm(dJh);
s = -(dJh'*dJh)\(dJh'*Jh);

end




