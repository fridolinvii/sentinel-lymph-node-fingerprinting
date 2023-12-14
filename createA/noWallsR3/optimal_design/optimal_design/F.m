function J = F(w0,Wh,v,m,K,L,alpha,beta,sigma)


w = Wh*w0;
v = Wh*v;

tolcg = 10^-1;


lw = length(w);
W = spdiags(w,0,lw,lw);

lv = length(v);
Vd = spdiags(v,0,lv,lv);


C = K'*W*K;

%% calc \hat{B}


Bh = 0;


%% calc \hat{V}


V = Vd*w;
V = K'*V;
V = cg_method(C,V,tolcg,1000);

Vh = V'*V;

%% calc \hat{J}

J = alpha^2*Bh + sigma^2*Vh + beta*sum(w0);

end