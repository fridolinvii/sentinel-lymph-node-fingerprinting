
An = sparse(94965,514080);
Ao = An;


for n = 1:24
    disp(n)
    
    StrAn = ['A/An/A_',num2str(n),'_all'];
%     StrAo = ['A/Ao/A_',num2str(n),'_all'];
    
   an = load(StrAn);
%     ao = load(StrAo);
    
%     Ao = Ao+ao.Ao;
   An = An+an.An;
    
end



save('A/An_all','An','-v7.3')
% save('A/Ao_all','Ao','-v7.3')
