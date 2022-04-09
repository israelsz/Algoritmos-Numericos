datos = importfile("Comorbilidad.csv"); %Carga de datos del archivo csv
%Se calculan los casos diarios para todas las enfermedades
diario = datos(:,2:end) - datos(:,1:end-1);

% Se hace un ajuste a los datos usando ventana movil con convolucion para suavizar errores de
% origen
arregloAjustado = [];
for i=1:22
    aproximacion2 = ceil(conv(diario(i,:),[1 1 1 1 1 1 1 1 1 1]/10)); %ventanas
    arregloAjustado = vertcat(arregloAjustado,aproximacion2);
end

%Grafica a la cual se le buscara ajustar sus coeficientes
figure();
hold on
plot(arregloAjustado(9,:)');
title('Enfermedad renal cronica no hospitalizados');
hold off

x = 1:1:175; % Eje x donde se graficaran la curva obtenida del coeficiente
s=arregloAjustado(9,:);

p=@(a0,a1,a2,a3,x) a0 + a1*x + a2*power(x,2) + a3*power(x,3); % polinomio grado 3
p2=@(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,x) a0 + a1*x + a2*power(x,2) + a3*power(x,3) + a4*power(x,4) + a5*power(x,5) + a6*power(x,6) + a7*power(x,7) + a8*power(x,8) + a9*power(x,9); % polinomio grado 9
p3=@(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,x) a0 + a1*x + a2*power(x,2) + a3*power(x,3) + a4*power(x,4) + a5*power(x,5) + a6*power(x,6) + a7*power(x,7) + a8*power(x,8) + a9*power(x,9) + a10*power(x,10) + a11*power(x,11) + a12*power(x,12) + a13*power(x,13) + a14*power(x,14) + a15*power(x,15) + a16*power(x,16) + a17*power(x,17) + a18*power(x,18); % polinomio grado 18

tol = 0.00000000001;

%Se inician las simulaciones de Monte Carlo
[mejorError3,mejoresCoeficientes3,mejorAproximacion3,tiempo3] = coeficiente3(p,s,x,tol);
[mejorError9,mejoresCoeficientes9,mejorAproximacion9,tiempo9] = coeficiente9(p2,s,x,tol);
[mejorError18,mejoresCoeficientes18,mejorAproximacion18,tiempo18] = coeficiente18(p3,s,x,tol);

%Graficas de diferencia entre curva real vs curva conseguida
figure();
hold on
plot(arregloAjustado(9,:)');
plot(mejorAproximacion3(1,:)');
title('Enfermedad renal cronica no hospitalizados');
legend({'Original', 'Polinomio Grado 3'}, 'Location','northeast');
hold off

figure();
hold on
plot(arregloAjustado(9,:)');
plot(mejorAproximacion9(1,:)');
title('Enfermedad renal cronica no hospitalizados');
legend({'Original', 'Polinomio Grado 9'}, 'Location','northeast');
hold off

figure();
hold on
plot(arregloAjustado(9,:)');
plot(mejorAproximacion18(1,:)');
title('Enfermedad renal cronica no hospitalizados');
legend({'Original', 'Polinomio Grado 18'}, 'Location','northeast');
hold off

%Se grafica el tiempo empleado en cada simulacion

graficoTiempo = [tiempo3,tiempo9,tiempo18];
figure();
hold on
plot(graficoTiempo(1,:)');
title('Tiempo ocupado por cada simulación');
hold off


%Se grafican los errores
errores = [mejorError3,mejorError9,mejorError18];
figure();
Xgraf = categorical({'Polinomio Grado 3','Polinomio Grado 9','Polinomio Grado 18'});
Xgraf = reordercats(Xgraf,{'Polinomio Grado 3','Polinomio Grado 9','Polinomio Grado 18'});
bar(Xgraf,errores)
text(1:length(errores),errores,num2str(errores'),'vert','bottom','horiz','center'); 
title('Comparación de errores obtenidos');
box off

%% Graficos de prueba de generadores

% rng(0,"twister");
% a=-500;
% b=500;
% c=1000;
% x=[];
% y=[];
% 
% x = (b-a).*rand(c,1) + a;
% y = (b-a).*rand(c,1) + a;
% 
% x = x';
% y = y';
% 
% figure();
% scatter(x,y,15,'filled')
% 
% 
% seed = 35;
% modulo = 131;
% multiplicador = 21;
% incremento = 31;
% cantidadNumeros = 1000;
% min = -500;
% max = 500;
% 
% [x1,seed] = generadorCongruencialLineal(seed,modulo,multiplicador,incremento,cantidadNumeros,min,max);
% [y1,seed] = generadorCongruencialLineal(seed,modulo,multiplicador,incremento,cantidadNumeros,min,max);
% 
% x1 = x1';
% y1 = y1';
% 
% figure();
% scatter(x1,y1,15,'filled')
% 
% seed = 35;
% modulo = 42;
% multiplicador = 21;
% incremento = 31;
% cantidadNumeros = 1000;
% min = -500;
% max = 500;
% 
% [x2,seed] = generadorCongruencialAditivo(seed,modulo,incremento,cantidadNumeros,min,max);
% [y2,seed] = generadorCongruencialAditivo(seed,modulo,incremento,cantidadNumeros,min,max);
% 
% x2 = x2';
% y2 = y2';
% 
% figure();
% scatter(x2,y2,15,'filled')
% 


