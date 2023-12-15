function Ao = lowpassfilt(A,siz)

A = reshape(full(A),siz);


Ao = zeros(size(A,1)+4,size(A,2)+4);
Az = zeros(size(A,1)+4,size(A,2)+4);
Ao(3:end-2,3:end-2) = A;
Az(3:end-2,3:end-2) = A;

% w = [sqrt(8),sqrt(2),sqrt(5),1,2];
% wn = [4, 4, 8,4,4];
% W = w*wn';
% Ao = 1/W*( w(1)*(Ao(


% L
% Ao = 1/24*(... 
%      (Ao(2:end-3,3:end-2)+Ao(3:end-2,2:end-3)+Ao(4:end-1,3:end-2)+Ao(3:end-2,4:end-1))+...
%      (Ao(1:end-4,3:end-2)+Ao(3:end-2,1:end-4)+Ao(5:end,3:end-2)+Ao(3:end-2,5:end))+...
%      (Ao(2:end-3,2:end-3)+Ao(2:end-3,4:end-1)+Ao(4:end-1,2:end-3)+Ao(4:end-1,4:end-1))+...
%      (Ao(1:end-4,1:end-4)+Ao(1:end-4,5:end)+Ao(5:end,1:end-4)+Ao(5:end,5:end))+...
%      (Ao(1:end-4,2:end-3)+Ao(2:end-3,1:end-4)+Ao(5:end,4:end-1)+Ao(4:end-1,5:end))+...
%      (Ao(1:end-4,4:end-1)+Ao(4:end-1,1:end-4)+Ao(5:end,2:end-3)+Ao(2:end-3,5:end))...
%      );
 

%LL
for i = 1:2
 Ao(3:end-2,3:end-2) = 1/24*(... 
     (Ao(2:end-3,3:end-2)+Ao(3:end-2,2:end-3)+Ao(4:end-1,3:end-2)+Ao(3:end-2,4:end-1))...
     +(Ao(1:end-4,3:end-2)+Ao(3:end-2,1:end-4)+Ao(5:end,3:end-2)+Ao(3:end-2,5:end))...
     +(Ao(2:end-3,2:end-3)+Ao(2:end-3,4:end-1)+Ao(4:end-1,2:end-3)+Ao(4:end-1,4:end-1))...
     +(Ao(1:end-4,1:end-4)+Ao(1:end-4,5:end)+Ao(5:end,1:end-4)+Ao(5:end,5:end))...
     +(Ao(1:end-4,2:end-3)+Ao(2:end-3,1:end-4)+Ao(5:end,4:end-1)+Ao(4:end-1,5:end))...
     +(Ao(1:end-4,4:end-1)+Ao(4:end-1,1:end-4)+Ao(5:end,2:end-3)+Ao(2:end-3,5:end))...
     );
%  imagesc(Ao);
 
 Ao(Ao<0.5) = 0;
%  pause(1)
end

 

Ao = Ao(3:end-2,3:end-2);


end