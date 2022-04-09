function [x,convergencia,errores,error,erroresPriori,tiempoNewtonRaphson] = newtonRaphson(x0,tol,iteraciones,f,df,d2f1,r)
%xn = x0^2 - 4;
tic;
x=x0;
e=abs(f(x));
iters=0;
convergencia=[];
errores=[];
erroresPriori=[];
prioriNR1 = 1/2 * (d2f1(r)/df(r)) * e^2;
erroresPriori=[erroresPriori,prioriNR1];
while (e>tol && iters<iteraciones )
    x = x - f(x)/df(x) ;   
    e=abs(f(x));
    errores=[errores,e];    
    convergencia=[convergencia,x]; 
    iters = iters + 1;
    error = e;
    prioriNR1 = 1/2 * (d2f1(r)/df(r)) * e^2;
    erroresPriori=[erroresPriori,prioriNR1];
end
%x=xn;
tiempoNewtonRaphson = toc;
end
