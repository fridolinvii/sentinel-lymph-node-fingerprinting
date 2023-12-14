function [position,strength] = find_pattern(pattern)

switch pattern
    case 1
        position = [21 41 130];
        strength = 60;
    case 2
        position = [21 41 130;...
            21 41 150];
        strength = [60;30];
    case 3
        position = [21 41 130;...
            21 41 110];
        strength = [60;30];
    case 4
        position = [21 41 130;...
            16 21 130];
        strength = [30;60];
    case 5
        position = [21 41 130;...
            26 21 110];
        strength = [60;30];
    case 6
        position = [21 41 110;...
            21 41 150];
        strength = [60;30];
    case 7
        position = [16 21 130;...
            26 61 130];
        strength = [60;30];
    case 8
        position = [21 41 130;...
            26 61 150;...
            16 21 130];
        strength = [60;30;15];
    case 9
        position = [21 41 150;...
            16 21 130;...
            26 21 110];
        strength = [30;60;15];
end

end