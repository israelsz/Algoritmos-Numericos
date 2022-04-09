function [c,convergencia,errores,error,tiempoRegulaFalsi] = regulaFalsi(a,b,tol,iteraciones,f)
%xn = x0^2 - 4;
tic;
c=a;
e=abs(f(c));
iters=0;
convergencia=[];
errores=[];
while (e>tol && iters<iteraciones )

%c = b - f(b)*(b-a)/(f(b) - f(a));
c = b - f(b)*(b-a)/(f(b) - f(a) + 10e-15);

if f(c) == 0
    a=c;
    b=c;
end

if sign(f(a)) == sign(f(c))
    a=c;
    %b=c;
end

if sign(f(b)) == sign(f(c))
    %a=c;
    b=c;
end

e=abs(f(c));
errores=[errores,e];    
convergencia=[convergencia,c]; 
iters = iters + 1;
error = e;
end


tiempoRegulaFalsi = toc;
%x=xn;
end
