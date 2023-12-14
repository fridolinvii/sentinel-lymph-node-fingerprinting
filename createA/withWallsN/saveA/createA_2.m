
An = sparse(94965,285600);
Ao = An;


for n = 1:24
    disp(n)
    
     StrAn = ['A/An/A_',num2str(n)];
%    StrAo = ['A/Ao/A_',num2str(n)];
    
     an = load(StrAn);
%    ao = load(StrAo);
    
%    Ao = Ao+ao.Ao;
     An = An+an.An;
    
end




 save('A/An','An','-v7.3')
%save('A/Ao','Ao','-v7.3')
