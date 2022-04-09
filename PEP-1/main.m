% se cargan los datos
A = load('A1089.dat');
b = load('b1089.dat');
% p= load('nodos.dat'); %289x2
% e = load('fronteras.dat');%64x7
% t = load('elementos.dat');%512 x 4
% % se trasponen los nodos, frontera y elementos
% p0 = p'; %2x289
% e0 = e';%7x64
% t0 = t';%4 x 512 
%u = linsolve(A,b);

x0 = ones(1089,1); %Vector inicial para el metodo de jacobi

valoresPromedioJacobi = [];
valoresPromedioDoolittle = [];
valoresPromedioGramsch = [];

tiempoIteracionesJacobi = [];
tiempoIteracionesDoolittle = [];
tiempoIteracionesGramsch = [];

costosOperacionalesJacobi = [];
costosOperacionalesDoolittle = [];
costosOperacionalesGramsch = [];

erroresJacobi = [];
erroresDoolittle = [];
erroresGramsch = [];
%se fija la tolerancia
tol = 0.0000000001;

for i=1:100

    % Método Iterativo: Jacobi
    [XJacobi,PasoJacobi,tiempoJacobi] = jacobi(A,b,x0,10000,tol);
    valoresPromedioJacobi = [valoresPromedioJacobi, mean(XJacobi)];
    tiempoIteracionesJacobi = [tiempoIteracionesJacobi, tiempoJacobi];
    operacionesJacobi = jacobiOperaciones(A,b,x0,10000,tol);
    costosOperacionalesJacobi = [costosOperacionalesJacobi, operacionesJacobi];
    %Se calcula el error ||Ax-b||2
    errorJacobi = norm(A*(XJacobi')-b,2);
    erroresJacobi = [erroresJacobi, errorJacobi];

 
    % Método directo: Doolittle
    [LDoo,UDoo,XDoo,tiempoDoolittle] = doolittle(A,b);
    valoresPromedioDoolittle = [valoresPromedioDoolittle, mean(XDoo)];
    tiempoIteracionesDoolittle = [tiempoIteracionesDoolittle, tiempoDoolittle];
    operacionesDoolittle = doolittleOperaciones(A,b);
    costosOperacionalesDoolittle = [costosOperacionalesDoolittle, operacionesDoolittle];
    % Se calcula el error ||Ax-b||2
    errorDoolittle = norm(A*XDoo-b,2);
    erroresDoolittle = [erroresDoolittle, errorDoolittle];

    % Método de ecuaciones normales/Ortogonales: Gram Schmidt Modificado
    [QGram,RGram,XGram,tiempoGramsch] = gramsch(A,b);
    valoresPromedioGramsch = [valoresPromedioGramsch, mean(XGram)];
    tiempoIteracionesGramsch = [tiempoIteracionesGramsch, tiempoGramsch];
    operacionesGramsch = gramschOperaciones(A,b);
    costosOperacionalesGramsch = [costosOperacionalesGramsch, operacionesGramsch];
    % Se calcula el error ||Ax-b||2
    errorGramsch = norm(A*XGram-b,2);
    erroresGramsch = [erroresGramsch, errorGramsch];

   %Se rota el b
   b = circshift(b,1);

end

%Se grafican los valores promedio
arrayValoresPromedio = [valoresPromedioJacobi(:),valoresPromedioDoolittle(:),valoresPromedioGramsch(:)];
%Se muestra el grafico de los valores promedio
createfigure(arrayValoresPromedio)

%Se grafican los costos temporales en segundos de cada método

arrayCostosTemporales = [tiempoIteracionesJacobi(:),tiempoIteracionesDoolittle(:),tiempoIteracionesGramsch(:)];
createfigure1(arrayCostosTemporales)

%Se grafican los costos operacionales de cada método

arrayCostosOperacionales = [costosOperacionalesJacobi(:),costosOperacionalesDoolittle(:),costosOperacionalesGramsch(:)];
createfigure2(arrayCostosOperacionales)


%Se grafican los errores calculados de cada método

arrayErrores = [erroresJacobi(:),erroresDoolittle(:),erroresGramsch(:)];
createfigure3(arrayErrores)




%se hace el grafico
% [ux,uy] = pdegrad(p0,t0,u); % Calculate gradient
% ugrad = [ux;uy];
% h = pdeplot(p0,e0,t0,'xydata',u,'zdata',u,...
%     'colormap','jet','mesh','on','flowdata',ugrad)
