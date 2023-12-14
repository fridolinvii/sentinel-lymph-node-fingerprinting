function weight = weighter(K,Wh,pattern)


pixelSize = 172e-3;
numberOfPixel = [195 487];

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel);



w1 = ones(length(holesXY),1);


maxit = 20;
sigma = 10;
alpha = 0;


for b = 1:8
    beta = 10^-b;
    
    
    
    
    
    for exp = 1:8
        
        
        m = length(K(1,:));
        L = speye(length(m));
        
        v = randi([0,1],length(holesXY),1);
        v0 = v == 0;
        v(v0) = -1;
        
        
        
        
        %% gradiant_test %%
        he = rand(size(w1));
        [error,eps ] = gradiant(K,Wh,L,holesXY,w1,m,v,he,alpha,beta,sigma);
        %             error = 0;
        %             eps = 0;
        
        
        %% gauss newton
        [w,r] = gauss_newton_cg(K,L,v,w1,Wh,m,alpha,sigma,beta,maxit);
        
        mkdir(['weight/pattern_',num2str(pattern),'/b_',num2str(b)])
        Str = ['weight/pattern_',num2str(pattern),'/b_',num2str(b),'/exp_',num2str(exp)];
        saver(Str,holesXY,x,y,z,w,r,error,eps)
        
        
    end
    
    
    
end

weight = w;

end


function saver(Str,holesXY,x,y,z,w,r,error,eps)

save(Str,'holesXY','x','y','z','w','r','error','eps')

end


function [error,err] = gradiant(K,Wh,L,holesXY,w,m,v,he,alpha,beta,sigma)

O = holesXY;
err = 4:9;

for e0 = 1:length(err)
    e = err(e0);
    h = (2^-e).*he;
    
    % dJ = f(x)-f(x+h)
    Jh = F(w+h,Wh,v,m,K,L,alpha,beta,sigma);
    J =  F(w,Wh,v,m,K,L,alpha,beta,sigma);
    
    dJ = (Jh-J);
    
    % gJ = gf(x)*h
    gJ = DF(K,v,w,Wh,L,alpha,sigma,beta)'*h;
    
    error(e0) = abs(dJ-gJ);
    
end
end
