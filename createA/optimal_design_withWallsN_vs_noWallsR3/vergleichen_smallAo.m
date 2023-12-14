clear all, close all;

load source;

Str{1} = '../noWallsR3/saveA/A/Ao.mat';
Str{2} = '../noWalls_1/saveA/A/Ao.mat';
Str{3} = '../noWalls_2/saveA/A/Ao.mat';
Str{4} = '../noWalls_3/saveA/A/Ao.mat';
Str{5} = '../noWalls_4/saveA/A/Ao.mat';
Str{6} = '../withWallsN/saveA/A/Ao.mat';




for col = 1:6
    load(Str{col});
    
    for numberOfSource = 1:4
        error = [];
        for n = 1:5
            
            s = source{numberOfSource,n};
            
            Ks = Ao(:,s(:)>0);
            Km = Ks'*Ks; 
            Km = Km^-1; Km = Km*Km;
            V = trace(Ks*(Km*Ks'));

            
            error = [error,V];
            
        end
        
        errorAll{col,numberOfSource} = error;
        
        
        disp(['Collimator = ',num2str(col),'; numberOfSource = ',num2str(numberOfSource),'; Value = ',num2str(mean(error))])
        
    end
end


% save('errorAll','errorAll');