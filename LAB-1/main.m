%Lab N°1 Algoritmos Numericos
%Israel Arias Panez

f1 = @(x) x^2 - 60;
df1 = @(x) 2*x;
d2f1 = @(x) 2;

f2 = @(x) x^3 - 2*x^2 + log(2*x + 1);
df2 = @(x) 3*x^2 - 4*x + (2/(2*x+1));
d2f2 = @(x) 6*x - 4 - (4/((2*x+1)^2));

% Se fija la tolerancia y las iteraciones a ocupar
tol = 0.0000000001;
iteraciones = 10000;

%% Primera funcion
a = 7;
b = 8;

%Error a priori Bisección
%Considerando 36 iteraciones
Niteraciones = 36;
prioriBi1 = 2^-(Niteraciones+1)*(b-a);

% Bisección
[SBI,convergenciaBI,erroresBI,errorBI,tiempoBiseccion] = biseccion(a,b,tol,iteraciones,f1);

% Se mide la cantidad de operaciones usadas por biseccion
[cantidadOperacionesBiseccion] = biseccionOperaciones(a,b,tol,iteraciones,f1);

%Para Error a priori Secante
%Considerando r entre [a,b]
r = 7.5;

% Secante
[SEC,convergenciaSEC,erroresSEC,errorSEC,erroresPrioriSEC,tiempoSecante] = secante(a,b,tol,iteraciones,f1,df1,d2f1,r);
errorPrioriMinimoSEC = erroresPrioriSEC(5);

%Se mide la cantidad de operaciones usadas por el método de la secante
[cantidadOperacionesSecante] = secanteOperaciones(a,b,tol,iteraciones,f1);

%Error a priori Regula Falsi
%Considerando 36 iteraciones 
Niteraciones = 36;
prioriRF1 = 2^-(Niteraciones+1)*(b-a);
% Regula Falsi
[SRF,convergenciaRF,erroresRF,errorRF,tiempoRegulaFalsi] = regulaFalsi(a,b,tol,iteraciones,f1);

%Se mide la cantidad de operaciones usadas por el método Regula Falsi
[cantidadOperacionesRegulaFalsi] = regulaFalsiOperaciones(a,b,tol,iteraciones,f1);

%Para error a priori Newton Raphson, se considera r entre [a,b]
% Newton-Raphson
x0 = 7;
r=7;
[SNR,convergenciaNR,erroresNR,errorNR,erroresPrioriNR,tiempoNewtonRaphson] = newtonRaphson(x0,tol,iteraciones,f1,df1,d2f1,r);
errorMinimoPrioriNR = erroresPrioriNR(4);

%Se mide la cantidad de operaciones usadas por el método Newton Raphson
[cantidadOperacionesNewtonRaphson] = newtonRaphsonOperaciones(x0,tol,iteraciones,f1,df1);

% Tabla de costos temporales, espaciales, error y error a priori de cada método para f1
Metodo = {'Bisección';'Secante';'Regula Falsi';'Newton Raphson'};
CostosTemporales = [tiempoBiseccion; tiempoSecante; tiempoRegulaFalsi; tiempoNewtonRaphson];
CostosEspaciales = [cantidadOperacionesBiseccion; cantidadOperacionesSecante; cantidadOperacionesRegulaFalsi; cantidadOperacionesNewtonRaphson];
Error = [errorBI; errorSEC; errorRF; errorNR];
ErrorPriori = [prioriBi1; errorPrioriMinimoSEC; prioriRF1; errorMinimoPrioriNR ];
T1 = table(Metodo, CostosTemporales, CostosEspaciales, Error, ErrorPriori);

%% Segunda funcion
a = -0.2;
b = 0.2;

%Error a priori Bisección
%Considerando 1 iteración
Niteraciones = 1;
prioriBi2 = 2^-(Niteraciones+1)*(b-a);

% Bisección
[SBI2,convergenciaBI2,erroresBI2,errorBI2,tiempoBiseccion2] = biseccion(a,b,tol,iteraciones,f2);

% Se mide la cantidad de operaciones usadas por biseccion
[cantidadOperacionesBiseccion2] = biseccionOperaciones(a,b,tol,iteraciones,f2);

