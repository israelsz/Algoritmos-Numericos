function [mejorError,mejoresCoeficientes,mejorAproximacion,tiempo] = coeficiente3(p,s,x,tol)

tic
%% Parte inicial generar numeros aleatorios iniciales

rng(0,"twister");
a=-5;
b=5;
n=1000;
c=4;
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
        aproximacion = p(a0,a1,a2,a3,x);
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
    for i=1:4
        [muHat,sigmmaHat]=normfit(seleccion(:,i)); 
        parametros=[parametros;muHat,sigmmaHat];
    end
            
        nuevaData=[];
    
    for i=1:4
        y=normrnd(parametros(i,1),parametros(i,2),[1,n]); % funcion de probabilidad
        nuevaData=[nuevaData;y];
    end
    matrizCoef=nuevaData;

    mejorError = rank(1,1);
    mejoresCoeficientes = rank(1,2:end);
    mejorAproximacion =  p(mejoresCoeficientes(1),mejoresCoeficientes(2),mejoresCoeficientes(3),mejoresCoeficientes(4),x);
    
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
