clear all, close all

load SOURCE_LL


for pattern =  [1  4 5 6 7 8 9]
    
    for time =  [1 2 4 8 16 32]
        [pos,strength] = find_pattern(pattern);
        
        rec = sources{time,pattern}.position(1:end,:);
        
        
        err = 1e10*ones(size(pos,1),1);
        errpos = zeros(size(rec,1),3);
        for i = 1:size(rec,1)-1
            for j = 1:size(pos,1)
                e = norm(pos(j,:)-rec(i,:));
                if(err(i)>= e)
                    err(i) = e;
                    errpos(i,:) = pos(j,:);
                end
            end
        end
        
        
        pattern
        rec
        errpos
        err
        mean(err)
        
        error{time,pattern}.rec = rec;
        error{time,pattern}.err = err;
        error{time,pattern}.errpos = errpos;
        
        
    end
end

save('error','error')