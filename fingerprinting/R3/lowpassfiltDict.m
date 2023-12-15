clear all

load Ao %This is the matrix: Au=d

Dict = Ao;
clear Ao;

pattern = 1; time = 1;
load(['image_bearbeitet/pattern_',num2str(pattern),'/uncut/noWalls_R3_pattern_',num2str(pattern),'_expt_',num2str(time),'.mat'])
siz = size(P);

M = 10000;
Dict0 = zeros(numel(P),10000);
tic
for i = 1:size(Dict,2)
    
    if mod(i,M) == 0
        j = M;
    else 
        j = mod(i,M);
    end
        
    A = Dict(:,i);
    Ao = lowpassfilt(A,siz);
    Dict0(:,j) = sparse(Ao(:));
    
    
     if mod(i,M) == 0
        disp([num2str(i),' of ', num2str(size(Dict,2))])
        Dict(:,i-M+1:i) = sparse(Dict0);
        toc
        tic
        LAST = i;
     end
   
end
 Dict(:,LAST+1:end) = sparse(Dict0(:,1:j));

save('DictLLN','Dict','-v7.3');