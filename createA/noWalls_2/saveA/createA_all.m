

for n = 1:24
    

    Ao = [];
    for hight = 1:180

        disp([n,hight])
        
        StrAo = ['A/Ao/A/A_',num2str(n),'_',num2str(hight)];
        

        ao = load(StrAo);
        Ao = [Ao,ao.A];
        
    end

    StrAo = ['A/Ao/A_',num2str(n),'_all'];

    save(StrAo,'Ao','-v7.3')
end

