function main_Ao(numberOfSources,exp)


% source 1 and 2 beta = 10^-2
% source 3 and 4 beta = 10^-3


% addpath ../saveDetector.m
% addpath ../source_creator.m
load data;

[detectorX,detectorY,holesXY,x,y,z] = saveDetector(pixelSize,numberOfPixel,holesCombi);



for numberOfSources = numberOfSources%1:4
    
    
    
    s = source_creator(x,y,z,numberOfSources);
    
    
    w1 = ones(length(holesXY),1);
    
    Wh = [];
    K = [];
    for k = 1:length(holesXY)
        Str = ['../A_',num2str(numberOfSources),'/Ao/A_',num2str(k)];
        load(Str)
        K = [K;A];
%         A = Ao;
        sizeA = size(A);
        oh = (k-1)*sizeA(1)+1:k*sizeA(1);
        W = zeros(sizeA(1)*length(holesXY),1);
        W(oh) = 1;
        Wh = sparse([Wh,W]);
    end
    
    
    maxit = 20;
    sigma = 10;
    alpha = 0;
    beta = 10^-3;
    
    
    
    
    
    for b = 4%1:10
        beta = 10^-b;
        
        
        
        
        
        for exp = exp%1:8
            
            
            
            
            m = s;
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
            
            
            
            
            %% Auswerten %%
            os = s>0;
            ox = x(os);
            oy = y(os);
            oz = z(os);
            
            
            q = quantile(w,.9);
            % q = 0.5*max(w(:));
            p = find(q<w);
            
%             subplot(2,3,1)
%             plot(holesXY(p,2),holesXY(p,1),'o',oy,ox,'*',holesXY(:,2),holesXY(:,1),'c.')
%             legend('activ hole', 'source position')
%             axis([-1 numberOfPixel(2)*pixelSize+1 -1 numberOfPixel(1)*pixelSize+1])
%             subplot(2,3,2)
%             o = 1:length(w);
%             plot(o,w,[1,length(w)],[q,q])
%             legend('w','cut')
%             subplot(2,3,4)
%             plot3(holesXY(:,2),holesXY(:,1),w,'.',holesXY(p,2),holesXY(p,1),w(p),'o')
%             subplot(2,3,5)
%             plot(r(2:end))
%             title('relataiv residum')

            mkdir(['Ao_source_',num2str(numberOfSources),'/b_',num2str(b)])
            Str = ['Ao_source_',num2str(numberOfSources),'/b_',num2str(b),'/exp_',num2str(exp)];
            saver(Str,holesXY,s,x,y,z,w,r,error,eps)
            
        end
    end
    
    
end
end


function saver(Str,holesXY,s,x,y,z,w,r,error,eps)

save(Str,'holesXY','s','x','y','z','w','r','error','eps')

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
