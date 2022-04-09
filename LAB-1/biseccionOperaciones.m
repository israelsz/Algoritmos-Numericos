function [orden] = biseccionOperaciones(a,b,tol,iteraciones,f)
% Heuristica para asignar costo a las operaciones:
% Suma y resta / Condiciones y logica -> costo 1
% Multiplicacion y division -> costo 2
% Llamada función -> costo 5
orden = 1;
c=a;
e=abs(f(c));
orden = orden + 1 + 2 + 5;
iters=0;
convergencia=[];
error=[];
while (e>tol && iters<iteraciones )
orden = orden + 1 + 3;

c = a + (b-a)/2;
orden = orden + 5;

if f(c) == 0
    a=c;
    b=c;
    orden = orden + 7;
end

if sign(f(a)) == sign(f(c))
    a=c;
    orden = orden + 2 + 40;
end

if sign(f(b)) == sign(f(c))
    b=c;
    orden = orden + 2 + 40;
end

e=abs(f(c));
orden = orden + 1 + 2 + 5;

error=[error,e];    
convergencia=[convergencia,c]; 
iters = iters + 1;

end

%x=xn;
end