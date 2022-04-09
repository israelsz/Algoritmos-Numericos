%Nota el dataset contempla 589 dias desde que se empezo a registrar datos

datos = importfile("Comorbilidad.csv"); %Carga de datos del archivo csv
%Se calculan los casos diarios para todas las enfermedades
diario = datos(:,2:end) - datos(:,1:end-1);


%Se grafica para mostrar el error de origen que tienen los datos
figure();
hold on
plot(diario(13,:)');
title('Casos diarios de diabeticos hospitalizados');
hold off


% Se hace un ajuste a los datos usando ventana movil con convolucion para suavizar errores de
% origen
arregloAjustado = [];
for i=1:22
    aproximacion2 = ceil(conv(diario(i,:),[1 1 1 1 1 1 1 1 1 1]/10)); %ventanas de 1 mes
    arregloAjustado = vertcat(arregloAjustado,aproximacion2);
end

%Se grafica para mostrar como cambio al ajustar
figure();
hold on
plot(diario(13,:)');
plot(arregloAjustado(13,:)');
title('Comparacion Ajuste vs Original');
legend({'Original', 'Ajustado'}, 'Location','northeast');
hold off


%Se aplica interpolacion para conseguir datos diarios a los datos ajustados
arregloInterpolado1 = [];
for i=1:22
    x=1:1:size(arregloAjustado,2);
    xq=1:0.2971:size(arregloAjustado,2); % 0.29 conseguido de dividir 175 en los 589 dias de datos disponibles
    aproximacion = interp1(x,arregloAjustado(i,:),xq,'spline');
    arregloInterpolado1 = vertcat(arregloInterpolado1,aproximacion);
end

arregloInterpolado2 = [];
for i=1:22
    x=1:1:size(arregloAjustado,2);
    xq=1:0.2971:size(arregloAjustado,2); % 0.29 conseguido de dividir 175 en los 589 dias de datos disponibles
    aproximacion = interp1(x,arregloAjustado(i,:),xq,'makima');
    arregloInterpolado2 = vertcat(arregloInterpolado2,aproximacion);
end

arregloInterpolado3 = [];
for i=1:22
    x=1:1:size(arregloAjustado,2);
    xq=1:0.2971:size(arregloAjustado,2); % 0.29 conseguido de dividir 175 en los 589 dias de datos disponibles
    aproximacion = interp1(x,arregloAjustado(i,:),xq,'linear');
    arregloInterpolado3 = vertcat(arregloInterpolado3,aproximacion);
end


%Grafico de comparacion entre los tres metodos de interpolacion aplicadas
figure();
hold on
plot(arregloInterpolado1(13,:)');
plot(arregloInterpolado2(13,:)');
plot(arregloInterpolado3(13,:)');
title('Comparacion Spline vs Makima vs Linear');
legend({'Spline', 'Makima', 'Linear'}, 'Location','northeast');
hold off


%Se aplica interpolacion esta vez en los datos sin ajustar a fin de
%comparar
arregloInterpoladoSinAjuste1 = [];
for i=1:22
    x=1:1:size(diario,2);
    xq=1:0.2818:size(diario,2); % 0.28 conseguido de dividir 166 en los 589 dias de datos disponibles
    aproximacion = interp1(x,diario(i,:),xq,'spline');
    arregloInterpoladoSinAjuste1 = vertcat(arregloInterpoladoSinAjuste1,aproximacion);
end

arregloInterpoladoSinAjuste2 = [];
for i=1:22
    x=1:1:size(diario,2);
    xq=1:0.2818:size(diario,2); % 0.28 conseguido de dividir 166 en los 589 dias de datos disponibles
    aproximacion = interp1(x,diario(i,:),xq,'makima');
    arregloInterpoladoSinAjuste2 = vertcat(arregloInterpoladoSinAjuste2,aproximacion);
end

arregloInterpoladoSinAjuste3 = [];
for i=1:22
    x=1:1:size(diario,2);
    xq=1:0.2818:size(diario,2); % 0.28 conseguido de dividir 166 en los 589 dias de datos disponibles
    aproximacion = interp1(x,diario(i,:),xq,'linear');
    arregloInterpoladoSinAjuste3 = vertcat(arregloInterpoladoSinAjuste3,aproximacion);
end


%Se integra para medir eficiencia
totalDatos = 0;
totalAjustado = 0;
integralMetodo1 = 0;
integralMetodo2 = 0;
integralMetodo3 = 0;

integralMetodo1SinAjuste = 0;
integralMetodo2SinAjuste = 0;
integralMetodo3SinAjuste = 0;

for i=1:22
    totalDatos = totalDatos + ceil(trapz(diario(i,:)));
    totalAjustado = totalAjustado + ceil(trapz(arregloAjustado(i,:)));
    integralMetodo1 = integralMetodo1 + ceil(trapz(arregloInterpolado1(i,:))*0.2971);
    integralMetodo2 = integralMetodo2 + ceil(trapz(arregloInterpolado2(i,:))*0.2971);
    integralMetodo3 = integralMetodo3 + ceil(trapz(arregloInterpolado3(i,:))*0.2971);

    integralMetodo1SinAjuste = integralMetodo1SinAjuste + ceil(trapz(arregloInterpoladoSinAjuste1(i,:))*0.2971);
    integralMetodo2SinAjuste = integralMetodo2SinAjuste + ceil(trapz(arregloInterpoladoSinAjuste2(i,:))*0.2971);
    integralMetodo3SinAjuste = integralMetodo3SinAjuste + ceil(trapz(arregloInterpoladoSinAjuste3(i,:))*0.2971);
end


%Diferencia en la aproximacion en comparacion a datos sin ajustar/suavizar
diferenciaDiarioSpline = abs(totalDatos - integralMetodo1)
diferenciaDiarioMakima= abs(totalDatos - integralMetodo2)
diferenciaDiarioLineal = abs(totalDatos- integralMetodo3)

%Diferencia en la aproximacion en comparacion a curva suavizada/ajustada
diferenciaAjusteSpline = abs(totalAjustado - integralMetodo1)
diferenciaAjusteMakima= abs(totalAjustado - integralMetodo2)
diferenciaAjusteLineal = abs(totalAjustado - integralMetodo3)


%Se hace una extrapolacion para intentar "predecir" datos, se realiza
%interpolando 2/3 de los datos y dejando predecir el ultimo tercio
x=1:1:116;
xq=1:0.2971:size(arregloAjustado,2); % 0.28 conseguido de dividir 166 en los 589 dias
prediccion = interp1(x,arregloAjustado(13,1:116),xq,'spline','extrap');

%Grafico de extrapolación "prediccion" de tercer periodos dados dos periodos
figure();
hold on
plot(arregloInterpolado1(13,:)');
plot(prediccion(1,:)');
title('Comparacion Interpolación vs Prediccion con 2/3 de los datos');
legend({'Spline', 'Prediccion/Extrapolacion'}, 'Location','northeast');
xline(400,'-',{'Inicio','extrapolación'});
hold off
 
%% Inicio de Análisis de datos usando un arreglo aproximado, metodo de aproximacion lineal
%Se dividen 3 periodos de 8 meses
contagiadosPrimerPeriodo = [];
contagiadosSegundoPeriodo = [];
contagiadosTercerPeriodo = [];

for i=1:22
    contagiadosPrimerPeriodo = [contagiadosPrimerPeriodo,ceil(trapz(arregloInterpolado3(i,1:195)))];
    contagiadosSegundoPeriodo = [contagiadosSegundoPeriodo,ceil(trapz(arregloInterpolado3(i,196:390)))];
    contagiadosTercerPeriodo = [contagiadosTercerPeriodo,ceil(trapz(arregloInterpolado3(i,391:586)))];
end

% Se calcula el porcentaje de hospitalizados por enfermedad para cada
% periodo
porcentajeHospitalizadosPrimerPeriodo = [];
porcentajeHospitalizadosSegundoPeriodo = [];
porcentajeHospitalizadosTercerPeriodo = [];

for i=1:11
    % Cantidad Hospitalizados / Cantidad total de contagiados
    porcentaje = contagiadosPrimerPeriodo(i+11)/(contagiadosPrimerPeriodo(i) + contagiadosPrimerPeriodo(i+11));
    porcentaje2 = contagiadosSegundoPeriodo(i+11)/(contagiadosSegundoPeriodo(i) + contagiadosSegundoPeriodo(i+11));
    porcentaje3 = contagiadosTercerPeriodo(i+11)/(contagiadosTercerPeriodo(i) + contagiadosTercerPeriodo(i+11));

    porcentajeHospitalizadosPrimerPeriodo = [porcentajeHospitalizadosPrimerPeriodo,porcentaje];
    porcentajeHospitalizadosSegundoPeriodo = [porcentajeHospitalizadosSegundoPeriodo,porcentaje2];
    porcentajeHospitalizadosTercerPeriodo = [porcentajeHospitalizadosTercerPeriodo,porcentaje3];
end


%Grafico resumen de todas las enfermedades cronicas divididas en los tres
%periodos de tiempo
figure();
y = [porcentajeHospitalizadosPrimerPeriodo; porcentajeHospitalizadosSegundoPeriodo; porcentajeHospitalizadosTercerPeriodo];
h = bar(y,1);                                                  
for k1 = 1:size(y,2)
    ctr(k1,:) = bsxfun(@plus, h(1).XData, h(k1).XOffset');   
    ydt(k1,:) = h(k1).YData;                                     
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.3f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',8, 'Color','b')
end
set(h, {'DisplayName'}, {'Hipertensión arterial','Diabetes','Obesidad','Asma','Enfermedad cardiovascular','Enfermedad pulmonar crónica','Cardiopatía crónica','Enfermedad renal crónica','Enfermedad neurológica crónica','Inmunocomprometido','Enfermedad hepática crónica'}')
title({'Comparación probabilidad de hospitalización por patología crónica'});
legend();

%Calculo de probabilidad global para cada enfermedad
contagiosTotales = [];
for i=1:22
    contagiosTotales = [contagiosTotales,trapz(arregloInterpolado3(i,:))];
end

probabilidadHospitalizacionTotal  = [];
for i=1:11
     porcentaje = contagiosTotales(i+11)/(contagiosTotales(i) + contagiosTotales(i+11));
     probabilidadHospitalizacionTotal = [probabilidadHospitalizacionTotal,porcentaje];
end

%Grafico global
figure()
X = categorical({'Hipertensión arterial','Diabetes','Obesidad','Asma','Enfermedad cardiovascular','Enfermedad pulmonar crónica','Cardiopatía crónica','Enfermedad renal crónica','Enfermedad neurológica crónica','Inmunocomprometido','Enfermedad hepática crónica'});
X = reordercats(X,{'Hipertensión arterial','Diabetes','Obesidad','Asma','Enfermedad cardiovascular','Enfermedad pulmonar crónica','Cardiopatía crónica','Enfermedad renal crónica','Enfermedad neurológica crónica','Inmunocomprometido','Enfermedad hepática crónica'});
Y = probabilidadHospitalizacionTotal;
graficoGlobal = bar(X,diag(Y),'stacked');
text(1:length(Y),Y,num2str(Y'),'vert','bottom','horiz','center');
title({'Probabilidad de hospitalización por patología crónica desde el inicio de la pandemia hasta Enero 2022'});
box off

%% Comparacion usando los datos sin ajustar

%Se dividen 3 periodos de 8 meses
contagiadosPrimerPeriodo2 = [];
contagiadosSegundoPeriodo2 = [];
contagiadosTercerPeriodo2 = [];

for i=1:22
    contagiadosPrimerPeriodo2 = [contagiadosPrimerPeriodo2,sum(diario(i,1:55))];
    contagiadosSegundoPeriodo2 = [contagiadosSegundoPeriodo2,sum(diario(i,56:110))];
    contagiadosTercerPeriodo2 = [contagiadosTercerPeriodo2,sum(diario(i,111:166))];
end

% Se calcula el porcentaje de hospitalizados por enfermedad para cada
% periodo
porcentajeHospitalizadosPrimerPeriodo2 = [];
porcentajeHospitalizadosSegundoPeriodo2 = [];
porcentajeHospitalizadosTercerPeriodo2 = [];

for i=1:11
    % Cantidad Hospitalizados / Cantidad total de contagiados
    porcentajev2 = contagiadosPrimerPeriodo2(i+11)/(contagiadosPrimerPeriodo2(i) + contagiadosPrimerPeriodo2(i+11));
    porcentajev22 = contagiadosSegundoPeriodo2(i+11)/(contagiadosSegundoPeriodo2(i) + contagiadosSegundoPeriodo2(i+11));
    porcentajev23 = contagiadosTercerPeriodo2(i+11)/(contagiadosTercerPeriodo2(i) + contagiadosTercerPeriodo2(i+11));

    porcentajeHospitalizadosPrimerPeriodo2 = [porcentajeHospitalizadosPrimerPeriodo2,porcentajev2];
    porcentajeHospitalizadosSegundoPeriodo2 = [porcentajeHospitalizadosSegundoPeriodo2,porcentajev22];
    porcentajeHospitalizadosTercerPeriodo2 = [porcentajeHospitalizadosTercerPeriodo2,porcentajev23];
end


%Grafico resumen de todas las enfermedades cronicas divididas en los tres
%periodos de tiempo
figure()
y = [porcentajeHospitalizadosPrimerPeriodo2; porcentajeHospitalizadosSegundoPeriodo2; porcentajeHospitalizadosTercerPeriodo2];
h = bar(y,1);                                                  
for k1 = 1:size(y,2)
    ctr(k1,:) = bsxfun(@plus, h(1).XData, h(k1).XOffset');   
    ydt(k1,:) = h(k1).YData;                                     
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.3f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',8, 'Color','b')
end
set(h, {'DisplayName'}, {'Hipertensión arterial','Diabetes','Obesidad','Asma','Enfermedad cardiovascular','Enfermedad pulmonar crónica','Cardiopatía crónica','Enfermedad renal crónica','Enfermedad neurológica crónica','Inmunocomprometido','Enfermedad hepática crónica'}');
title({'Comparación probabilidad de hospitalización por patología crónica V2'});
legend();

%Calculo de probabilidad global para cada enfermedad
contagiosTotales2 = [];
for i=1:22
    contagiosTotales2 = [contagiosTotales2,trapz(arregloInterpolado3(i,:))];
end

probabilidadHospitalizacionTotal2  = [];
for i=1:11
     porcentaje = contagiosTotales2(i+11)/(contagiosTotales2(i) + contagiosTotales2(i+11));
     probabilidadHospitalizacionTotal2 = [probabilidadHospitalizacionTotal2,porcentaje];
end

%Grafico global
figure();
X = categorical({'Hipertensión arterial','Diabetes','Obesidad','Asma','Enfermedad cardiovascular','Enfermedad pulmonar crónica','Cardiopatía crónica','Enfermedad renal crónica','Enfermedad neurológica crónica','Inmunocomprometido','Enfermedad hepática crónica'});
X = reordercats(X,{'Hipertensión arterial','Diabetes','Obesidad','Asma','Enfermedad cardiovascular','Enfermedad pulmonar crónica','Cardiopatía crónica','Enfermedad renal crónica','Enfermedad neurológica crónica','Inmunocomprometido','Enfermedad hepática crónica'});
Y = probabilidadHospitalizacionTotal2;
graficoGlobal = bar(X,diag(Y),'stacked');
text(1:length(Y),Y,num2str(Y'),'vert','bottom','horiz','center');
title({'Probabilidad de hospitalización por patología crónica desde el inicio de la pandemia hasta Enero 2022 V2'});
box off

