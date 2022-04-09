function [iteraciones,errores,raices,erroresNormales,erroresAbsolutos,erroresRelativos] = newtonMultivariable(F,tolerancia,valoresExactos)
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
erroresNormales = [];
erroresAbsolutos = [];
erroresRelativos = [];

while evF > tolerancia
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
    
    %Calculo de errores
    errorNormal = norm(valoresExactos) - norm(double(X3'));
    erroresNormales = [erroresNormales, errorNormal];

    errorAbsoluto = abs(norm(valoresExactos) - norm(double(X3')));
    erroresAbsolutos = [erroresAbsolutos, errorAbsoluto];

    errorRelativo = norm(valoresExactos) - (norm(double(X3'))/norm(valoresExactos));
    erroresRelativos = [erroresRelativos, errorRelativo];
    
end

