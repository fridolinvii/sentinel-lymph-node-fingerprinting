clear all, close all;


K = [];
for n = 1:24
    disp(["Create matrix K: ",num2str(n), " of 24"])
    str = ['A/Ao/A_',num2str(n)];
    load(str);
    K = [K;Ao];
end

save('A/K','K','-v7.3')