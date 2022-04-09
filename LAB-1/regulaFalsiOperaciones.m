function [orden] = regulaFalsiOperaciones(a,b,tol,iteraciones,f)
% Heuristica para asignar costo a las operaciones:
% Suma y resta / Condiciones y logica -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
orden = 1;
c=a;
e=abs(f(c));
orden = orden + 2 + 2 + 5;
iters=0;
convergencia=[];
error=[];
while (e>tol && iters<iteraciones )
orden = orden + 4;

c = b - f(b)*(b-a)/(f(b) - f(a));
orden = orden + 8 + 15;

if f(c) == 0
    a=c;
    b=c;
    orden = orden + 7 + 2;
end

if sign(f(a)) == sign(f(c))
    a=c;
    orden = orden + 2 + 20 + 1;
end

if sign(f(b)) == sign(f(c))
    b=c;
    orden = orden + 2 + 20 + 1;
end

e=abs(f(c));
orden = orden + 1 + 2 + 5;

error=[error,e];    
convergencia=[convergencia,c]; 
iters = iters + 1;

end


%x=xn;
end