%Para error a priori Secante
%Considerando r entre [a,b]
r = -0.1;

% Secante
[SEC2,convergenciaSEC2,erroresSEC2,errorSEC2,erroresPrioriSEC2,tiempoSecante2] = secante(a,b,tol,iteraciones,f2,df1,d2f1,r);
errorPrioriMinimoSEC2 = erroresPrioriSEC2(1);
%Se mide la cantidad de operaciones usadas por el método de la secante
[cantidadOperacionesSecante2] = secanteOperaciones(a,b,tol,iteraciones,f2);

%Error a priori Regula Falsi
%Considerando 21 iteraciones 
Niteraciones = 21;
prioriRF2 = 2^-(Niteraciones+1)*(b-a);

% Regula Falsi
[SRF2,convergenciaRF2,erroresRF2,errorRF2,tiempoRegulaFalsi2] = regulaFalsi(a,b,tol,iteraciones,f2);

%Se mide la cantidad de operaciones usadas por el método Regula Falsi
[cantidadOperacionesRegulaFalsi2] = regulaFalsiOperaciones(a,b,tol,iteraciones,f2);

%Para error a priori Newton Raphson, se considera r entre [a,b]
% Newton-Raphson
x0 = -0.2;
r = -0.2;
[SNR2,convergenciaNR2,erroresNR2,errorNR2,erroresPrioriNR2,tiempoNewtonRaphson2] = newtonRaphson(x0,tol,iteraciones,f2,df2,d2f1,r);
errorMinimoPrioriNR2 = erroresPrioriNR2(5);

%Se mide la cantidad de operaciones usadas por el método Newton Raphson
[cantidadOperacionesNewtonRaphson2] = newtonRaphsonOperaciones(x0,tol,iteraciones,f2,df2);

% Tabla de costos temporales, espaciales, error y error a priori de cada método para f2
Metodo = {'Bisección';'Secante';'Regula Falsi';'Newton Raphson'};
CostosTemporales = [tiempoBiseccion2; tiempoSecante2; tiempoRegulaFalsi2; tiempoNewtonRaphson2];
CostosEspaciales = [cantidadOperacionesBiseccion2; cantidadOperacionesSecante2; cantidadOperacionesRegulaFalsi2; cantidadOperacionesNewtonRaphson2];
Error = [errorBI2; errorSEC2; errorRF2; errorNR2];
ErrorPriori = [prioriBi2; errorPrioriMinimoSEC2; prioriRF2; errorMinimoPrioriNR2];
T2 = table(Metodo, CostosTemporales, CostosEspaciales, Error, ErrorPriori);

%% Newton multi variable
syms x y z
ecuacion1 = x^2 + y - 37;
ecuacion2 = x - y^2 - 5;
ecuacion3 = x + y + z - 3;
F = [ecuacion1;ecuacion2;ecuacion3];

valoresExactos= [6.0; 1.0; -4.0];

[multiIteraciones,multiErrores,multiRaices,erroresNormales,erroresAbsolutos,erroresRelativos] = newtonMultivariable(F,tol,valoresExactos);

%Newton Multivariable con condicion de parada = Norma 1.
[NMNiteraciones,NMNerrores,NMNraices,NMNerroresNorma1] = newtonMultiNorma1(F,tol,valoresExactos);

%Newton Multivariable con condicion de parada = Norma euclídea
[NMEiteraciones,NMEerrores,NMEraices,NMEerroresEuclideas] = newtonMultiEuclidea(F,tol,valoresExactos);

%Newton Multivariable con condicion de parada = Norma infinita
[NMIiteraciones,NMIerrores,NMIraices,NMIerroresInfinita] = newtonMultiInfinita(F,tol,valoresExactos);

%Se imprimen las tablas creadas anteriormente:
disp("---------------Tabla Resumen Para F1---------------")
T1
disp("---------------Tabla Resumen Para F2---------------")
T2

% Para graficar se forma una matriz que seran los datos de entrada al
% grafico
matrizGrafico = [NMNerroresNorma1(:),NMEerroresEuclideas(:),NMIerroresInfinita(:)];

%Se muestra el gráfico
createfigure(matrizGrafico)