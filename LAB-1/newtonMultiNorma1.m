function [iteraciones,errores,raices,erroresNorma1] = newtonMulti2(F,tolerancia,valoresExactos)
syms x y z
iteraciones = [];
raices = [];
errores = [];
iters = 0;
X1 = [1;1;1];
X2 = [0;0;0];
X3 = X1;
evF = 100000000000;
iteraciones = 1;
erroresNorma1 = [];

% errorAbsoluto = abs(valorReal - valorAproximado);
%error entre x1 y valoresExactos
v1 = abs(valoresExactos(1) - X1(1));
v2 = abs(valoresExactos(2) - X1(2));
v3 = abs(valoresExactos(3) - X1(3));
vectorErrorAbs = [v1,v2,v3];
sumatoria = 0;

for i = 1: 3
    sumatoria = sumatoria + abs(vectorErrorAbs(i));
end
errorNorma1 = sumatoria;
%erroresNorma1 = [erroresNorma1, errorNorma1];
sumatoria = 0;

while errorNorma1 > tolerancia
    jacobiano = jacobian(F);
    evJ = subs(jacobiano, {x; y; z}, X1);
    evF = subs(F, {x; y; z}, X1);
    inversa = inv(evJ);
    Y = -inversa*evF;
    X2 = X1 + Y;
    X3 = X1;
    X1 = X2;
    iters = iters + 1;
    iteraciones = [iteraciones, iters];
    errores = [errores, abs(X2-X3)];

    evF = double(subs(F, {x; y; z}, X1));
    evF = sqrt(sum((evF).^2));
    raices = [raices;double(X3')];
    iteraciones = iteraciones + 1;
   
    %Actualizacion error norma 1
    nuevasRaices = double(X3');
    v1 = abs(valoresExactos(1) - nuevasRaices(1));
    v2 = abs(valoresExactos(2) - nuevasRaices(2));
    v3 = abs(valoresExactos(3) - nuevasRaices(3));
    vectorErrorAbs = [v1,v2,v3];
    sumatoria = 0;

    for i = 1: 3
        sumatoria = sumatoria + abs(vectorErrorAbs(i));
    end
    errorNorma1 = sumatoria;
    erroresNorma1 = [erroresNorma1, errorNorma1];
    sumatoria = 0;

    
end