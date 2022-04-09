function [mejorError,mejoresCoeficientes,mejorAproximacion,tiempo] = coeficiente18(p,s,x,tol)

tic
%% Parte inicial generar numeros aleatorios iniciales

rng(0,"twister");
a=-5e-36;
b=5e-36;
n=1000;
c=19;
matrizCoef=[];
for i=1:n
    r = (b-a).*rand(c,1) + a;
    matrizCoef=[matrizCoef,r];
end

errorAnterior = 1.79e+308;
%% Comienzo de simulacion
for m=1:22
    aproxMatrix = [];
    for k=1:size(matrizCoef,2)
        a0 = matrizCoef(1,k);
        a1 = matrizCoef(2,k);
        a2 = matrizCoef(3,k);
        a3 = matrizCoef(4,k);
        a4 = matrizCoef(5,k);
        a5 = matrizCoef(6,k);
        a6 = matrizCoef(7,k);
        a7 = matrizCoef(8,k);
        a8 = matrizCoef(9,k);
        a9 = matrizCoef(10,k);
        a10 = matrizCoef(11,k);
        a11 = matrizCoef(12,k);
        a12 = matrizCoef(13,k);
        a13 = matrizCoef(14,k);
        a14 = matrizCoef(15,k);
        a15 = matrizCoef(16,k);
        a16 = matrizCoef(17,k);
        a17 = matrizCoef(18,k);
        a18 = matrizCoef(19,k);
        aproximacion = p(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,x);
        aproxMatrix = [aproxMatrix;aproximacion];  
    end
    
    % Se mide el error obtenido
    matrizErrores=[];
    for j=1:n
        errores=sqrt(mse(s-aproxMatrix(j,:))); %RMSE
        matrizErrores=[matrizErrores;errores,matrizCoef(:,j)'];
    end
    
    %Eleccion del 5 por ciento de los mejores resultados
    
    rank=sortrows(matrizErrores,1);
    M=ceil(0.05*n);
    seleccion=rank(1:M,2:end);
    parametros=[];

     %% II Parte de optimizacion
    for i=1:19
        [muHat,sigmmaHat]=normfit(seleccion(:,i)); 
        parametros=[parametros;muHat,sigmmaHat];
    end
               
        nuevaData=[];
    
    for i=1:19
        y=normrnd(parametros(i,1),parametros(i,2),[1,n]); % funcion de probabilidad
        nuevaData=[nuevaData;y];
    end
    matrizCoef=nuevaData;
    
    mejorError = rank(1,1);
    mejoresCoeficientes = rank(1,2:end);
    mejorAproximacion =  p(mejoresCoeficientes(1),mejoresCoeficientes(2),mejoresCoeficientes(3),mejoresCoeficientes(4), mejoresCoeficientes(5),mejoresCoeficientes(6),mejoresCoeficientes(7),mejoresCoeficientes(8),mejoresCoeficientes(9),mejoresCoeficientes(10), mejoresCoeficientes(11),mejoresCoeficientes(12),mejoresCoeficientes(13),mejoresCoeficientes(14),mejoresCoeficientes(15),mejoresCoeficientes(16),mejoresCoeficientes(17),mejoresCoeficientes(18),mejoresCoeficientes(19),x);
    
    %Condicion de parada, para si el error es menor a tol o si la
    %diferencia entre los errores consguidos es menor a 0.001, o sea ya no
    %esta variando
    if mejorError < tol
        tiempo = toc;
        return;
    end
    errorAnterior = mejorError;

end
tiempo = toc;
end