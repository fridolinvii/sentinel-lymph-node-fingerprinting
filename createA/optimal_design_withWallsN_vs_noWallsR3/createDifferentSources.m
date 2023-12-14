clear all
close all


load pos



for numberOfSources = 1:4
    for n = 1:100
        s = source_creator(x,y,z,numberOfSources);
        
        
        source{numberOfSources,n} = s;
    end
end


save('source','source')