clear all, close all;

load source;

Str{1} = '../noWallsR3/saveA/A/K.mat';
Str{2} = '../noWalls_1/saveA/A/K.mat';
Str{3} = '../noWalls_2/saveA/A/K.mat';
Str{4} = '../noWalls_3/saveA/A/K.mat';
Str{5} = '../noWalls_4/saveA/A/K.mat';
Str{6} = '../withWallsN/saveA/A/K.mat';




for col = 6 %1:6
    load(Str{col});
    
    for numberOfSource = 1:4
        error = [];
        for n = 1:100
            
            s = source{numberOfSource,n};
            
            Ks = K(:,s(:)>0);
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