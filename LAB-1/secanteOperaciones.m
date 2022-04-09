function [orden] = secanteOperaciones(x0,x1,tol,iteraciones,f)
% Heuristica para asignar costo a las operaciones:
% Suma y resta / Condiciones y logica -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
orden = 1;
e=abs(f(x0));
orden = orden + 1 + 2 + 5;
iters=0;
convergencia=[];
error=[];

while (e>tol && iters<iteraciones)  
 orden = orden + 4;
 xn = x1 - f(x1)*(x1 - x0)/( f(x1) - f(x0) + 10e-15);
 orden = orden + 9 + 15;

 x1 = x0;
 x0 = xn;
 orden = orden + 2;
 
 %X = abs(x1 - x0);
 e=abs(f(xn));
 orden = orden + 1 + 2 + 5;
 error=[error,e];    
 convergencia=[convergencia,xn]; 
 iters = iters + 1  ; 
end
%x=xn;
end