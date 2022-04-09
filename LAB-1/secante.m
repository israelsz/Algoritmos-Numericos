function [xn,convergencia,errores,error,erroresPriori,tiempoSecante] = secante(x0,x1,tol,iteraciones,f,df1,d2f1,r)
%xn = x0^2 - 4;
%xn=x0;
tic;
e=abs(f(x0));
iters=0;
convergencia=[];
errores=[];
erroresPriori=[];
en = e;

xn = x1 - f(x1)*(x1 - x0)/( f(x1) - f(x0) + 10e-15);
x1 = x0;
x0 = xn; 

%X = abs(x1 - x0);
e=abs(f(xn));
errores=[errores,e];    
convergencia=[convergencia,xn]; 
iters = iters + 1  ; 
error = e;
en1 = e;

prioriSec = 1/2 * (d2f1(r)/df1(r)) * en * en1;
erroresPriori=[erroresPriori,prioriSec];
en1 = en;
en = prioriSec;


while (e>tol && iters<iteraciones)  
% S =    f(x1) - f(x0)
 xn = x1 - f(x1)*(x1 - x0)/( f(x1) - f(x0) + 10e-15);
 x1 = x0;
 x0 = xn; 
 
 %X = abs(x1 - x0);
 e=abs(f(xn));
 errores=[errores,e];    
 convergencia=[convergencia,xn]; 
 iters = iters + 1  ; 
 error = e;

 prioriSec = 1/2 * (d2f1(r)/df1(r)) * en * en1;
 erroresPriori=[erroresPriori,prioriSec];
 en1 = en;
 en = prioriSec;

end
tiempoSecante = toc;
%x=xn;
end

