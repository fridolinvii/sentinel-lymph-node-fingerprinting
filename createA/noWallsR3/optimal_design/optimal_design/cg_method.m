function x = cg_method(A,b,tol,maxIter)

maxIter = 100;

x = zeros(length(A(1,:)),1);
r = -b;
p = -r;
k = 0;

while norm(r)>tol && k<maxIter
%     Str = ['Iteration: ',num2str(k), '; error: ',num2str(norm(r))];
%     disp(Str);
    alpha = r'*r/(p'*A*p);
    x = x + alpha*p;
    rold = r;
    r = r + alpha*A*p;
    beta = r'*r/(rold'*rold);
    p = -r +beta*p;
    k = k+1;
%     disp([norm(r),k])
end
