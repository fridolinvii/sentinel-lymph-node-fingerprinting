

for n = 1:24
    
    An = [];
    Ao = [];
    for hight = 81:180

        disp([n,hight])
        
%         StrAn = ['A/An/A/A_',num2str(n),'_',num2str(hight)];
        StrAo = ['A/Ao/A/A_',num2str(n),'_',num2str(hight)];
        
%         an = load(StrAn);
        ao = load(StrAo);
        
%         An = [An,an.A];
        Ao = [Ao,ao.A];
        
    end
    
%     StrAn = ['A/An/A_',num2str(n)];
    StrAo = ['A/Ao/A_',num2str(n)];
    
%     save(StrAn,'An')
    save(StrAo,'Ao')
end

