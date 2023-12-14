

    function dJh = DF(K,v,w0,Wh,L,alpha,sigma,betas)
        
        w = Wh*w0;
        v = Wh*v;
    
        tolcg = 10^-1;
        %%%%%%%%%%%%%%% d\hat{V} %%%%%%%%%%%%%%%%%5 
        
        lv = length(v);
        Vdiag = spdiags(v,0,lv,lv);
        
        lw = length(w);
        Wdiag = spdiags(w,0,lw,lw);
        
        C = K'*Wdiag*K;
        
        %% rv %%
        rv = Vdiag*w;
        rv = K'*rv;
%         Calpha = C+alpha*L'*L;
        Calpha = C;
        
%         rv = Calpha\rv;
        

        rv = cg_method(Calpha,rv,tolcg,10000);

        
        %% create diagonal %%
        d = K*rv;  
        % ld = length(d(:,1));
        % D = spdiags(d,0,ld,ld);
        D = Wh.*d; 
        
        
        %% calculate d\hat{V} %%
%         C1 = C'\rv;
        c = cg_method(C',rv,tolcg,10000);
        c = K*c;
        
%         dVh = 2*(Vdiag'*c - D'*c);
        dVh = 2*((Vdiag*Wh)' - D')*c;
                
        %%
        dBh = 0;
        %%%%%%%%%%%%%%% d\hat{J} %%%%%%%%%%%%%%%%%5 
        
        %e = ones(size(dVh));
%         e = sum(Wh)';
        e = ones(size(w0));
        
        dJh = alpha^2*dBh+sigma^2*dVh+betas*e;
        
        
        
    end
        
