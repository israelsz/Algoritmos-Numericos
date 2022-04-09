function [orden] = newtonRaphsonOperaciones(x0,tol,iteraciones,f,df)
%xn = x0^2 - 4;
x=x0;
orden=1;
e=abs(f(x));
orden = orden + 1 + 2 + 5;
iters=0;
convergencia=[];
error=[];
%Suma y resta / Condiciones y logica -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
while (e>tol && iters<iteraciones)
    orden = orden + 1 + 3; % while -> 1 | > -> 2*1 | && -> 1
    x = x - f(x)/df(x) ; % = -> 1 | - -> 1 | / -> 2, llamada función 2*5
    orden = orden + 4 + 10;
    e=abs(f(x));
    orden = orden + 1 + 2 + 5;
    error=[error,e];    
    convergencia=[convergencia,x]; 
    iters = iters + 1;    
end
%x=xn;
end